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
      child: const RecipeApp(),
    ),
  );
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        // Primary dark background color for the app's body
        scaffoldBackgroundColor: const Color(0xFF0A0A0A), 
        // Orange color for the top header section
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF9800), // A vibrant orange
        ),
        // Set an accent color for selected items in BottomNavBar, etc.
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange, // A swatch for overall theming
          brightness: Brightness.dark,
        ).copyWith(
          secondary: const Color(0xFFFF9800), // Orange for accent elements
        ),
      ),
      home: const MainTabScreen(),
    );
  }
}

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({super.key});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    Placeholder(child: Text('Favorites Screen')),
    Placeholder(child: Text('Create Recipe Screen')),
    Placeholder(child: Text('Meal Planner Screen')),
    Placeholder(child: Text('Shopping List Screen')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The Scaffold background will be the dark color from ThemeData
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // The bottom navigation bar has a slightly different dark shade
        backgroundColor: const Color(0xFF0A0A0A), 
        selectedItemColor: const Color(0xFFFF9800), // Orange selected color
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'), // Changed add to add_circle for visual
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'List'),
        ],
      ),
    );
  }
}