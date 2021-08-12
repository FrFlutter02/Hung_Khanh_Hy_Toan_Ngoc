import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/utils/screen_util.dart';
import 'package:mobile_app/src/widgets/search/search_recipe_item.dart';

final ScreenUtil _screenUtil = ScreenUtil();

class SearchRecipes extends StatelessWidget {
  const SearchRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recipes',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColor.primaryBlack,
                    fontFamily: "Nunito-Bold",
                  ),
            ),
            Text(
              'show all (200+)',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: AppColor.green,
                    fontFamily: "Nunito-Bold",
                  ),
            ),
          ],
        ),
        SizedBox(
          height: _screenUtil.height(15),
        ),
        Container(
          width: Device.screenWidth,
          height: _screenUtil.height(194),
          child: _renderRecipes(context),
        ),
        SizedBox(
          height: _screenUtil.height(50),
        ),
        Container(
          width: Device.screenWidth,
          height: _screenUtil.height(1),
          color: SearchScreenColor.primaryGrey,
        )
      ],
    );
  }

  _renderRecipes(BuildContext context) {
    final List<Map<String, dynamic>> mockRecipes = [
      {'id': 1, 'image': '123', 'description': 'Banana and Mandarin Buns'},
      {'id': 2, 'image': '456', 'description': 'Banana and Mandarin Buns'},
      {'id': 3, 'image': '789', 'description': 'nani bakanaa....'},
    ];

    return ListView(scrollDirection: Axis.horizontal, children: [
      ...mockRecipes.asMap().entries.map((entry) {
        return SearchRecipeItem(
          imageUrl: 'assets/images/UxRhrU8fPHQ.jpg',
          description: mockRecipes[entry.key]['description'] ?? '',
        );
      }).toList(),
    ]);
  }
}
