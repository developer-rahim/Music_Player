import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({ Key? key }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Color.fromRGBO(146, 194, 233, 1),
   
   child: 
    ListTile(
leading: Container(
  margin: EdgeInsets.only(top: 10),
  width: 100,
  height: 100,
  child: Center(child: Image.network('https://tinypng.com/images/social/website.jpg',
  fit: BoxFit.cover,),
  )),
   title: Text('Song Name'),
   subtitle: Text('Singer Name'),
   trailing: Wrap(children: [
     Icon(Icons.skip_previous_outlined,size: 40,),
     Icon(Icons.play_arrow,size: 40,),
     Icon(Icons.skip_next_outlined,size: 40,)
   ],), ) 
   );
  }
}