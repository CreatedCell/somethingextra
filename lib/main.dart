import 'package:flutter/material.dart';
import 'package:extra_credit/demo.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Local Database',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: Demo(),
    );
  }
}