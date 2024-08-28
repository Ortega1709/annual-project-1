import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/features/account/presentation/widgets/account_tile.dart';
import 'package:e_commerce/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final preferences = serviceLocator<SharedPreferences>();
    final isAuthenticated = preferences.getBool('authentication') ?? false;

    return Scaffold(
      appBar: AppBar(
        title: isAuthenticated ? const Text("Compte") : const Text(''),
        actions: [
          isAuthenticated
              ? TextButton(
                  onPressed: () {
                    serviceLocator<SharedPreferences>().clear();
                    context.go('/sign-in');
                  },
                  child: const Text('Se déconnecter'),
                )
              : const SizedBox(),
          const SizedBox(width: AppDimen.p8)
        ],
      ),
      body: isAuthenticated
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimen.p24),
                  AccountTile(
                    email: preferences.getString('email'),
                    name: preferences.getString('name'),
                    profilePicture: preferences.getString('profil'),
                  )
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppDimen.p24),
                  child: Text(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    'Connectez-vous ou inscrivez-vous dès maintenant pour découvrir tout ce que nous avons à offrir.',
                  ),
                ),
                const SizedBox(height: AppDimen.p24),
                Center(
                  child: MButton(
                    text: 'Se connecter',
                    onPressed: () {
                      context.go('/sign-in');
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
