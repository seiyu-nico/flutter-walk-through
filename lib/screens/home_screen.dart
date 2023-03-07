// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:flutter_walk_through/screens/walk_through_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('HomePage', style: TextStyle(fontSize: 32)),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool('walkThroughDone', false);

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const WalkThroughScreen(),
                  ),
                );
              },
              child: const Text(
                'ウォークスルー初期化',
                style: TextStyle(fontSize: 32),
              ),
            )
          ],
        ),
      ),
    );
  }
}
