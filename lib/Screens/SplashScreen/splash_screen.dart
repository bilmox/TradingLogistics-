import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../HomeScreen/home_screen.dart';
import '../NameInputScreen/NameInputScreen.dart';

class SplashScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const SplashScreen({super.key, required this.onLanguageChange});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/0304.mp4')
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
      });

    // UPDATED LISTENER
    _controller.addListener(() {
      // Check if video finished
      if (_controller.value.position >= _controller.value.duration) {
        _navigateToNext(); // Use the smart navigation logic here
      }
    });
  }

  // SMART NAVIGATION LOGIC
  Future<void> _navigateToNext() async {
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final String? savedName = prefs.getString('user_name');

    Widget nextScreen;

    // Check if the user has already entered their name before
    if (savedName != null && savedName.isNotEmpty) {
      nextScreen = const TradingLogisticApp(); // Go to Dashboard
    } else {
      nextScreen = const NameInputScreen(); // Go to Name Entry
    }

    // Smooth transition
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Match your video background
      body: _controller.value.isInitialized
          ? SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover, // Cover looks better for splash videos
          child: SizedBox(
            width: _controller.value.size.width,
            height: _controller.value.size.height,
            child: VideoPlayer(_controller),
          ),
        ),
      )
          : const Center(child: CircularProgressIndicator(color: Color(0xFF329EA6))),
    );
  }
}