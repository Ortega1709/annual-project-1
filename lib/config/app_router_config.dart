import 'package:e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/register_screen.dart';
import 'package:e_commerce/features/cart/presentation/screens/cart_list_screen.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/presentation/screens/product_details_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_discovery_list_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_discovery_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_color.dart';
import '../features/index.dart';

class AppRouterConfig {
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: Index(),
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
        path: '/product-details',
        builder: (context, state) {
          final product = state.extra as Product;
          return AnnotatedRegion(
            value: const SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: ProductDetailsScreen(product: product),
          );
        },
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) {
          return const AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: AppColor.backgroundColor,
                systemNavigationBarColor: AppColor.backgroundColor,
              ),
              child: CartListScreen());
        },
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) {
          return const AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: AppColor.backgroundColor,
                systemNavigationBarColor: AppColor.backgroundColor,
              ),
              child: ProductSearchScreen());
        },
      ),
      GoRoute(
        path: '/discovery',
        builder: (context, state) {
          return const AnnotatedRegion(
              value: SystemUiOverlayStyle(
                statusBarColor: AppColor.backgroundColor,
                systemNavigationBarColor: AppColor.backgroundColor,
              ),
              child: ProductDiscoveryListScreen());
        },
      ),
    ],
  );
}
