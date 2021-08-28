import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../screens/new_recipe_screen.dart';
import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../../blocs/new_recipe_bloc/new_recipe_state.dart';
import '../../constants/constant_text.dart';
import '../../models/ingredients_model.dart';
import '../../constants/constant_colors.dart';
import 'bottom_sheet_pick_image.dart';

class ItemNewIngredients extends StatefulWidget {
  const ItemNewIngredients({
    Key? key,
  }) : super(key: key);

  @override
  ItemNewIngredientsState createState() => ItemNewIngredientsState();
}

class ItemNewIngredientsState extends State<ItemNewIngredients> {
  final List<IngredientModel> ingredientList = [];
  final addIngredientController = TextEditingController();
  bool checkImage = false;
  File imageIngredient = File('');
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    if (imageIngredient.path != "") {
      checkImage = true;
    } else {
      checkImage = false;
    }
    return BlocListener<NewRecipeBloc, NewRecipeState>(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.white,
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorText,
                    style: TextStyle(color: AppColor.red),
                  )),
              errorText.isEmpty ? SizedBox.shrink() : SizedBox(height: 10.h),
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
                                    color:
                                        AppColor.primaryBlack.withOpacity(0.5),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    data.ingredient,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                                if (data.image.path != "")
                                  (Container(
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
                                  ))
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
                    border: Border.all(
                        color: NewRecipeScreenColor.borderButtonColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: InkWell(
                        onTap: () async {
                          if (addIngredientController.text.isNotEmpty) {
                            context.read<NewRecipeBloc>().add(
                                NewRecipeAddIngredientSubmitted(
                                    addIngredientController.text,
                                    imageIngredient));
                            setState(() {
                              addIngredientController.text = "";
                              imageIngredient = File("");
                            });
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
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => BottomSheetPickImage(
                                  typeImage: ImageType.imageForIngredient,
                                )),
                          );
                        },
                        child: checkImage
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  File(imageIngredient.path),
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
      ),
      listener: (context, state) {
        switch (state.runtimeType) {
          case NewRecipeAddIngredientSuccess:
            state as NewRecipeAddIngredientSuccess;
            setState(() {
              ingredientList.add(state.ingredient);
            });
            break;
          case NewRecipeAddImageIngredientSuccess:
            state as NewRecipeAddImageIngredientSuccess;
            setState(() {
              imageIngredient = state.file;
            });
            break;
          case NewRecipeValidateSuccess:
            errorText = '';
            break;
          case NewRecipeValidateFailure:
            state as NewRecipeValidateFailure;
            errorText = state.ingredientsErrorMessage;
            break;
        }
      },
    );
  }
}
