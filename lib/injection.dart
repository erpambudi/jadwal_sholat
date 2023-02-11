import 'package:get_it/get_it.dart';
import 'package:jadwal_sholat/domain/usecases/get_sholat_schedule.dart';
import 'package:jadwal_sholat/presentation/bloc/sholat_bloc.dart';

import 'data/datasources/sholat_remote.dart';
import 'data/repositories/sholat_repository_impl.dart';
import 'domain/repositories/sholat_repository.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Bloc
  locator.registerLazySingleton(() => SholatBloc(locator()));

  // Use case
  locator.registerLazySingleton(() => GetSholatSchedule(locator()));

  // Repository
  locator.registerLazySingleton<SholatRepository>(
      () => SholatRepositoryImpl(sholatRemote: locator()));

  // Data sources
  locator.registerLazySingleton<SholatRemote>(() => SholatRemoteImpl());
}
