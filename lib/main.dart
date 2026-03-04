import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wink_worker/app.dart';

// hemachandranoff@gmail.com (supabase)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pmjohqngmfmkicpdipjz.supabase.co',
    anonKey: 'sb_publishable_0m9stBaAI1Rj8XpWzVnDyA_Neb6DHhU',
  );

  runApp(
    //const MyApp(),
    DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
  );
}
