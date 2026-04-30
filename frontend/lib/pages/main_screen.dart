import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sri_cuisine/pages/available_ingredients_screen.dart';
import 'package:sri_cuisine/pages/home_page.dart';
import 'package:sri_cuisine/pages/profile_page.dart';
import 'package:sri_cuisine/pages/recipes_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Scaffold(
      body: HomePage(),
    ),
    Scaffold(
      body: AvailableIngredientsScreen(),
    ),
    Scaffold(
      body: RecipesPage(),
    ),
    const Scaffold(
      body: ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: GNav(
          gap: 10,
          backgroundColor: Colors.transparent,
          color: colorScheme.onSurfaceVariant,
          activeColor: colorScheme.primary,
          tabBackgroundColor: colorScheme.primary.withOpacity(0.12),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: CupertinoIcons.square_grid_2x2_fill,
              text: 'Ingredients',
            ),
            GButton(
              icon: Icons.restaurant_menu,
              text: 'Recipes',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }
}
