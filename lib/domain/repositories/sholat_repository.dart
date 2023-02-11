import 'package:dartz/dartz.dart';
import 'package:jadwal_sholat/core/utils/failure.dart';
import 'package:jadwal_sholat/domain/entities/sholat.dart';

abstract class SholatRepository {
  Future<Either<Failure, Sholat>> getSholatSchedule(String idCity, String date);
}
