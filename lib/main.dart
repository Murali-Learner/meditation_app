import 'package:flutter/material.dart';
import 'package:meditation_app/count_provider.dart';
import 'package:meditation_app/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => CountdownTimerProvider(),
          )
        ],
        child: CountdownTimerPage(),
      ),
    );
  }
}
