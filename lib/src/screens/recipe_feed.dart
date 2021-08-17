import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/repository.dart';

import '../widgets/outline_icon_button.dart';
import '../widgets/custom_button.dart';
import '../widgets/icon_button_custom.dart';
import '..//widgets/top_bar_tablet.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';
import '../widgets/logo.dart';

class RecipeFeed extends StatefulWidget {
  const RecipeFeed({Key? key}) : super(key: key);

  @override
  _RecipeFeedState createState() => _RecipeFeedState();
}

class _RecipeFeedState extends State<RecipeFeed> {
  PageController controller = PageController();
  int currentpage = 0;
  bool isTablet = false;
  double viewPortFraction = 0.85;

  final boxDecorationStyle = BoxDecoration(
    color: AppColor.white,
    borderRadius: BorderRadius.circular(8.r),
    boxShadow: [
      BoxShadow(
        color: AppColor.secondaryGrey.withOpacity(0.15),
        blurRadius: 8,
        spreadRadius: 10,
        offset: Offset(0, 0),
      ),
    ],
  );

  @override
  initState() {
    super.initState();
    if (Device.get().isTablet) {
      isTablet = true;
    }
    controller = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: viewPortFraction,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: isTablet
            ? Column(
                children: [
                  TopBarTablet(),
                  Divider(
                      height: 1.h,
                      thickness: 1.h,
                      color: RecipeFeedColor.dividerColor),
                  Container(
                    height: 80.h,
                    margin: EdgeInsets.only(left: 25.w, right: 25.w, top: 25.h),
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: boxDecorationStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '286 ${RecipeFeedText.ofYourFollowersAreOnline}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: AppColor.primaryBlack, fontSize: 14.sp),
                        ),
                        CustomButton(
                            width: 128.w,
                            height: 36.h,
                            value: RecipeFeedText.textButton,
                            buttonOnPress: () {}),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return recipeCardTablet(context);
                      },
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30.w, top: 31.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Logo(),
                        Wrap(
                          children: [
                            IconButtonCustom(
                              icons: 'assets/images/icons/notifications.png',
                              onTap: () {},
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25.w),
                              child: IconButtonCustom(
                                icons: 'assets/images/icons/messages.png',
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      itemCount: 5,
                      onPageChanged: (value) {
                        setState(() {
                          currentpage = value;
                        });
                      },
                      controller: controller,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 39.h),
                          child: recipeCardMobile(
                            context,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.amber,
                    height: 90.h,
                    width: double.infinity,
                    child: Text('BottomNavigationBar'),
                  )
                ],
              ),
      ),
    );
  }

  Widget recipeCardMobile(BuildContext context) {
    return Container(
      width: 195.w,
      decoration: boxDecorationStyle,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8.r),
      //   boxShadow: [
      //     BoxShadow(
      //       color: AppColor.secondaryGrey.withOpacity(0.15),
      //       blurRadius: 6,
      //       spreadRadius: 6,
      //       offset: Offset(0, 0),
      //     ),
      //   ],
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/recipe_book/dau.jpg'),
                  ),
                ),
                width: Device.screenWidth,
                height: 396.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.r),
                    topRight: Radius.circular(8.r),
                  ),
                  color: AppColor.white.withOpacity(0.95),
                ),
                height: 62.h,
                padding: EdgeInsets.only(left: 15.w),
                child: CardHeader(),
              ),
            ],
          ),
          Container(
            height: 160.h,
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: CardContent(
              title: 'Red Wine and Mint Soufflé',
              subtitle: 'Apparently we had reached a great height in '
                  'the atmosphere, for the sky was…',
            ),
          ),
        ],
      ),
    );
  }

  Widget recipeCardTablet(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(25.w, 20.h, 25.w, 0.h),
      decoration: boxDecorationStyle,
      child: Row(
        children: [
          Container(
            height: 240.h,
            width: 240.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/recipe_book/pizza.jpg'),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.45.w, top: 15.h),
                  child: CardHeader(),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.fromLTRB(14.45.w, 0.h, 14.55.w, 15.h),
                  child: CardContent(
                    isTablet: false,
                    title: 'Tofu Salad Ginger Garlic',
                    subtitle:
                        'I thought this salad was exceptionally delicious and healthy. I recommend pressing the entire tofu block for at least 20 minutes before to remove excess water in the ...',
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 16.r,
          backgroundImage: AssetImage('assets/users/user0.png'),
        ),
        SizedBox(width: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Name',
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: AppColor.primaryBlack, fontSize: 12.sp),
            ),
            Text(
              '2h ago',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  color: RecipeFeedColor.subtitleCardHeader, fontSize: 12.sp),
            ),
          ],
        ),
      ],
    );
  }
}

class CardContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isTablet;
  const CardContent(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.isTablet = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: 18.sp,
                    fontFamily: 'Nunito-SemiBold',
                    // height: (32 / 18).h
                  ),
            ),
            IconButtonCustom(
              icons: 'assets/images/icons/like.png',
              onTap: () {},
            )
          ],
        ),
        Text(
          subtitle,
          maxLines: 3,
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
              color: AppColor.secondaryGrey,
              height: (22 / 14).h,
              fontSize: 14.sp),
        ),
        isTablet ? SizedBox(height: 18.h) : SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    '32 ${RecipeFeedText.likes}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColor.primaryGrey, fontSize: 14.sp),
                  ),
                  Image.asset('assets/images/icons/dot.png'),
                  Text(
                    '8 ${RecipeFeedText.comments}',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: AppColor.primaryGrey, fontSize: 14.sp),
                  ),
                ],
              ),
            ),
            OutlineIconButton(
              icons: 'assets/images/icons/add.png',
              title: RecipeFeedText.save,
            ),
          ],
        ),
      ],
    );
  }
}