import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../src/constants/constant_colors.dart';
import '../../src/screens/recipe_screen.dart';
import '../../src/screens/search_screen.dart';
import '../../src/screens/user_profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
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
      bottomNavigationBar: Container(
        color: AppColor.white,
        height: 90.h,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/icons/search_icon.jpg'),
                  color:
                      _selectedIndex == 0 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/icons/carosel_icon.jpg'),
                  color:
                      _selectedIndex == 1 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Recipe'),
            BottomNavigationBarItem(
                icon: Image(
                  image:
                      AssetImage('assets/images/icons/user_profile_icon.jpg'),
                  color:
                      _selectedIndex == 2 ? AppColor.green : AppColor.iconText,
                ),
                label: 'User profile')
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
