import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_app/widgets/weather_box.dart';

class PlacesBox extends StatefulWidget {
  const PlacesBox({super.key,required this.title,required this.wid,required this.icon});

  final String title;
  final Widget wid;
  final IconData icon;

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
      child: Stack(
        children:[ Container(
          width: width*0.4,
          height: width*0.4,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(blurRadius: 3,spreadRadius: 3,color: Colors.black)],
            borderRadius: BorderRadius.circular(20),color: Color.fromARGB(255, 20, 20, 20),),
          child:widget.wid,
        ),
        Positioned(
          top: 5,
          left: 0,
          child: Row(
            children: [
              Container(
                child: Icon(widget.icon,color: Colors.orange,size: 25,),
        ),
        SizedBox(width: 10,),
              Text(widget.title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

              
            ],
          )),
        
        ]
      ),
    );
  }
}