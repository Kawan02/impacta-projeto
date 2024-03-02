import 'package:contatos/src/views/home/models/contatos_model.dart';
import 'package:dio/dio.dart';

abstract class HttpMethods {
  static const String get = "GET";
  static const String post = "POST";
  static const String put = "PUT";
  static const String delete = "DELETE";
}

class HttpManager {
  Future restRequest({
    required String url,
    required String method,
    Map? body,
  }) async {
    // Headers da requisição

    final Dio dio = Dio();

    try {
      Response response = await dio.request(
        url,
        options: Options(method: method),
        data: body,
      );
      if (response.statusCode == 200) {
        return ContatosModel.fromJson(response.data);
      }
      // // Retorno do backend
      // return response.data;
    } on DioException catch (error) {
      // Retorno do erro do dio request
      return error.response?.data ?? {};
    } catch (error) {
      // Retorno de map vazio para erro generalizado
      return {};
    }
  }
}
