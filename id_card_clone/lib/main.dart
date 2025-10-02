import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ID Card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: IDCardPage(),
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
  String _currentFont = 'Roboto'; // Default font

  // List of Google Fonts
  final List<String> _fontFamilies = [
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Raleway',
    'PT Sans',
    'Oswald',
    'Merriweather',
    'Ubuntu',
    'Playfair Display',
    'Nunito',
    'Poppins',
    'Roboto Mono',
    'Source Sans Pro',
    'Quicksand',
    'Dancing Script',
    'Pacifico',
    'Bebas Neue',
    'Crimson Text',
    'Indie Flower',
  ];

  Color _getRandomColor() {
    return Color.fromARGB(
      0xFF,
      _rnd.nextInt(256),
      _rnd.nextInt(256),
      _rnd.nextInt(256),
    );
  }

  String _getRandomFont() {
    return _fontFamilies[_rnd.nextInt(_fontFamilies.length)];
  }

  void _randomizeFont() {
    setState(() {
      _currentFont = _getRandomFont();
    });
  }

  TextStyle _getTextStyle({
    Color? color,
    FontWeight? fontWeight,
    double? fontSize,
    FontStyle? fontStyle,
  }) {
    return GoogleFonts.getFont(
      _currentFont,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize,
      fontStyle: fontStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "IUT Student ID Card",
          style: _getTextStyle(),
        ),
      ),
      body: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
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
                        Image.asset(
                          "assets/images/logo.png",
                          width: 55,
                          height: 55,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "ISLAMIC UNIVERSITY OF TECHNOLOGY",
                          style: _getTextStyle(
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
                    bottom: -75,
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
              SizedBox(height: 80),
              SizedBox(
                width: 190,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.key_sharp, color: _color),
                          SizedBox(width: 4),
                          Text(
                            "Student ID",
                            style: _getTextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      // ID container
                      Container(
                        width: 150,
                        height: 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: _color,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                maxRadius: 8,
                                backgroundColor: Colors.blueAccent,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "210041102",
                                style: _getTextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      // Student name label
                      Row(
                        children: [
                          Icon(Icons.account_circle, color: _color),
                          SizedBox(width: 4),
                          Text(
                            "Student Name",
                            style: _getTextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      // Name
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Row(
                          children: [
                            Text(
                              "HASIB ALTAF",
                              style: _getTextStyle(
                                color: _color,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Program name
                      Row(
                        children: [
                          Icon(Icons.school, color: _color),
                          SizedBox(width: 4),
                          Text(
                            "Program ",
                            style: _getTextStyle(color: Colors.grey),
                          ),
                          Text(
                            "B.Sc. in CSE ",
                            style: _getTextStyle(
                              color: _color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Dept name
                      Row(
                        children: [
                          Icon(Icons.people, color: _color),
                          SizedBox(width: 4),
                          Text(
                            "Department ",
                            style: _getTextStyle(color: Colors.grey),
                          ),
                          Text(
                            "CSE ",
                            style: _getTextStyle(
                              color: _color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      // Country
                      Row(
                        children: [
                          Icon(Icons.location_on, color: _color),
                          SizedBox(width: 4),
                          Text(
                            "Bangladesh ",
                            style: _getTextStyle(
                              color: _color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: 300,
                height: 28,
                color: _color,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "A subsidiary organ of OIC",
                        style: _getTextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12),
              // Display current font name
              Text(
                "Current Font: $_currentFont",
                style: _getTextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => setState(() => _color = _getRandomColor()),
                child: Text("Color Random"),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                onPressed: _randomizeFont,
                child: Text("Font Random"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}