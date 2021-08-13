import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/screens/recipe_screen.dart';
import 'package:mobile_app/src/screens/search_screen.dart';
import 'package:mobile_app/src/screens/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// This is the private State class that goes with HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    SearchScreen(),
    RecipeScreen(),
    UserProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/search_icon.jpg'),
                color: _selectedIndex == 0 ? AppColor.green : AppColor.iconText,
              ),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/carosel_icon.jpg'),
                color: _selectedIndex == 1 ? AppColor.green : AppColor.iconText,
              ),
              label: 'Recipe'),
          BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/images/user_profile_icon.jpg'),
                color: _selectedIndex == 2 ? AppColor.green : AppColor.iconText,
              ),
              label: 'User profile')
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
