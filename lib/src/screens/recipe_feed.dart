import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/constants/constant_text.dart';
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
                padding: EdgeInsets.only(
                    left: _screenUtil.width(30),
                    top: _screenUtil.height(27),
                    bottom: _screenUtil.height(39)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(),
                    Wrap(
                      children: [
                        Image.asset('assets/images/icons/notifications.png'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: _screenUtil.width(25)),
                          child:
                              Image.asset('assets/images/icons/messages.png'),
                        ),
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
      width: _screenUtil.width(295),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryGrey.withOpacity(0.1),
              blurRadius: 12,
              spreadRadius: 8,
              offset: Offset(1, 1),
            ),
          ]),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/recipe_book/dau.jpg'),
                  ),
                ),
                width: Device.screenWidth,
                height: _screenUtil.height(396),
              ),
              Container(
                padding: EdgeInsets.only(left: _screenUtil.width(15)),
                color: AppColor.white.withOpacity(0.95),
                child: ListTile(
                  minLeadingWidth: 0,
                  horizontalTitleGap: _screenUtil.width(10),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: _screenUtil.height(-4)),
                  dense: true,
                  leading: CircleAvatar(
                    radius: _screenUtil.width(16),
                    backgroundImage: AssetImage('assets/users/user0.png'),
                  ),
                  title: Text(
                    'Profile Name',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: RecipeFeedColor.primaryBlack),
                  ),
                  subtitle: Text(
                    '2h ago',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: RecipeFeedColor.subtitleCardHeader),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(_screenUtil.width(15)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Red Wine and Mint Soufflé',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontSize: 18,
                          fontFamily: 'Nunito-SemiBold',
                          height: _screenUtil.height(18 / 32)),
                    ),
                    Image.asset('assets/images/icons/like.png'),
                  ],
                ),
                Text(
                    'Apparently we had reached a great height in the atmosphere, for the sky was…',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: AppColor.secondaryGrey,
                        height: _screenUtil.height(22 / 14))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('32 ${RecipeFeedText.likes}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AppColor.primaryGrey)),
                          Image.asset('assets/images/icons/dot.png'),
                          Text('8 ${RecipeFeedText.comments}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: AppColor.primaryGrey)),
                        ],
                      ),
                    ),
                    SaveButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(Icons.add, color: AppColor.green, size: 14),
      label: Text(
        RecipeFeedText.save,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: AppColor.green),
      ),
      style: OutlinedButton.styleFrom(
          // padding: EdgeInsets.symmetric(horizontal: 10),
          textStyle: TextStyle(color: AppColor.green),
          side: BorderSide(
            width: 1,
            color: AppColor.green,
            style: BorderStyle.solid,
          )),
      onPressed: () {},
    );
  }
}
