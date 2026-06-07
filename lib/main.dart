import 'package:anubhuti/core/Provider/Ambience_provider.dart';
import 'package:anubhuti/core/Provider/Theme_Provider.dart';
import 'package:anubhuti/core/theme/Theme_Data.dart';
import 'package:anubhuti/page/Anubhuti.dart';
import 'package:anubhuti/page/History_Screen.dart';
import 'package:anubhuti/page/Home_Screen.dart';
import 'package:anubhuti/page/Journey_Reading_Screen.dart';
import 'package:anubhuti/page/Player_Screen.dart';
import 'package:anubhuti/page/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'data/model/Journel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(JournelAdapter());
  await Hive.openBox<Journel>('Journel_Box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => AmbienceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final primaryColor = context.watch<AmbienceProvider>().getColor();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode(primaryColor),
      darkTheme: darkMode(primaryColor),
      themeMode: context.watch<ThemeProvider>().getValue()
          ? ThemeMode.dark
          : ThemeMode.light,
      // home: JourneyWritingScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/Home_Screen': (context) => const HomeScreen(),
        '/History_Screen': (context) => const HistoryScreen(),
        '/Player_Screen': (context) => const PlayerScreen(),
        '/Journey_Reading_Screen': (context) => const JourneyReadingScreen(),
        '/Anubhuti_Screen': (context) => const AnubhutiScreen(),
      },
    );
  }
}
