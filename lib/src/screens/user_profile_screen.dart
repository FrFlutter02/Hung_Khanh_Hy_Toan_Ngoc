import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../utils/screen_util.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    if (Device.get().isPhone) {
      return Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _screenUtil.height(49),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 25),
                    child: Text(
                      UserProfileText.title,
                      style: TextStyle(
                        color: AppColor.primaryBlack,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: _screenUtil.width(124)),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: _screenUtil.height(20),
                            width: _screenUtil.width(20),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(UserProfileText.icon))),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              UserProfileText.iconText,
                              style: TextStyle(
                                  color: AppColor.green, fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: _screenUtil.height(30),
              ),
              Container(
                margin: EdgeInsets.only(left: _screenUtil.width(25)),
                width: _screenUtil.width(325),
                height: _screenUtil.height(108),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: AppColor.primaryWhite))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 41,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: _screenUtil.width(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(top: _screenUtil.height(5)),
                            width: _screenUtil.width(80),
                            child: Text("User Name",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.primaryBlack,
                                )),
                          ),
                          Text("Position",
                              style: TextStyle(
                                  fontSize: 14, color: AppColor.primaryGrey)),
                          SizedBox(
                            height: _screenUtil.height(11),
                          ),
                          Row(
                            children: [
                              Text(
                                "584 followers",
                                style: TextStyle(
                                    color: AppColor.primaryGrey, fontSize: 14),
                              ),
                              Container(
                                  width: _screenUtil.width(24),
                                  height: _screenUtil.height(24),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              UserProfileText.dot)))),
                              Text(
                                "24k likes",
                                style: TextStyle(
                                    color: AppColor.primaryGrey, fontSize: 14),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(UserProfileText.edit))),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: _screenUtil.height(25),
              ),
              Container(
                height: _screenUtil.height(520),
                width: _screenUtil.width(325),
                margin: EdgeInsets.only(left: _screenUtil.width(25)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                color: AppColor.green,
                              ))),
                              child: Column(
                                children: [
                                  Text("20",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColor.primaryBlack,
                                      )),
                                  Text("Recipes",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: AppColor.primaryBlack,
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("75",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.primaryBlack,
                                    )),
                                Text("Saved",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.primaryBlack,
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: TextButton(
                            onPressed: () {},
                            child: Column(
                              children: [
                                Text("248",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.primaryBlack,
                                    )),
                                Text("Following",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: AppColor.primaryBlack,
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 4,
                          itemBuilder: (context, int index) => Container(
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Container(
                                      width: _screenUtil.width(155),
                                      height: _screenUtil.height(100),
                                      color: Colors.amberAccent,
                                    )
                                  ],
                                ),
                              )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold();
    }
  }
}

class RecipeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
