import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FloatingActionBtn extends StatefulWidget {
  const FloatingActionBtn({super.key});

  @override
  State<FloatingActionBtn> createState() => _FloatingActionBtnState();
}

class _FloatingActionBtnState extends State<FloatingActionBtn> {

  
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {},
        child: Container(
          // width: MediaQuery.of(context).size.width * 0.5,
          // height: MediaQuery.of(context).size.width * 0.5,
          child: ClipOval(
            child: Image(
              image: AssetImage('assets/icon.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 3, spreadRadius: 3, color: Color.fromARGB(255, 10, 62, 175))
            ],
            border: Border.all(color: Color.fromARGB(255, 3, 10, 70), width: 4),
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      );
  }
}