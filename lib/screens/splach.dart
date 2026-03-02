import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wink_worker/screens/onboarding.dart';
import 'package:wink_worker/screens/main_navigation_screen.dart';
import 'package:wink_worker/services/supabase_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () async {
      await SupabaseService().initUser();
      if (mounted) {
        if (SupabaseService().currentUserPhone != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigationScreen(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const OnboardingPage()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061633), // dark navy blue
      body: Center(child: Image.asset('assets/wynkash_logo.png', width: 200)),
    );
  }
}
