import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PlacesBox extends StatefulWidget {
  const PlacesBox({super.key});

  @override
  State<PlacesBox> createState() => _PlacesBoxState();
}

class _PlacesBoxState extends State<PlacesBox> {
  @override
  Widget build(BuildContext context) {
     double width= MediaQuery.of(context).size.width ;
     double height= MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: width*0.4,
        height: width*0.4,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.amber,),
      ),
    );
  }
}