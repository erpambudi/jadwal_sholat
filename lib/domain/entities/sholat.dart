import 'package:equatable/equatable.dart';

class Sholat extends Equatable {
  const Sholat({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.koordinat,
    required this.jadwal,
  });

  final String id;
  final String lokasi;
  final String daerah;
  final Koordinat koordinat;
  final Jadwal jadwal;

  @override
  List<Object?> get props => [id, lokasi, daerah, koordinat, jadwal];
}

class Jadwal extends Equatable {
  const Jadwal({
    required this.tanggal,
    required this.imsak,
    required this.subuh,
    required this.terbit,
    required this.dhuha,
    required this.dzuhur,
    required this.ashar,
    required this.maghrib,
    required this.isya,
    required this.date,
  });

  final String tanggal;
  final String imsak;
  final String subuh;
  final String terbit;
  final String dhuha;
  final String dzuhur;
  final String ashar;
  final String maghrib;
  final String isya;
  final DateTime date;

  @override
  List<Object?> get props => [
        tanggal,
        imsak,
        subuh,
        terbit,
        dhuha,
        dzuhur,
        ashar,
        maghrib,
        isya,
        date
      ];
}

class Koordinat extends Equatable {
  const Koordinat({
    this.lat,
    this.lon,
    this.lintang,
    this.bujur,
  });

  final double? lat;
  final double? lon;
  final String? lintang;
  final String? bujur;

  @override
  List<Object?> get props => [lat, lon, lintang, bujur];
}
