import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _villeController = TextEditingController();
  final _communeController = TextEditingController();
  final _adresseController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _villeController.dispose();
    _communeController.dispose();
    _adresseController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is SignUpWithGoogleSuccessState) {
            Messages.success('Authentification', 'Enregistrement réussie 🎉', context);
            context.go('/');
          }
          if (state is SignUpWithGoogleErrorState) {
            Messages.error('Authentification', state.error, context);
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimen.p16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimen.p16),
                    child: Text(
                      "Complétez votre profil",
                      textAlign: TextAlign.left,
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  const SizedBox(height: AppDimen.p24),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimen.p16),
                    child: Text(
                      textAlign: TextAlign.left,
                      "Insérez correctement vos informations personnelles.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: AppColor.greyColor),
                    ),
                  ),
                  const SizedBox(height: AppDimen.p16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimen.p16),
                    child: TextFormField(
                      controller: _villeController,
                      decoration: const InputDecoration(
                        hintText: 'Ville',
                        fillColor: AppColor.grayColor,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez renseigner cette information.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimen.p16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimen.p16),
                    child: TextFormField(
                      controller: _communeController,
                      decoration: const InputDecoration(
                        fillColor: AppColor.grayColor,
                        filled: true,
                        hintText: 'Commune',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez renseigner cette information.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: AppDimen.p16),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppDimen.p16),
                    child: TextFormField(
                      controller: _adresseController,
                      decoration: const InputDecoration(
                        hintText: 'Avenue',
                        filled: true,
                        fillColor: AppColor.grayColor,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Veuillez renseigner cette information.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
        child: MButton(
          text: "Terminer",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                    SignUpWithGoogleEvent(
                      ville: _villeController.text.trim(),
                      commune: _communeController.text.trim(),
                      adresse: _adresseController.text.trim(),
                    ),
                  );
            }
          },
        ),
      ),
    );
  }
}
