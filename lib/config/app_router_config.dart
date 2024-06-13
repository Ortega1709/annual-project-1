import 'package:e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/register_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_details.dart';
import 'package:e_commerce/features/product/presentation/screens/product_discovery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_color.dart';

class AppRouterConfig {
  late final router = GoRouter(
    routes: [
      GoRoute(
        path: '/'
            '',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: ProductDiscovery(),
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: '/products/:id',
        builder: (context, state) {
          return AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: ProductDetails(
              productId: state.pathParameters["id"]!,
            ),
          );
        },
      ),
    ],
  );
}
