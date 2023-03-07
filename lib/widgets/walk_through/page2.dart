// Flutter imports:
import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Center(
        child: Text(
          'Page2',
          style: TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
