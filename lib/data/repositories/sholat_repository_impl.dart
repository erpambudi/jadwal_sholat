import 'dart:io';

import 'package:jadwal_sholat/core/utils/exception.dart';
import 'package:jadwal_sholat/data/datasources/sholat_remote.dart';
import 'package:jadwal_sholat/core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:jadwal_sholat/domain/entities/sholat.dart';
import 'package:jadwal_sholat/domain/repositories/sholat_repository.dart';

class SholatRepositoryImpl implements SholatRepository {
  final SholatRemote sholatRemote;

  SholatRepositoryImpl({required this.sholatRemote});

  @override
  Future<Either<Failure, Sholat>> getSholatSchedule(
      String idCity, String date) async {
    try {
      final result = await sholatRemote.getSholatSchedule(idCity, date);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("Failed to get data from server"));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    }
  }
}
