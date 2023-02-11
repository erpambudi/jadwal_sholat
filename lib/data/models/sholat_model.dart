import 'package:jadwal_sholat/domain/entities/sholat.dart';

class SholatResponse {
  SholatResponse({
    required this.status,
    required this.sholat,
  });

  bool status;
  SholatModel sholat;

  factory SholatResponse.fromJson(Map<String, dynamic> json) => SholatResponse(
        status: json["status"],
        sholat: SholatModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": sholat.toJson(),
      };
}

class SholatModel {
  SholatModel({
    required this.id,
    required this.lokasi,
    required this.daerah,
    required this.koordinat,
    required this.jadwal,
  });

  String id;
  String lokasi;
  String daerah;
  KoordinatModel koordinat;
  JadwalModel jadwal;

  factory SholatModel.fromJson(Map<String, dynamic> json) => SholatModel(
        id: json["id"],
        lokasi: json["lokasi"],
        daerah: json["daerah"],
        koordinat: KoordinatModel.fromJson(json["koordinat"]),
        jadwal: JadwalModel.fromJson(json["jadwal"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lokasi": lokasi,
        "daerah": daerah,
        "koordinat": koordinat.toJson(),
        "jadwal": jadwal.toJson(),
      };

  Sholat toEntity() => Sholat(
        id: id,
        lokasi: lokasi,
        daerah: daerah,
        koordinat: koordinat.toEntity(),
        jadwal: jadwal.toEntity(),
      );
}

class JadwalModel {
  JadwalModel({
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

  String tanggal;
  String imsak;
  String subuh;
  String terbit;
  String dhuha;
  String dzuhur;
  String ashar;
  String maghrib;
  String isya;
  DateTime date;

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        tanggal: json["tanggal"],
        imsak: json["imsak"],
        subuh: json["subuh"],
        terbit: json["terbit"],
        dhuha: json["dhuha"],
        dzuhur: json["dzuhur"],
        ashar: json["ashar"],
        maghrib: json["maghrib"],
        isya: json["isya"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "imsak": imsak,
        "subuh": subuh,
        "terbit": terbit,
        "dhuha": dhuha,
        "dzuhur": dzuhur,
        "ashar": ashar,
        "maghrib": maghrib,
        "isya": isya,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };

  Jadwal toEntity() => Jadwal(
        tanggal: tanggal,
        imsak: imsak,
        subuh: subuh,
        terbit: terbit,
        dhuha: dhuha,
        dzuhur: dzuhur,
        ashar: ashar,
        maghrib: maghrib,
        isya: isya,
        date: date,
      );
}

class KoordinatModel {
  KoordinatModel({
    this.lat,
    this.lon,
    this.lintang,
    this.bujur,
  });

  double? lat;
  double? lon;
  String? lintang;
  String? bujur;

  factory KoordinatModel.fromJson(Map<String, dynamic> json) => KoordinatModel(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        lintang: json["lintang"],
        bujur: json["bujur"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "lintang": lintang,
        "bujur": bujur,
      };

  Koordinat toEntity() => Koordinat(
        lat: lat,
        lon: lon,
        lintang: lintang,
        bujur: bujur,
      );
}
