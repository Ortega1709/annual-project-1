import 'dart:developer';

import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/shared/widgets/m_outlined_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../services/google_sign_in_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppDimen.p16),
              child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipOval(
                    child: SvgPicture.asset(
                      'assets/svg/vegetable-3.svg',
                    ),
                  )),
            ),
            const SizedBox(height: AppDimen.p24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.p16),
              child: Text(
                "Bienvenue 👋 !",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: AppDimen.p24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.p16),
              child: Text(
                textAlign: TextAlign.left,
                "Inscrivez-vous dès aujourd'hui pour bénéficier d'une expérience de shopping personnalisée, avec des recommandations sur mesure, des offres exclusives, et une livraison rapide pour vos achats quotidiens.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor.greyColor),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MButton(
              text: 'Continuer avec google',
              onPressed: signIn,
            ),
            const SizedBox(height: AppDimen.p8),
            MOutlinedButton(
              text: 'Continuer sans compte',
              onPressed: signOut,
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInService.instance.signIn();
    if (user == null) {
      Messages.error("Authentifcation", "Error authentication", context);
    } else {
      final GoogleSignInAuthentication googleAuth = await user.authentication;
      if (googleAuth.accessToken != null) {
      }

      Messages.success("Authentifcation", "Success authentication", context);
    }
  }

  Future signOut() async {
    final user = await GoogleSignInService.instance.signOut();
    if (user == null) {
      Messages.error("Authentifcation", "Success sign out", context);
    } else {
      Messages.success("Authentifcation", "Error sign out", context);
    }
  }
}
