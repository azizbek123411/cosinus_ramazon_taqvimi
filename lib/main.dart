
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/nav_bar_pages/main_nav_page.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/splash_page/scroll_pag.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/splash_page/splash_screen.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/splash_page/splashscreenn.dart';
import 'package:cosinus_ramazon_taqvimi/src/ui/pages/splash_page/time_location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstRun() async {
  final prefs = await SharedPreferences.getInstance();
  bool firstRun = prefs.getBool('isFirstRun') ?? true;
  if (!firstRun) await prefs.setBool('isFirstRun', false);
  return firstRun;
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  var box = Hive.openBox("address");

  runApp(
    EasyLocalization(
      fallbackLocale: const Locale("uz", "UZ"),
      supportedLocales: const [
        Locale("en", "EN"),
        Locale("uz", "UZ"),
        Locale("ru", "RU"),
      ],
      path: "assets/localization",
      child: const ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isFirstRun = false;

  @override
  void initState() {
    super.initState();
    isFirstRun().then((value) => setState(() {
      _isFirstRun = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ramazon Taqvimi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: _isFirstRun?const SplashPage():const SplashScreen(),
      // home:const LocationPage(),
      routes: {
        ScrollPage.id: (context) => const ScrollPage(),
        MainNavpage.id: (context) => const MainNavpage(),
        TimeLocation.id: (context) => const TimeLocation(),
      },
    );
  }
}

