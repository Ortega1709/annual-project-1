import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:e_commerce/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/app_router_config.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<ProductBloc>()),
        BlocProvider(create: (_) => serviceLocator<CartBloc>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()..add(const UserSessionCheckEvent())),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // debugPrint('refreshing router');
          // AppRouterConfig(serviceLocator()).router.refresh();
        },
        child: MaterialApp.router(
          title: 'e-commerce',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          routerConfig: AppRouterConfig(serviceLocator()).router,
        ),
      ),
    );
  }
}
