// import 'package:app_weather/configs/provider_manager.dart';
import 'package:app_weather/core/viewmodel/location_model.dart';
import 'package:app_weather/core/viewmodel/weather_model.dart';
// import 'package:app_weather/screens/checkout.dart';
import 'package:app_weather/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_weather/configs/storage_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(const MyApp());
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
      providers: [
          ChangeNotifierProvider(create: (_) => WeatherModel()),
  ChangeNotifierProvider(create: (_) => LocationModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Weather App',
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
