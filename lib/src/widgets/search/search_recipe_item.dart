import 'package:flutter/material.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/utils/screen_util.dart';

class SearchRecipeItem extends StatelessWidget {
  final String imageUrl;
  final String description;

  const SearchRecipeItem(
      {required this.imageUrl, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScreenUtil _screenUtil = ScreenUtil();
    return Container(
      margin: EdgeInsets.only(right: _screenUtil.width(15)),
      width: _screenUtil.width(120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imageUrl,
            height: _screenUtil.height(140),
            fit: BoxFit.cover,
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: AppColor.primaryBlack,
                ),
          ),
        ],
      ),
    );
  }
}
