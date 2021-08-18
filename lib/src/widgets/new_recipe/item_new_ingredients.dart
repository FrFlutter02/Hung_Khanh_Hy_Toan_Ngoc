import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

import '../../models/ingredients_model.dart';
import '../../constants/constant_colors.dart';

class ItemNewIngredients extends StatefulWidget {
  const ItemNewIngredients({
    Key? key,
    required this.dataImage,
    required this.addImageIngredient,
    required this.resetImageIngredient,
  }) : super(key: key);
  final File dataImage;
  final void Function() addImageIngredient;
  final void Function() resetImageIngredient;

  @override
  _ItemNewIngredientsState createState() => _ItemNewIngredientsState();
}

final List<IngredientModel> ingredientList = [];
final addIngredientController = TextEditingController();
bool checkImage = false;

class _ItemNewIngredientsState extends State<ItemNewIngredients> {
  @override
  Widget build(BuildContext context) {
    if (widget.dataImage.path != "") {
      checkImage = true;
    } else {
      checkImage = false;
    }
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  NewRecipeText.labelIngredientsText,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.37,
                        color: AppColor.primaryBlack,
                      ),
                ),
                Image.asset("assets/images/icons/edit_icon.png")
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              child: Column(
                children: ingredientList
                    .map((data) => Container(
                          height: 50.h,
                          padding: EdgeInsets.only(left: 15.w, right: 5.w),
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      NewRecipeScreenColor.borderButtonColor),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: Icon(
                                  Icons.add_outlined,
                                  size: 20,
                                  color: AppColor.primaryBlack.withOpacity(0.5),
                                ),
                              ),
                              Expanded(
                                child: Text(data.ingredient),
                              ),
                              Container(
                                height: 39.h,
                                width: 56.w,
                                decoration: BoxDecoration(
                                    color: NewRecipeScreenColor
                                        .buttonIngredientsColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    File(data.image.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              height: 50.h,
              padding: EdgeInsets.only(left: 15.w, right: 5.w),
              margin: EdgeInsets.only(bottom: 10.h),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: NewRecipeScreenColor.borderButtonColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: InkWell(
                      onTap: () {
                        if (addIngredientController.text.isNotEmpty &&
                            checkImage) {
                          addIngredient(
                              addIngredientController.text, widget.dataImage);
                          setState(() {
                            addIngredientController.text = "";
                          });
                          widget.resetImageIngredient();
                        }
                      },
                      child: Icon(
                        Icons.add_outlined,
                        size: 20,
                        color: AppColor.primaryBlack.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: addIngredientController,
                      cursorColor: AppColor.green,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 7),
                        hintText: NewRecipeText.hintIngredientsText,
                      ),
                    ),
                  ),
                  Container(
                    height: 39.h,
                    width: 56.w,
                    decoration: BoxDecoration(
                        color: NewRecipeScreenColor.buttonIngredientsColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: InkWell(
                      onTap: widget.addImageIngredient,
                      child: checkImage
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                File(widget.dataImage.path),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              "assets/images/icons/image_icon.png",
                              height: 28.w,
                              width: 28.w,
                            ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addIngredient(String textIngredient, File imageIngredient) {
    final ingredient = IngredientModel(
      id: DateTime.now().toString(),
      ingredient: textIngredient,
      image: imageIngredient,
    );
    setState(() {
      ingredientList.add(ingredient);
    });
  }
}
