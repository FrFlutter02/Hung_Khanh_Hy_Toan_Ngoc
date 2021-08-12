import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/utils/screen_util.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      width: Device.screenWidth,
      height: _screenUtil.height(46),
      padding: EdgeInsets.symmetric(horizontal: _screenUtil.width(11)),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryGrey.withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 8,
              offset: Offset(0, 0),
            ),
          ]),
      child: Row(
        children: [
          Image.asset(
            'assets/images/icons/search_icon.png',
            width: _screenUtil.width(24),
            height: _screenUtil.height(24),
            color: AppColor.primaryBlack,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(color: AppColor.primaryBlack),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _screenUtil.width(9),
                    vertical: _screenUtil.height(12)),
                hintText: 'Sweets',
                hintStyle: TextStyle(
                  color: AppColor.secondaryGrey,
                ),
                isDense: true,
              ),
            ),
          ),
          InkWell(
            child: Image.asset(
              'assets/images/icons/filter_icon.png',
              width: _screenUtil.width(24),
              height: _screenUtil.height(24),
              color: AppColor.primaryBlack,
            ),
          )
        ],
      ),
    );
  }
}

// Theme.of(context).textTheme.headline5!.copyWith(
//                   color: AppColor.primaryBlack,
//                   fontFamily: "Nunito-Bold",
//                 )