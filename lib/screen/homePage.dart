import 'package:flutter/material.dart';
import 'package:test_app/global/drawer.dart';
import 'package:test_app/music.dart';

import '../helper/feature.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          actions: [
            Container(
                margin: EdgeInsets.only(right: 10, top: 0),
                child: Icon(Icons.shopping_cart))
          ],
          iconTheme: IconThemeData(color: Colors.black),
          flexibleSpace: Center(
            child: Container(
              // padding: EdgeInsets.only(top: 3),
              margin: EdgeInsets.only(left: 50, right: 50, bottom: 15, top: 15),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search as your wish',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            // margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 150,
                    width: 300,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Card(
                      elevation: 100,
                      shadowColor: Colors.black,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2018/09/28/19/07/islamic-3710002_960_720.jpg',
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/music');
                    },
                    child: Feature(
                      text: 'Feature',
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return Container(
                          height: 150,
                          width: 100,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.amber,
                        );

                        //  ListTile(
                        //   leading: Image(
                        //     image: NetworkImage(
                        //         'https://cdn.pixabay.com/photo/2018/09/28/19/07/islamic-3710002_960_720.jpg'),
                        //   ),
                        //   title: Text('Song'),
                        //   subtitle: Text('Singer name'),
                        //   trailing: Container(
                        //     child: Wrap(
                        //       spacing: 20,
                        //       children: [
                        //         Icon(Icons.stop_circle_outlined),
                        //         Icon(Icons.remove_red_eye),
                        //         Icon(Icons.stop_circle_outlined),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      })),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/leature');
                    },
                    child: Feature(
                      text: 'Leature',
                    ),
                  ),
                ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     // physics: NeverScrollableScrollPhysics(),
                //     itemCount: 5,
                //     // scrollDirection: Axis.horizontal,
                //     itemBuilder: ((context, index) {
                //       return Container(
                //         height: 100,
                //         child: ListTile(
                //           leading: Image(
                //             image: NetworkImage(
                //                 'https://cdn.pixabay.com/photo/2018/09/28/19/07/islamic-3710002_960_720.jpg'),
                //           ),
                //           title: Text('Song'),
                //           subtitle: Text('Singer name'),
                //           trailing: Container(
                //             child: Wrap(
                //               spacing: 20,
                //               children: [
                //                 Icon(Icons.stop_circle_outlined),
                //                 Icon(Icons.remove_red_eye),
                //                 Icon(Icons.stop_circle_outlined),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }))
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pushNamed(context, '/music');
                //     },
                //     child: Feature(
                //       text: 'Feature',
                //     ),
                //   ),
                // ),
                // Container(
                //   margin: EdgeInsets.symmetric(horizontal: 20),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pushNamed(context, '/music');
                //     },
                //     child: Feature(
                //       text: 'Feature',
                //     ),
                //   ),
                // ),
                Container(
                    height: 150,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return Container(
                            height: 150,
                            width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.amber,
                          );
                        })))
              ],
            ),
          ),
        ),
      ),
    );
  }

// Navigation Drawer
  drawer() {
    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '\Homepahe');
            },
            child:
                items(title: 'Home', leading: Icons.home, color: Colors.indigo),
          ),

          // Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '\profile');
            },
            child: items(
                title: 'Profile', leading: Icons.person, color: Colors.pink),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '\reviewcart');
            },
            child: items(
                title: 'Order',
                leading: Icons.shopping_cart,
                color: Colors.purple),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '\reviewcart');
            },
            child: items(
                title: 'Favorite',
                leading: Icons.favorite,
                color: Color.fromARGB(255, 223, 208, 226)),
          ),
          // Divider(),

          // Divider(),
          items(
              title: 'Download', leading: Icons.download, color: Colors.amber),
          // Divider(),
          items(title: 'Contact Us', leading: Icons.phone, color: Colors.blue),
          items(
              title: 'Privecy Policy',
              leading: Icons.policy,
              color: Colors.blue),
          items(title: 'Login', leading: Icons.login, color: Colors.blue),
        ],
      ),
    );
  }
//Drawer Item

  items({title, leading, color}) {
    return ListView(
      shrinkWrap: true,
      children: [
        ListTile(
          leading: Icon(
            leading,
            color: color,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
