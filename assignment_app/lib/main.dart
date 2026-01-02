import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/home/screens/home_screen.dart';
import 'features/home/screens/favorites_screen.dart';
import 'features/home/screens/meal_planner_screen.dart';
import 'features/home/screens/create_recipe_screen.dart';
import 'features/home/state/home_controller.dart';
import 'features/shopping_list/state/shopping_list_controller.dart';
import 'features/shopping_list/screens/shopping_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyDummyKey',
        appId: '1:123456789:android:abcdef',
        messagingSenderId: '123456789',
        projectId: 'recipe-app-6fea3',
        databaseURL: 'https://recipe-app-6fea3-default-rtdb.firebaseio.com/',
      ),
    );
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => ShoppingListController()),
      ],
      child: RecipeApp(), 
    ),
  );
}

class RecipeApp extends StatelessWidget {
  RecipeApp({super.key}); 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Master Chef',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
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
      home: MainTabScreen(), 
    );
  }
}

class MainTabScreen extends StatefulWidget {
  MainTabScreen({super.key}); 

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(), 
    FavoritesScreen(), 
    const CreateRecipeScreen(),
    const MealPlannerScreen(),
    const ShoppingListScreen(),
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
        backgroundColor: Colors.black,
        selectedItemColor: const Color(0xFFFF9800),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Recipes'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Meal Plan'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Shopping'),
        ],
      ),
    );
  }
}
