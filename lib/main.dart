// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:flutter_walk_through/screens/home_screen.dart';
import 'package:flutter_walk_through/screens/walk_through_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isWalkThroughDone = prefs.getBool('walkThroughDone') ?? false;
  runApp(MyApp(isWalkThroughDone: isWalkThroughDone));
}

class MyApp extends StatelessWidget {
  final bool isWalkThroughDone;
  const MyApp({Key? key, required this.isWalkThroughDone}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isWalkThroughDone ? const HomeScreen() : const WalkThroughScreen(),
    );
  }
}
