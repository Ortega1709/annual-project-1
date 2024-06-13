import 'package:e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'config/app_router_config.dart';

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'e-commerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouterConfig().router,
    );
  }
}
