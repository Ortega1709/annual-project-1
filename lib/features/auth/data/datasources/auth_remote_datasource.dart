import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';
import 'package:e_commerce/features/auth/services/google_sign_in_service.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserModel?> signIn();
  Future<void> signOut();
  Future<UserModel?> signUp({required UserModel userModel});
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final PocketBase pocketBase;
  final SharedPreferences sharedPreferences;

  AuthRemoteDatasourceImpl({
    required this.pocketBase,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel?> signIn() async {
    try {
      final googleUser = await GoogleSignInService.instance.signIn();
      if (googleUser != null) {
        // if user is authenticated with google provider
        // get his access token.
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final String accessToken = googleAuth.accessToken!;

        // store access token in shared preferences
        sharedPreferences.setString('google_access_token', accessToken);

        // check if user is authenticated with pocketbase
        final googleUserEmail = googleUser.email;
        final googleUserProfil = googleUser.photoUrl;
        final googleUserName = googleUser.displayName;

        final pocketUserList = await pocketBase
            .collection('users')
            .getList(filter: 'email = "$googleUserEmail"');

        if (pocketUserList.items.isEmpty) {
          // if user does not exist in pocketbase, create a new user
          sharedPreferences.setBool('authentication', false);

          // register user email and name in shared preferences
          sharedPreferences.setString('email', googleUserEmail);
          sharedPreferences.setString('name', googleUserName!);
          sharedPreferences.setString('profil', googleUserProfil!);

          return null;
        } else {
          // if user exists in pocketbase, update his authentication
          // type to authenticated and store his id
          sharedPreferences.setBool('authentication', true);
          sharedPreferences.setString('id', pocketUserList.items.first.id);

          // register user email and name in shared preferences
          sharedPreferences.setString('email', googleUserEmail);
          sharedPreferences.setString('name', googleUserName!);
          sharedPreferences.setString('profil', googleUserProfil!);
          
          return UserModel.fromJson(pocketUserList.items.first.data).copyWith(
              id: pocketUserList.items.first.id,
              created: pocketUserList.items.first.created);
        }
      }
    } catch (e) {
      debugPrint("[x] Error signing in: $e");
      throw ServerException(e.toString());
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    try {
      // sign out from google and clear shared preferences
      await GoogleSignInService.instance.signOut();
      sharedPreferences.clear();
      debugPrint('[✓] User signed out');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> signUp({required UserModel userModel}) async {
    try {
      final userRegistered =
          await pocketBase.collection('users').create(body: userModel.toJson());

      sharedPreferences.setBool('authentication', true);
      sharedPreferences.setString('id', userRegistered.id);

      return UserModel.fromJson(userRegistered.data).copyWith(
        id: userRegistered.id,
        created: userRegistered.created,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
