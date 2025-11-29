// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/home/screens/home_screen.dart';
import 'features/home/state/home_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
      ],
      child: RecipeApp(), // NO const here
    ),
  );
}

class RecipeApp extends StatelessWidget {
  RecipeApp({super.key}); // NO const

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF9800),
        ),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange,
          brightness: Brightness.dark,
        ).copyWith(
          secondary: const Color(0xFFFF9800),
        ),
      ),
      home: MainTabScreen(), // NO const
    );
  }
}

class MainTabScreen extends StatefulWidget {
  MainTabScreen({super.key}); // NO const

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), // 🔥 NO const
    const Placeholder(child: Text('Favorites Screen')),
    const Placeholder(child: Text('Create Recipe Screen')),
    const Placeholder(child: Text('Meal Planner Screen')),
    const Placeholder(child: Text('Shopping List Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0A0A0A),
        selectedItemColor: const Color(0xFFFF9800),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'List'),
        ],
      ),
    );
  }
}
