import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mobile_app/src/screens/login_screen.dart';
import 'package:mobile_app/src/screens/signup_screen.dart';
import '../screens/recipe_feed_screen.dart';
import '../../src/constants/constant_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    LoginScreen(),
    RecipeFeedScreen(),
    SignupScreen()
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
      bottomNavigationBar: SizedBox(
        height: 90.h,
        child: BottomNavigationBar(
          backgroundColor: AppColor.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/icons/search_icon.png'),
                  color:
                      _selectedIndex == 0 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Search'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AssetImage('assets/images/icons/carosel_icon.png'),
                  color:
                      _selectedIndex == 1 ? AppColor.green : AppColor.iconText,
                ),
                label: 'Recipe'),
            BottomNavigationBarItem(
                icon: Image(
                  image:
                      AssetImage('assets/images/icons/user_profile_icon.png'),
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
