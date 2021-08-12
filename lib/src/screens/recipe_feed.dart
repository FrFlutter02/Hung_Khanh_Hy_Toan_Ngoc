import 'package:flutter/material.dart';
import '../constants/constant_colors.dart';
import '../utils/screen_util.dart';
import '../widgets/logo.dart';

class RecipeFeed extends StatelessWidget {
  const RecipeFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: _screenUtil.height(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(),
                    Wrap(
                      children: [
                        Image.asset('assets/icons/notifications.png'),
                        Image.asset('assets/icons/messages.png'),
                      ],
                    ),
                  ],
                ),
              ),
              recipeCard(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget recipeCard(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      width: 295,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryGrey.withOpacity(0.2),
              blurRadius: 15,
              spreadRadius: 12,
              offset: Offset(0, 8),
            ),
          ]),
      child: Column(
        children: [
          ListTile(
            horizontalTitleGap: _screenUtil.width(10),
            contentPadding: EdgeInsets.symmetric(
                horizontal: _screenUtil.width(0),
                vertical: _screenUtil.height(-4)),
            dense: true,
            leading: CircleAvatar(
              radius: _screenUtil.width(32),
              backgroundImage: AssetImage('assets/users/user0.png'),
            ),
            title: Text(
              'Profile Name',
              style: Theme.of(context).textTheme.caption,
            ),
            subtitle: Text(
              '2h ago',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AppColor.primaryGrey),
            ),
          ),
        ],
      ),
    );
  }
}
