import 'package:dartz/dartz.dart';
import 'package:jadwal_sholat/core/utils/failure.dart';
import 'package:jadwal_sholat/domain/entities/sholat.dart';
import 'package:jadwal_sholat/domain/repositories/sholat_repository.dart';

class GetSholatSchedule {
  final SholatRepository repository;

  GetSholatSchedule(this.repository);

  Future<Either<Failure, Sholat>> execute(String idCity, String date) {
    return repository.getSholatSchedule(idCity, date);
  }
}
