import 'package:flutter/material.dart';

import 'views/music_recommendation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Recommender',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 230, 172, 204)),
        useMaterial3: true,
      ),
      home: const MusicRecommendationScreen(),
    );
  }
}
