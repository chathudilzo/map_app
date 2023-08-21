class Weather{
  double? temperature;
  String? condition;
  int? humidity;
  double? minTemp;
  double? maxTemp;
  double? feelsLike;
  double? lat;
  double? long;
  //int windSpeed;
  int? windDeg;
  String? country;
  String? city;
  String? weatherIcon;
  String? message;

  Weather({required this.city,
  required this.temperature,
  required this.condition,
  required this.humidity,
  required this.country,
  this.maxTemp,
  this.minTemp,
  this.feelsLike,
  this.message,
  this.weatherIcon,
  this.windDeg,
  this.lat,
  this.long
  //required this.windSpeed,
  });

}