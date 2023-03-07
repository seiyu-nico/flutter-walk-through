// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// Project imports:
import 'package:flutter_walk_through/screens/home_screen.dart';
import 'package:flutter_walk_through/widgets/walk_through/page1.dart';
import 'package:flutter_walk_through/widgets/walk_through/page2.dart';
import 'package:flutter_walk_through/widgets/walk_through/page3.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  final _controller = PageController();
  bool isLastPage = false;

  final List<Widget> _walkThroughPage = const [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          onPageChanged: (index) {
            setState(() {
              isLastPage = index == _walkThroughPage.length - 1;
            });
          },
          controller: _controller,
          children: _walkThroughPage,
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 80,
        child: isLastPage ? _buildStartBottom() : _buildWalkThrough(),
      ),
    );
  }

  Widget _buildStartBottom() {
    return Center(
      child: TextButton(
        child: const Text(
          'はじめる',
          style: TextStyle(fontSize: 32),
        ),
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool('walkThroughDone', true);
          if (!mounted) return;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWalkThrough() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => _controller.animateToPage(
              _walkThroughPage.length - 1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            child: const Text('スキップ', style: TextStyle(fontSize: 16)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: _walkThroughPage.length,
              effect: const WormEffect(
                activeDotColor: Colors.blue,
                spacing: 16,
                dotColor: Colors.grey,
              ),
              onDotClicked: (index) => _controller.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () => _controller.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            ),
            child: const Text('次へ', style: TextStyle(fontSize: 16)),
          ),
        )
      ],
    );
  }
}
