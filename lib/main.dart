import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/services/user_prefs.dart';
import 'features/home/screens/home_screen.dart';
import 'features/onboarding/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase is only initialized on mobile — web is not configured
  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  final onboardingDone = await UserPrefs.isOnboardingDone();
  runApp(FitnessApp(skipOnboarding: onboardingDone));
}

class FitnessApp extends StatelessWidget {
  final bool skipOnboarding;
  const FitnessApp({super.key, required this.skipOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00BFFF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF131313),
        useMaterial3: true,
      ),
      home: skipOnboarding ? const HomeScreen() : const SplashScreen(),
    );
  }
}
