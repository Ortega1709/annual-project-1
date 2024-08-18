import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/shared/widgets/m_outlined_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignInWithGoogleErrorState) {
            Messages.error("Authentification", "Erreur d'authentification", context);
          } 

          if (state is SignInWithGoogleSuccessState) {
            Messages.success("Authentification", "Authentification réussie", context);

            // if user is null it means user has not registered yet, go to registration screen
            if (state.user == null) { context.push('/sign-up'); }
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
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
          );
        },
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    context.read<AuthBloc>().add(const SignInWithGoogleEvent());
  }

  Future signOut() async {}
}
