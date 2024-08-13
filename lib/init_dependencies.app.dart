part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  await dotenv.load();
  Stripe.publishableKey = Secrets.stripePublishKey;


  _initSVG();
  _product();
  _cart();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartModelAdapter());

  final cartBox = await Hive.openBox<CartModel>('cart');
  final pocketbase = PocketBase(Secrets.pocketbaseUrl);

  serviceLocator.registerLazySingleton(() => pocketbase);
  serviceLocator.registerLazySingleton(() => cartBox);
}

void _initSVG() async {
  await preloadSVG([
    'assets/svg/vegetable-1.svg',
    'assets/svg/vegetable-2.svg',
    'assets/svg/vegetable-3.svg',
  ]);
}

void _cart() {
  serviceLocator
    ..registerFactory<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<CartRepository>(
      () => CartRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetCartItems(serviceLocator()),
    )
    ..registerFactory(
      () => AddItemToCart(serviceLocator()),
    )
    ..registerFactory(
      () => DeleteItemToCart(serviceLocator()),
    )
    ..registerLazySingleton(
      () => CartBloc(
        getCartItems: serviceLocator(),
        addItemToCart: serviceLocator(),
        deleteItemToCart: serviceLocator(),
      ),
    );
}

void _product() {
  serviceLocator
    ..registerFactory<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetProducts(serviceLocator()),
    )
    ..registerFactory(
      () => GetProductsByCategoryNum(serviceLocator()),
    )
    ..registerLazySingleton(
      () => ProductBloc(
        getProducts: serviceLocator(),
      ),
    );
}

