
import 'dart:developer';

import 'package:e_commerce/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';
import 'package:e_commerce/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/delete_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/get_cart_items.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/product/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/data/repositories/product_repository_impl.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:e_commerce/features/product/domain/usecases/get_products.dart';
import 'package:e_commerce/features/product/domain/usecases/get_products_by_category_num.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pocketbase/pocketbase.dart';

import 'core/utils/preload_svg.dart';
import 'core/utils/secrets.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

part 'init_dependencies.app.dart';