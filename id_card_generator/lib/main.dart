import 'dart:math';

import 'package:flutter/material.dart';
import 'package:id_card_generator/student_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ID Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StudentFormPage(),
    );
  }
}

class IDCardPage extends StatefulWidget {
  const IDCardPage({super.key});

  @override
  State<IDCardPage> createState() => _IDCardPageState();
}

class _IDCardPageState extends State<IDCardPage> {
  final Random _rnd = Random();

  Color _color = Color(0xff003432);

  Color _getRandomColor() {
    // generate fully opaque color
    return Color.fromARGB(
      0xFF,
      _rnd.nextInt(256), // red 0-255
      _rnd.nextInt(256), // green
      _rnd.nextInt(256), // blue
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IUT Student ID Card"),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none, // important: allows child to overflow upward
              alignment: Alignment.topCenter,
              children: [
                // Top green header
                Container(
                  color: _color,
                  width: 300,
                  height: 160,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Container(
                        height: 45,
                        width: 45,
                        color: Colors.white,
                        child: Image.asset(
                          "assets/images/logo.png",
                          width: 50,
                          height: 50,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "ISLAMIC UNIVERSITY OF TECHNOLOGY",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

                // Profile picture overlapping
                Positioned(
                  bottom: -75, // half of profile container height (150/2) → moves it up
                  child: Container(
                    height: 150,
                    width: 150,
                    color: _color,
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/profile_pic.jpg",
                      width: 130,
                      height: 130,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 80,),
            SizedBox(
              width: 190,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // student id
                        Icon(Icons.key_sharp, color: _color,),
                        SizedBox(width: 4,),
                        Text("Student ID", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    //   id container
                    Container(
                      width: 150,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: _color,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8,),
                        child: Row(
                          children: [
                            CircleAvatar(maxRadius: 8, backgroundColor: Colors.blueAccent,),
                            SizedBox(width: 10,),
                            Text("210041102", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 4,),
                    // student name
                    Row(
                      children: [
                        Icon(Icons.account_circle, color: _color,),
                        SizedBox(width: 4,),
                        Text("Student Name", style: TextStyle(color: Colors.grey),),
                      ],
                    ),
                    // name
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Row(
                        children: [
                          Text("HASIB ALTAF", style: TextStyle(
                              color: _color, fontWeight: FontWeight.w900
                          ),),
                        ],
                      ),
                    ),
                    // program name
                    Row(
                      children: [
                        Icon(Icons.school, color: _color,),
                        SizedBox(width: 4,),
                        Text("Program ", style: TextStyle(color: Colors.grey),),
                        Text("B.Sc. in CSE ", style: TextStyle(color: _color,  fontWeight: FontWeight.bold),),
                      ],
                    ),
                    // dept name
                    Row(
                      children: [
                        Icon(Icons.people, color: _color,),
                        SizedBox(width: 4,),
                        Text("Department ", style: TextStyle(color: Colors.grey),),
                        Text("CSE ", style: TextStyle(color: _color, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    // country
                    Row(
                      children: [
                        Icon(Icons.location_on, color: _color,),
                        SizedBox(width: 4,),
                        Text("Bangladesh ", style: TextStyle(color: _color, fontWeight: FontWeight.bold),),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 300,
              height: 28,
              color: _color,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("A subsidiary organ of OIC",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 12,),
            ElevatedButton(onPressed: () => setState(() => _color = _getRandomColor()), child: Text("Color Random")),
            SizedBox(height: 12,),
            ElevatedButton(onPressed: (){}, child: Text("Font Random")),
          ],
        ),
      ),
    );
  }
}



