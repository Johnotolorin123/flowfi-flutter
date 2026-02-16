// Splash Screen
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/supabase_config.dart';
import '../onboarding/onboarding_flow.dart';
import 'welcome_screen.dart';
import '../main/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    // Show splash for 2 seconds
    await Future.delayed(Duration(seconds: 2));

    // Check onboarding status
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;

    // Check auth status
    final session = SupabaseConfig.currentUser;

    if (mounted) {
      if (session != null) {
        // Logged in → Dashboard
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => DashboardScreen()),
        );
      } else if (!onboardingComplete) {
        // First time → Onboarding
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => OnboardingFlow()),
        );
      } else {
        // Returning user, not logged in → Welcome
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => WelcomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xFFF8F9FC), // Light gray background from your design
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo - the cyan "M" icon
            Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 80,
            ),
            SizedBox(height: 16),
            // "MONEY" text in purple
          ],
        ),
      ),
    );
  }
}
