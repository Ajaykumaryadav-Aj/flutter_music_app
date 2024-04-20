import 'package:flutter/material.dart';
import 'package:flutter_music_app/mpdels/playlist_provider.dart';
import 'package:flutter_music_app/pages/home_pages.dart';
import 'package:flutter_music_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider(),),ChangeNotifierProvider(create: (context) => PlaylistProvider(),),
    
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 182, 172, 198)),
          useMaterial3: true,
        ),
        home: const HomePageScreen(),
        darkTheme: Provider.of<ThemeProvider>(context).themeData);
  }
}
