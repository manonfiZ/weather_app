import 'package:app_weather/configs/provider_manager.dart';
import 'package:app_weather/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_weather/configs/storage_manager.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await StorageManager.init();
    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        // routerConfig: RouterManager.router,
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Comfortaa',
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
