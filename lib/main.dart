import 'package:flutter/material.dart';
import 'package:my_movies/home_screen.dart';
import 'package:my_movies/my_intoduction_screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:my_movies/my_provider.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (_) => MyProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyProvider();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => MyProvider(),
        child: Provider.of<MyProvider>(context).data.isEmpty
            ? MyIntroductionScreen()
            : HomeScreen(),
      ),
    );
  }
}
