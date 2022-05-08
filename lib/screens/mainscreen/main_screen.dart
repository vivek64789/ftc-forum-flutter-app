import 'package:flutter/material.dart';
import 'package:ftc_forum/screens/categories/categories_screen.dart';
import 'package:ftc_forum/screens/homescreen/home_screen.dart';
import 'package:ftc_forum/screens/profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static Page page() => const MaterialPage<void>(child: MainScreen());

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentNavigationIndex = 0;
  final screen = [
    HomeScreen(),
    const CategoriesScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentNavigationIndex,
        onTap: (index) {
          setState(() {
            currentNavigationIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Categories",
            icon: Icon(Icons.dashboard),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: screen[currentNavigationIndex],
    );
  }
}
