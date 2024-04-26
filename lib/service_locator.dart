import 'package:get_it/get_it.dart';
import 'features/products/data/repos/product_repo.dart';
import 'features/products/data/repos/products_repo_impl.dart';
import 'features/authentication/data/repos/authentication_repo.dart';
import 'features/authentication/data/repos/authentication_repo_impl.dart';
import 'core/services/location_service.dart';
import 'core/services/location_service_interface.dart';
import 'features/address/data/repo/address_repo.dart';
import 'features/address/data/repo/address_repo_impl.dart';
import 'features/home/data/repo/home_repo.dart';
import 'features/home/data/repo/home_repo_impl.dart';
import 'core/services/http_service.dart';
import 'core/services/http_service_interface.dart';
import 'core/services/shared_preferences_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService());
  sl.registerLazySingleton<HttpServiceInterface>(() => HttpService(sl()));
  sl.registerLazySingleton<LocationServiceInterface>(() => LocationService());

  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImple(sl()));
  sl.registerLazySingleton<AddressRepo>(() => AddressRepoImpl(sl()));
  sl.registerLazySingleton<AuthenticationRepo>(
      () => AuthenticationRepoImpl(sl()));
  sl.registerLazySingleton<ProductsRepo>(() => ProductsRepoImpl(sl()));
}
