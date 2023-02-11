import 'dart:convert';
import 'package:jadwal_sholat/common/constants/constants.dart';
import 'package:jadwal_sholat/core/utils/exception.dart';
import 'package:jadwal_sholat/data/models/sholat_model.dart';

import 'package:http/http.dart' as http;

abstract class SholatRemote {
  Future<SholatModel> getSholatSchedule(String idCity, String date);
}

class SholatRemoteImpl implements SholatRemote {
  @override
  Future<SholatModel> getSholatSchedule(String idCity, String date) async {
    final result =
        await http.get(Uri.parse("$baseUrl/sholat/jadwal/$idCity/$date"));

    if (result.statusCode == 200) {
      var data = SholatResponse.fromJson(json.decode(result.body));
      return data.sholat;
    } else {
      throw ServerException();
    }
  }
}
