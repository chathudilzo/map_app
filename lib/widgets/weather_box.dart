import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map_app/controllers/weather_controller.dart';
import 'package:map_app/weather_page.dart';
import '../classes/weather.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WeatherController>(
      init: WeatherController(),
      builder: (weatherController) {
        return weatherController.isLoading
            ? LoadingAnimationWidget.beat(color: Colors.blue, size: 20)
            : Container(
                child: CarouselSlider.builder(
                  itemCount: weatherController.weatherData.length,
                  itemBuilder: (BuildContext context, int index, int ind) {
                    final Weather weather = weatherController.weatherData[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(()=>WeatherPage(weather: weather));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            weather.city.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weather.weatherIcon.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            weather.temperature?.toStringAsFixed(0) ?? 'N/A',
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weather.condition.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            weather.message.toString(),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 8),
                    scrollDirection: Axis.vertical,
                    viewportFraction: 1,
                  ),
                ),
              );
      },
    );
  }
}
