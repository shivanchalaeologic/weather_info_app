import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_info_app/bloc/weather_bloc.dart';
import 'package:weather_info_app/bloc/weather_event.dart';
import 'package:weather_info_app/bloc/weather_state.dart';
import 'package:weather_info_app/model/weather_response.dart';



class WeatherScreen extends StatelessWidget {
  var cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = context.bloc<WeatherBloc>();
    return Scaffold(

      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Container(
              child: FlareActor(
                "assets/worldspinner.flr",
                fit: BoxFit.contain,
                animation: "roll",
              ),
              height: 200,
              width: 200,
            )),
            BlocBuilder<WeatherBloc,WeatherState>(builder: (BuildContext context, state) {
              if(state is WeatherInitialState){
                return Container(
                  padding: EdgeInsets.only(
                    left: 32,
                    right: 32,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Search Weather",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70),
                      ),
                      Text(
                        "Instanly",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w200,
                            color: Colors.white70),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        onFieldSubmitted: (_){
                          weatherBloc.add(FetchWeatherEvent(city: _));
                          cityController.text='';
                        },
                        controller: cityController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white70,
                          ),

                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.white70, style: BorderStyle.solid)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.blue, style: BorderStyle.solid)),
                          hintText: "City Name",
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          onPressed: (){
                            weatherBloc.add(FetchWeatherEvent(city: cityController.text));
                            cityController.text='';
                          },
                          color: Colors.lightBlue,
                          child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                        ),
                      )
                    ],
                  ),
                );
              }
              else if(state is WeatherLoadingState){
                return Center(child: CircularProgressIndicator());
              }
              else if(state is WeatherLoadedState){
                return ShowWeather(weather: state.weatherResponse);
              }
              else if(state is WeatherIsNotLoadedState){
                return Container(
                  padding: EdgeInsets.only(right: 32, left: 32, top: 10),
                  height: MediaQuery.of(context).size.height/2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("${state.error}",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.w600),),
                      SizedBox(height: 20,),
                      SearchWidget()
                    ],
                  ),
                );
              }
            },

            )
          ],
        ),
      ),
    );
  }
}

class ShowWeather extends StatelessWidget {
  WeatherResponse weather;
  ShowWeather({this.weather});
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(right: 32, left: 32, top: 10),
      child: Column(
        children: <Widget>[
          Text(weather.name,style: TextStyle(color: Colors.white70, fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text(weather.main.getTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 50),),
          Text("Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(weather.main.getMinTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                  Text("Min Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                ],
              ),
              Column(
                children: <Widget>[
                  Text(weather.main.getMaxTemp.round().toString()+"C",style: TextStyle(color: Colors.white70, fontSize: 30),),
                  Text("Max Temprature",style: TextStyle(color: Colors.white70, fontSize: 14),),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SearchWidget()
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = context.bloc<WeatherBloc>();

    return Container(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        onPressed: (){
          weatherBloc.add(ResetWeather());
        },
        color: Colors.lightBlue,
        child: Text("Again Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

      ),
    );
  }
}


