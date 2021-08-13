import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/constant_colors.dart';

class ItemNewIngredients extends StatelessWidget {
  const ItemNewIngredients({
    Key? key,
    required this.label,
    required this.hintText,
  }) : super(key: key);
  final String label;
  final String hintText;
  @override
  Widget build(BuildContext context) {
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
                  label,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.37,
                        color: AppColor.primaryBlack,
                      ),
                ),
                Image.asset("assets/images/icons/edit_icon.png")
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 50.h,
              child: Container(
                padding: EdgeInsets.only(left: 15.w, right: 5.w),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: NewRecipeScreenColor.borderButtonColor),
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
                      child: TextField(
                        cursorColor: AppColor.green,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 7),
                          hintText: hintText,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 39.h,
                        width: 56.w,
                        decoration: BoxDecoration(
                            color: NewRecipeScreenColor.buttonIngredientsColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Image.asset(
                          "assets/images/icons/image_icon.png",
                          height: 28.w,
                          width: 28.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
