import 'package:e_commerce/e-commerce-app.dart';
import 'package:e_commerce/init_dependencies.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const ECommerceApp());
}
