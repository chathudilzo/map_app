class Weather{
  double? temperature;
  String? condition;
  int? humidity;
  String? country;
  String? city;
  String? weatherIcon;
  String? message;

  Weather({required this.city,required this.temperature,required this.condition,required this.humidity,required this.country,this.weatherIcon,this.message});

}