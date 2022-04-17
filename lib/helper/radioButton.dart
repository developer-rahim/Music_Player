import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({ Key? key }) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  // var val;
  var gender = "male";
 // String? gender; //no radio button will be selected

 
  @override
  Widget build(BuildContext context) {
    return   Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
              value: "male",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                 gender = value.toString();
                
                });
              },
            ),
            Text(
              'Male',
              style: new TextStyle(fontSize: 17.0),
            ),
              Radio(
              value:'Female',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
               gender = value.toString();
                
                });
              },
            ),
            Text(
              'Female',
              style: new TextStyle(fontSize: 17.0),
            ),
                           Radio(
              value: 'Other',
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                 gender = value.toString();
                
                });
              },
            ),
            Text(
              'Other',
              style: new TextStyle(fontSize: 17.0),
            ),
            ],
          );
        
   
  }
}