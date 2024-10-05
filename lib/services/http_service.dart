import 'package:dio/dio.dart';

class HTTPService {
  HTTPService();
  final dio = Dio();
  //get request
  Future<Response?> get(String path) async {
    try {
      Response res = await dio.get(path);
      return res;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
