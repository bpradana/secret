import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret/page/home_page.dart';
import 'package:secret/provider/feedback_position_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => FeedbackPositionProvider(),
        child: MaterialApp(
          title: 'Deeptalk',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage(),
        ),
      );
}
