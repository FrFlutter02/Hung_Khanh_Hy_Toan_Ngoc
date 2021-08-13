import 'package:flutter/material.dart';

import 'package:mobile_app/src/constants/constant_colors.dart';
import '../widgets/new_recipe/item_new_recipe.dart';
import '../constants/constant_text.dart';
import '../constants/constant_colors.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

String dropdownValue = 'Western';

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              children: [
                Icon(Icons.chevron_left_outlined),
                Text(
                  NewRecipeText.leadingText,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(color: NewRecipeScreenColor.leadingTextColor),
                )
              ],
            ),
            SizedBox(height: 15),
            Text(
              NewRecipeText.titleText,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: AppColor.primaryBlack,
                  height: 1.33,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(
                  height: 62,
                  width: 62,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: NewRecipeScreenColor.borderButtonColor,
                              width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Image.asset("assets/images/icons/plus_icon.png")),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        NewRecipeText.recipeNameText,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            height: 1.57,
                            // fontFamily: "Nunito-Regular",
                            color: AppColor.secondaryGrey),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 20,
                          width: 247,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: NewRecipeText.hintRecipeNameText,
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: NewRecipeScreenColor
                                            .borderUnderlineTextFieldColor))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            ItemNewRecipe(
              label: NewRecipeText.labelGalleryText,
              hintText: NewRecipeText.hintGalleryText,
            ),
            ItemNewRecipe(
              label: NewRecipeText.labelIngredientsText,
              hintText: NewRecipeText.hintIngredientsText,
            ),
            ItemNewRecipe(
              label: NewRecipeText.labelHowToCookText,
              hintText: NewRecipeText.hintHowToCookText,
            ),
            ItemNewRecipe(
              label: NewRecipeText.labelAdditionalInfoText,
              hintText: NewRecipeText.hintAdditionalInfoText,
            ),
            SizedBox(height: 20),
            Text(
              NewRecipeText.saveToText,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: AppColor.primaryGrey,
                    height: 1.57,
                  ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 190,
                  height: 50,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.expand_more_outlined),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(color: AppColor.primaryBlack),
                    underline: SizedBox(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Western', 'Quick Lunch', 'Vegies']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 120,
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColor.green, width: 2),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Text(
                        NewRecipeText.saveRecipeText,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.green,
                              letterSpacing: 0.32,
                              height: 1.37,
                            ),
                      )),
                )
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor:
                        NewRecipeScreenColor.borderUnderlineTextFieldColor),
                child: Text(
                  NewRecipeText.postToFeedText,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                        height: 1.31,
                      ),
                ),
              ),
            ),
            SizedBox(height: 36),
          ],
        ),
      )),
    );
  }
}
