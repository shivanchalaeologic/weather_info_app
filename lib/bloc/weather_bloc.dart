import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_info_app/bloc/weather_event.dart';
import 'package:weather_info_app/bloc/weather_state.dart';
import 'package:weather_info_app/model/weather_response.dart';
import 'package:weather_info_app/respository/api_respository.dart';
// import 'package:weatherapplication/bloc/weather_event.dart';
// import 'package:weatherapplication/bloc/weather_state.dart';
// import 'package:weatherapplication/model/weather_response.dart';
// import 'package:weatherapplication/respository/api_respository.dart';
// import 'package:weatherapplication/service/handle_error.dart';
import 'package:weather_info_app/service/handle_error.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  ApiRespository apiRespository;
  WeatherBloc({this.apiRespository}):assert(apiRespository != null);
  @override
  get initialState => WeatherInitialState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        WeatherResponse apiResponse =
            await apiRespository.getWeather(event.city);
        yield WeatherLoadedState(weatherResponse: apiResponse);
      } catch (e) {
        yield WeatherIsNotLoadedState(error: handleError(e));
      }
    } else if (event is ResetWeather) {
      yield WeatherInitialState();
    }
  }
}
