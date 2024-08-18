import 'package:e_commerce/core/shared/cubits/user_session_cubit.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:e_commerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:e_commerce/features/cart/presentation/screens/cart_list_screen.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/presentation/screens/product_details_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_discovery_list_screen.dart';
import 'package:e_commerce/features/product/presentation/screens/product_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_color.dart';
import '../features/index.dart';

class AppRouterConfig {
  final UserSessionCubit userSessionCubit;
  AppRouterConfig(this.userSessionCubit);

  GoRouter get router => GoRouter(
    initialLocation: '/sign-in',
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
        path: '/sign-in',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: SignInScreen(),
          );
        },
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) {
          return const AnnotatedRegion(
            value: SystemUiOverlayStyle(
              statusBarColor: AppColor.backgroundColor,
              systemNavigationBarColor: AppColor.backgroundColor,
            ),
            child: SignUpScreen(),
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
    redirect: (context, state) {
          final bool isLoggedIn = userSessionCubit.state;
          final isGoingToSignIn = state.matchedLocation == '/sign-in';

          if (!isLoggedIn && !isGoingToSignIn) {
            return '/sign-in';
          }
          if (isLoggedIn && isGoingToSignIn) {
            return '/home';
          }
          return null;
        },
  );
}
