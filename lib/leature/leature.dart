



import 'package:flutter/material.dart';

class Leature extends StatefulWidget {
  const Leature({Key? key}) : super(key: key);

  @override
  State<Leature> createState() => _LeatureState();
}

class _LeatureState extends State<Leature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Your Favorate songs'),centerTitle: true,),
        body: SingleChildScrollView(
          child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: ((context, index) {
                  return Container(
                    // height: 100,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        
                        leading: Image(
                            image: NetworkImage(
                                'https://cdn.pixabay.com/photo/2018/09/28/19/07/islamic-3710002_960_720.jpg')),
                        title: Text('Song'),
                        subtitle: Text('Singer Name'),
                        trailing: Container(
                          child: Wrap(
                            spacing: 20,
                            children: [
                            Icon(Icons.stop_circle_outlined),
                             Icon(Icons.remove_red_eye),
                              Icon(Icons.stop_circle_outlined),
                          ],),
                        ),
                      ));
                })),
          ),
        ));}}

        //  ListView(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),
        //   children: [
        //     Container(height: 100,
        //       child: ListTile(
        //         leading: Image(
        //           image: NetworkImage(
        //               'https://cdn.pixabay.com/photo/2018/09/28/19/07/islamic-3710002_960_720.jpg'),
        //         ),
        //    title: Text('Song'),
        //    subtitle: Text('Singer name'),
        //    trailing: Icon(Icons.Leature_note), ),
        //     )
        //   ],
        // ),
//         // );
//   }
// }
