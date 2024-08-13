import 'dart:developer';

import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SvgPicture.asset(
                'assets/svg/vegetable-3.svg',
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: MButton(
          text: 'Continuer avec google',
          onPressed: signIn,
        ),
      ),
    );
  }

  Future signIn() async {
    final user = await GoogleSignInService.instance.signIn();
    if (user == null) {
      print("User is null");
      Messages.error("Authentication", "Error authentication", context);
    } else {
      print("User is $user");
      Messages.success("Authentication", "Success authentication", context);
    }
  }
}
