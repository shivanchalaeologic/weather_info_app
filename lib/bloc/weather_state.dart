import 'package:equatable/equatable.dart';
import 'package:weather_info_app/model/weather_response.dart';

class WeatherState extends Equatable{
  @override
  List<Object> get props => [];
}
class WeatherInitialState extends WeatherState{}//WeatherInitialState
class WeatherLoadingState extends WeatherState{}// show CircularPorgress
class WeatherLoadedState extends WeatherState{
  final WeatherResponse weatherResponse;
  WeatherLoadedState({this.weatherResponse});
  @override
  List<Object> get props => [weatherResponse];
}// successfully
class WeatherIsNotLoadedState extends WeatherState{
  final String error;

  WeatherIsNotLoadedState({this.error});
  @override
  List<Object> get props => [error];
}//error state like api error


