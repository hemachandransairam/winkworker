import 'package:flutter/material.dart';
import 'package:wink_worker/screens/splach.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pmjohqngmfmkicpdipjz.supabase.co',
    anonKey: 'sb_publishable_0m9stBaAI1Rj8XpWzVnDyA_Neb6DHhU',
  );

  runApp(
    const MyApp(),
    //DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}

//otp = 9412
//hemachandranoff@gmail.com (supabase)
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 34, 0, 92),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
