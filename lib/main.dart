import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/theme.dart';
import 'screens/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  // Note: In production, pass these via dart-define
  const supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '', // Add your URL for local development
  );
  const supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '', // Add your anon key for local development
  );

  if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  runApp(const CitrisQuestLandingApp());
}

class CitrisQuestLandingApp extends StatelessWidget {
  const CitrisQuestLandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CITRIS Quest - Location-Based Campus Art Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppTheme.backgroundPrimary,
        colorScheme: ColorScheme.dark(
          primary: AppTheme.bluePrimary,
          secondary: AppTheme.cyanAccent,
          surface: AppTheme.backgroundSecondary,
        ),
        textTheme: GoogleFonts.micro5TextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const LandingPage(),
    );
  }
}

// NOTE: debug must be run in citris-quest, not citris-quest-landing
