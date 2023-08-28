import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UnitBox extends StatefulWidget {
  const UnitBox({super.key});

  @override
  State<UnitBox> createState() => _UnitBoxState();
}

class _UnitBoxState extends State<UnitBox> {

List<List<String>> unitPairs=[
    ['KiloGram', 'Gram'],
    ['KiloGram', 'Miligram'],
    ['Meter', 'Kilometer'],
    ['Meter', 'Mile'],
    ['Meter', 'Inch'],
    ['Meter', 'Foot'],
    ['Meter', 'Centimeter'],
    ['Celsius', 'Fahrenheit'],
    ['Celsius', 'Kelvin'],
    ['Liter', 'Milliliter'],
    ['Liter', 'Gallon'],
    ['Liter', 'Cubic Meter'],
    ['Liter', 'Cubic Inch'],
    ['Second', 'Minute'],
    ['Second', 'Hour'],
    ['Second', 'Day'],
    ['Meters per Second', 'Kilometers per Hour'],
    ['Meters per Second', 'Miles per Hour'],
    ['Square Meter', 'Square Kilometer'],
    ['Square Meter', 'Square Mile'],
    ['Square Meter', 'Square Inch'],
    ['Square Meter', 'Square Foot'],
    ['Pascal', 'Bar'],
    ['Pascal', 'Atmosphere'],
    ['Pascal', 'Pound per Square Inch'],
    ['Joule', 'Calorie'],
    ['Joule', 'Kilowatt-hour'],
    ['USD', 'EUR'],
    ['USD', 'JPY'],
    ['USD', 'GBP'],
    // Add more unit pairs as needed
  ];

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [Color.fromARGB(255, 241, 86, 14),Colors.black])
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10,),
            Container(
            
              //padding:EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2,spreadRadius: 3,color: Colors.black,offset: Offset(1,1))],
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 57, 58, 57)
              ),
              child:CarouselSlider.builder(itemCount: unitPairs.length, 
              itemBuilder: (context, index, realIndex) {
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
              width: 110,
              height: 25,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2,spreadRadius: 3,color: Colors.black,offset: Offset(1,1))],
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 243, 145, 33)
              ),
              child: Center(child: Text(unitPairs[index][0],style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),))),
                    
                    Text('To',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
            Container(
              width: 110,
              height: 25,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 2,spreadRadius: 3,color: Colors.black,offset: Offset(1,1))],
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue
              ),
              child: Center(child: Text(unitPairs[index][1],style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),)))
                  ],
                ));
              },
              
               options: CarouselOptions(
                height: 90,
                autoPlay: true,
               autoPlayInterval: Duration(seconds: 8),
               scrollDirection: Axis.vertical,
               viewportFraction: 1,
               autoPlayAnimationDuration: Duration(seconds: 1)),
               
               )
              ),
            
          ],
        ),
      ),
    );
  }
}