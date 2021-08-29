import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_notification.dart';
import '../blocs/post_bloc/post_bloc.dart';
import '../blocs/post_bloc/post_event.dart';
import '../blocs/post_bloc/post_state.dart';
import '../widgets/recipe_feed/recipe_card_mobile.dart';
import '../widgets/recipe_feed/recipe_card_tablet.dart';
import '../widgets/top_bar_tablet.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/custom_button.dart';
import '../widgets/logo.dart';

class RecipeFeedScreen extends StatefulWidget {
  const RecipeFeedScreen({Key? key}) : super(key: key);

  @override
  RecipeFeedScreenState createState() => RecipeFeedScreenState();
}

class RecipeFeedScreenState extends State<RecipeFeedScreen> {
  PageController pageviewController = PageController();

  ScrollController listviewController = ScrollController();
  int currentpage = 0;
  bool isTablet = false;
  double viewPortFraction = 0.84;

  @override
  initState() {
    super.initState();
    if (Device.get().isTablet) {
      isTablet = true;
    }
    pageviewController = PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: viewPortFraction,
    );
    context.read<PostBloc>().add(PostRequested());
  }

  @override
  dispose() {
    pageviewController.dispose();
    listviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: isTablet
          ? PreferredSize(
              preferredSize: Size.fromHeight(80.h),
              child: Container(
                margin: EdgeInsets.only(top: 24.h),
                child: Wrap(
                  children: [
                    TopBarTablet(),
                    Divider(
                        height: 1.h,
                        thickness: 2.h,
                        color: RecipeFeedColor.dividerColor),
                  ],
                ),
              ),
            )
          : PreferredSize(
              preferredSize: Size.fromHeight(60.h),
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, top: 60.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Logo(),
                    CustomNotification(
                      isTablet: false,
                    )
                  ],
                ),
              ),
            ),
      body: isTablet
          ? SingleChildScrollView(
              child: Column(
                children: [
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
                  SizedBox(height: 10.h),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, state) {
                      if (state is PostLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(AppColor.green),
                          ),
                        );
                      }
                      if (state is PostLoadSuccess) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.posts.length,
                          controller: listviewController,
                          itemBuilder: (context, index) {
                            return RecipeCardTablet(
                              post: state.posts[index],
                              user: state.users[index],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            RecipeFeedText.loadingFail,
                            style: TextStyle(color: Colors.black, fontSize: 50),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            )
          : BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                if (state is PostLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColor.green),
                    ),
                  );
                }
                if (state is PostLoadSuccess) {
                  return PageView.builder(
                    itemCount: state.posts.length > 5 ? 5 : state.posts.length,
                    onPageChanged: (value) {
                      setState(() {
                        currentpage = value;
                      });
                    },
                    controller: pageviewController,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 39.h),
                        child: index == currentpage
                            ? RecipeCardMobile(
                                post: state.posts[index],
                                user: state.users[index],
                              )
                            : Opacity(
                                opacity: 0.5,
                                child: RecipeCardMobile(
                                  post: state.posts[index],
                                  user: state.users[index],
                                )),
                      );
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                    RecipeFeedText.loadingFail,
                    style: TextStyle(color: Colors.black, fontSize: 50),
                  ));
                }
              },
            ),
    );
  }
}
