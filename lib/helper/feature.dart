import 'package:flutter/material.dart';

class Feature extends StatelessWidget {
  String text;
  Feature({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(00.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'rrr',
                  color: Color.fromARGB(255, 188, 128, 199)),
            ),
          ),
          Text(
            'Show All',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(79, 92, 86, 1)),
          ),
        ],
      ),
    );
  }
}
