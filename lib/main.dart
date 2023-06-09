import 'package:crayonant/examplepage.dart';
import 'package:crayonant/savedimages.dart';
import 'package:flutter/material.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Painter Example',
        theme: ThemeData(
              primarySwatch: Colors.pink,
              visualDensity: VisualDensity.adaptivePlatformDensity,),
      home:const ExamplePage(),
    );

  }
}








