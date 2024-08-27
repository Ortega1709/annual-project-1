part of 'init_dependencies.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> initDependencies() async {
  await dotenv.load();
  Stripe.publishableKey = Secrets.stripePublishKey;

  _initSVG();
  _auth();
  _product();
  _cart();

  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CartModelAdapter());

  final cartBox = await Hive.openBox<CartModel>('cart');
  final sharedPreferences = await SharedPreferences.getInstance();
  final pocketbase = PocketBase(Secrets.pocketbaseUrl);

  serviceLocator.registerLazySingleton(() => pocketbase);
  serviceLocator.registerLazySingleton(() => cartBox);
  serviceLocator.registerLazySingleton(() => sharedPreferences);
}

void _initSVG() async {
  await preloadSVG([
    'assets/svg/vegetable-2.svg',
    'assets/svg/vegetable-3.svg',
    'assets/svg/empty-cart.svg',
  ]);
}

void _cart() {
  serviceLocator
    ..registerFactory<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<CommandeRemoteDataSource>(
      () => CommandeRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerFactory<CartRepository>(
      () => CartRepositoryImpl(serviceLocator()),
    )
    ..registerFactory<CommandeRepository>(
      () => CommandeRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => GetCartItems(serviceLocator()),
    )
    ..registerFactory(
      () => ConfirmOrder(serviceLocator()),
    )
    ..registerFactory(
      () => AddItemToCart(serviceLocator()),
    )
    ..registerFactory(
      () => DeleteItemToCart(serviceLocator()),
    )
    ..registerFactory(
      () => AddOrder(serviceLocator()),
    )
    ..registerFactory(
      () => GetOrderByUserId(serviceLocator()),
    )
    ..registerLazySingleton(
      () => CartBloc(
        getCartItems: serviceLocator(),
        getOrderByUserId: serviceLocator(),
        confirmOrder: serviceLocator(),
        addItemToCart: serviceLocator(),
        deleteItemToCart: serviceLocator(),
        addOrder: serviceLocator(),
        sharedPreferences: serviceLocator(),
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

void _auth() {
  serviceLocator
    ..registerFactory<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(
        pocketBase: serviceLocator(),
        sharedPreferences: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    ..registerFactory(
      () => SignIn(serviceLocator()),
    )
    ..registerFactory(
      () => SignUp(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AuthBloc(
          signIn: serviceLocator(),
          signUp: serviceLocator(),
          sharedPreferences: serviceLocator()),
    );
}
