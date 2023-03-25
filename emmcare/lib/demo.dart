import 'package:flutter/material.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key, this.id});
  final id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(id),
      ),
    );
  }
}


// class Property{
//   double width;
//   double breadth;

//   Property({
//     this.width,
//     this.breadth
// });
// }



// class Shape{
//   String shapeName;
//   Property property;

//   Shape({
//     this.shapeName,
//     this.property
//   });


//   factory Shape.fromJson(Map<String, dynamic> parsedJson){
//   return Shape(
//     shapeName: parsedJson['shape_name'],
//     property: Property.fromJson(parsedJson['property'])
//   );
// }
// }


// factory Property.fromJson(Map<String, dynamic> json){
//   return Property(
//     width: json['width'],
//     breadth: json['breadth']
//   );
// }


// factory Shape.fromJson(Map<String, dynamic> parsedJson){
//   return Shape(
//     shapeName: parsedJson['shape_name'],
//     property : parsedJson['property']
//   );
// }


// {
//   "shape_name":"rectangle",
//   "property":{
//     "width":5.0,
//     "breadth":10.0
//   }
// }
