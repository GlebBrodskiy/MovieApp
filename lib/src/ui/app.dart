import 'package:bloc_medium/src/ui/help_screen.dart';
import 'package:flutter/material.dart';

import 'movie_list.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _onMainMenu = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: _onMainMenu == true
              ? const Text('Popular Movies')
              : const Text('Support'),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Image.network(
                  'https://cdn.freebiesupply.com/logos/large/2x/movie-city-logo-png-transparent.png',
                  fit: BoxFit.cover,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.local_movies_rounded),
                title: const Text(
                  'Movies',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    _onMainMenu = true;
                  });

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.support_agent_rounded),
                title: const Text(
                  'Info and Support',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  setState(() {
                    _onMainMenu = false;
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: _onMainMenu == true ? const MovieList() : const HelpScreen(),
      ),
    );
  }
}
