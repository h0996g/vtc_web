import 'package:get_it/get_it.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/gift_card/data/datasources/gift_card_remote_datasource.dart';
import '../../features/gift_card/data/repositories/gift_card_repository_impl.dart';
import '../../features/gift_card/domain/repositories/gift_card_repository.dart';
import '../../features/gift_card/presentation/cubit/gift_card_cubit.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/wallet/data/datasources/wallet_remote_datasource.dart';
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';
import '../../features/wallet/presentation/cubit/wallet_cubit.dart';
import '../network/vtc_dio.dart';
import '../storage/secure_storage_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Init Dio with stored token
  final token = await SecureStorageService.getAccessToken();
  VtcDio.init(token: token);

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSource());
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()));
  sl.registerFactory<ProfileCubit>(() => ProfileCubit(sl()));

  // Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSource());
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));

  // Gift Card
  sl.registerLazySingleton<GiftCardRemoteDataSource>(() => GiftCardRemoteDataSource());
  sl.registerLazySingleton<GiftCardRepository>(() => GiftCardRepositoryImpl(sl()));
  sl.registerFactory<GiftCardCubit>(() => GiftCardCubit(sl()));

  // Wallet
  sl.registerLazySingleton<WalletRemoteDataSource>(() => WalletRemoteDataSource());
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(sl()));
  sl.registerFactory<WalletCubit>(() => WalletCubit(sl()));
}
