import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';
import 'package:math_expressions/math_expressions.dart';



class UnitConverterPage extends StatefulWidget {
  const UnitConverterPage({Key? key}) : super(key: key);

  @override
  State<UnitConverterPage> createState() => _UnitConverterPageState();
}

class _UnitConverterPageState extends State<UnitConverterPage> {
  bool _isLoading = true;
  List<Map<String, dynamic>> unitData = [];

  Future<List<Map<String, dynamic>>> loadUnitData() async {
    final String unitData =
        await rootBundle.loadString('assets/unit.json');
    List<dynamic> decodedData = json.decode(unitData);
    List<Map<String, dynamic>> dataList =
        List<Map<String, dynamic>>.from(decodedData);

    return dataList;
  }

  @override
  void initState() {
    super.initState();
    loadUnitData().then((data) {
      setState(() {
        unitData = data;
        _isLoading = false;
      });
    });
  }

  String selectedCategory = 'Length';
  String selectedUnit = 'Meter';
  String selectedConvertibleType = 'Kilometer';

  // Function to update units and convertible types based on category and unit selection
  void setUnits() {
    outPutValueController.clear();
    // Update selectedUnit and selectedConvertibleType based on selectedCategory
    List< dynamic> units = unitData
        .firstWhere((category) => category['name'] == selectedCategory)['units'];
    selectedUnit = units[0]['name'];
    selectedConvertibleType = units[0]['convertibleTypes'][0];
  }

  void setConvertibleType() {
    outPutValueController.clear();
    List<dynamic> units = unitData
        .firstWhere((category) => category['name'] == selectedCategory)['units'];

    // Find the selected unit and update the selectedConvertibleType
    Map<String, dynamic> selectedUnitData =
        units.firstWhere((unit) => unit['name'] == selectedUnit);
    selectedConvertibleType = selectedUnitData['convertibleTypes'][0];
  }

  TextEditingController inputValueController=TextEditingController();
  TextEditingController outPutValueController=TextEditingController();

double performConversion(double inputValue,String selectedUnit,String selectedConvertibleType){
Map<String,dynamic> categoryData=unitData.firstWhere((category) =>category['name']==selectedCategory);

Map<String,dynamic> selectedUnitData=categoryData['units'].firstWhere((unit)=>unit['name']==selectedUnit);

String convertionFormula=selectedUnitData['conversionFormulas'][selectedConvertibleType];

convertionFormula=convertionFormula.replaceAll('value', inputValue.toString());

return evalExpression(convertionFormula);
}


double evalExpression(String expression){

  final Parser parser=Parser();
  final Expression exp =parser.parse(expression);


  final ContextModel cm=ContextModel();

  double result=exp.evaluate(EvaluationType.REAL, cm);
print(result);
setState(() {
  outPutValueController.text=result.toString();
});
  return result;
}

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
          begin: Alignment.topCenter,            
            colors: [Color.fromARGB(66, 11, 8, 202),Color.fromARGB(255, 26, 25, 25)])
        ),
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: height * 0.1),
              Text('Unit Converter',style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text('Select Category',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
               SizedBox(height: 10,),
               DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint:  Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: unitData.map<DropdownMenuItem<String>>(
                  (category) {
                    return DropdownMenuItem(
                      value: category['name'],
                      child: Text(category['name']),
                    );
                  },
                ).toList(),
            value: selectedCategory,
            onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue.toString();
                    setUnits(); // Call setUnits when category changes
                  });
                },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Color.fromARGB(255, 25, 164, 219),
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.redAccent,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
       ),
      //       DropdownButton(
      //         value: selectedCategory,
      //         items: unitData.map<DropdownMenuItem<String>>(
      //           (category) {
      //             return DropdownMenuItem(
      //               value: category['name'],
      //               child: Text(category['name']),
      //             );
      //           },
      //         ).toList(),
      //         onChanged: (newValue) {
      //           setState(() {
      //             selectedCategory = newValue.toString();
      //             setUnits(); // Call setUnits when category changes
      //           });
      //         },
      //       ),
      
              SizedBox(height: 10),
              Text('Select a unit',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                   DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint:  Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Unit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: unitData
                        .firstWhere(
                            (category) => category['name'] == selectedCategory)['units']
                        .map<DropdownMenuItem<String>>(
                          (unit) {
                            return DropdownMenuItem<String>(
                              value: unit['name'],
                              child: Text(unit['name']),
                            );
                          },
                        )
                        .toList(),
            value: selectedUnit,
            onChanged: (newValue) {
                      setState(() {
                        selectedUnit = newValue.toString();
                        setConvertibleType();
                      });
                    },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                gradient: LinearGradient(colors: [Color.fromARGB(255, 205, 212, 205),Color.fromARGB(255, 143, 6, 143)])
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromARGB(255, 112, 110, 110),
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
      ),
                  // DropdownButton(
                  //   value: selectedUnit,
                  //   items: unitData
                  //       .firstWhere(
                  //           (category) => category['name'] == selectedCategory)['units']
                  //       .map<DropdownMenuItem<String>>(
                  //         (unit) {
                  //           return DropdownMenuItem<String>(
                  //             value: unit['name'],
                  //             child: Text(unit['name']),
                  //           );
                  //         },
                  //       )
                  //       .toList(),
                  //   onChanged: (newValue) {
                  //     setState(() {
                  //       selectedUnit = newValue.toString();
                  //       setConvertibleType();
                  //     });
                  //   },
                  // ),
                   SizedBox(width: 20,),
                  Container(
                    width: width*0.3,
                    child: TextField(
                      controller:inputValueController,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text('Select Convert type',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: [
                  DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint:  Row(
              children: [
                Icon(
                  Icons.list,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    'Select Item',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: unitData.firstWhere((category) => category['name']==selectedCategory)['units']
                    .firstWhere((unit)=>unit['name']==selectedUnit)['convertibleTypes']
                    .map<DropdownMenuItem<String>>((type){
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type));
                    }).toList(),
            value: selectedConvertibleType,
            onChanged: (newValue){
                      setState(() {
                        selectedConvertibleType=newValue.toString();
                        outPutValueController.clear();
                      });
                     },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 160,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                gradient: LinearGradient(colors: [Color.fromARGB(255, 12, 236, 12),Color.fromARGB(255, 6, 43, 143)])
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Color.fromARGB(255, 243, 243, 243),
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
      ),
    
                  // DropdownButton(

                  //   value: selectedConvertibleType,
                  //   items: unitData.firstWhere((category) => category['name']==selectedCategory)['units']
                  //   .firstWhere((unit)=>unit['name']==selectedUnit)['convertibleTypes']
                  //   .map<DropdownMenuItem<String>>((type){
                  //     return DropdownMenuItem<String>(
                  //       value: type,
                  //       child: Text(type));
                  //   }).toList(),
                  //    onChanged: (newValue){
                  //     setState(() {
                  //       selectedConvertibleType=newValue.toString();
                  //       outPutValueController.clear();
                  //     });
                  //    }
                  // ),
                  SizedBox(width: 20,),
                  Container(
                    width: width*0.3,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller:outPutValueController,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40,),
              GestureDetector(
                onTap: () {
                  double inputValue=double.parse(inputValueController.text);
                  double convertedValue=performConversion(inputValue, selectedUnit, selectedConvertibleType);
                  outPutValueController.text=convertedValue.toString();
                },
                child: Container(
                  width: width*0.8,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [BoxShadow(
                      blurRadius: 2,spreadRadius: 2,offset: Offset(1,2),
                      color: Color.fromARGB(255, 4, 75, 97)
                    )],
                    gradient: LinearGradient(colors: [Colors.blue,Colors.purple])
                  ),
                  child: Center(child: Text('Calculate',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(index: 1),
    );
  }
}