import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_demo_app2/models/pokemon.dart';
import 'package:riverpod_demo_app2/services/http_service.dart';

final PokemaonDataProvider = FutureProvider.family<Pokemon?, String>(
  (ref, url) async {
    HTTPService _httpService = GetIt.instance.get<HTTPService>();
    Response? res = await _httpService.get(url);
    if (res != null && res.data != null) {
      return Pokemon.fromJson(res.data!);
    }
    return null;
  },
);
