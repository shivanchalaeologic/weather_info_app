import 'package:dio/dio.dart';
import 'package:weather_info_app/model/weather_response.dart';
import 'package:weather_info_app/service/dio_client.dart';



class ApiRespository {
  DioClient dioClient;
  final String _APPID = "43ea6baaad7663dc17637e22ee6f78f2";
  String _baseUrl = "https://api.openweathermap.org/";

  ApiRespository() {
    var dio = Dio();
    dioClient = DioClient(_baseUrl, dio);
  }
  Future<WeatherResponse> getWeather(String  city) async {
    try {
      var queryParameter = {'APPID': _APPID,'q':city};
      final response = await dioClient.get('data/2.5/weather', queryParameters: queryParameter);
      return WeatherResponse.fromJson(response);
    } catch (e) {
      return e;
    }
  }
}
