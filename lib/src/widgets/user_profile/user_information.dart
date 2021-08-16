import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';
import '../../utils/screen_util.dart';

class UserInformation extends StatelessWidget {
  bool isMyProfile;
  UserInformation({required this.isMyProfile});
  @override
  Widget build(BuildContext context) {
    ScreenUtil _screenUtil = ScreenUtil();
    late double UserInformationWidth;
    late double UserInformationHeight;
    if (Device.get().isPhone) {
      UserInformationWidth = _screenUtil.width(325);
      UserInformationHeight = _screenUtil.height(90);
      if (isMyProfile) {
        UserInformationHeight = _screenUtil.height(108);
      } else {
        UserInformationHeight = _screenUtil.height(90);
      }
    } else {
      UserInformationWidth = _screenUtil.width(718);
      UserInformationHeight = _screenUtil.height(113);
    }
    return Container(
      width: UserInformationWidth,
      height: UserInformationHeight,
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
                  padding: EdgeInsets.only(top: _screenUtil.height(5)),
                  width: _screenUtil.width(80),
                  child: Text("User Name",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.primaryBlack,
                      )),
                ),
                Text("Position",
                    style:
                        TextStyle(fontSize: 14, color: AppColor.primaryGrey)),
                SizedBox(
                  height: _screenUtil.height(11),
                ),
                Row(
                  children: [
                    Text(
                      "584 followers",
                      style:
                          TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                    ),
                    Container(
                        width: _screenUtil.width(24),
                        height: _screenUtil.height(24),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(UserProfileText.dot)))),
                    Text(
                      "24k likes",
                      style:
                          TextStyle(color: AppColor.primaryGrey, fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage(UserProfileText.edit))),
          )
        ],
      ),
    );
  }
}
