import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';

class ItemNewAdditionalInfo extends StatefulWidget {
  const ItemNewAdditionalInfo({
    Key? key,
  }) : super(key: key);

  @override
  ItemNewAdditionalInfoState createState() => ItemNewAdditionalInfoState();
}

class ItemNewAdditionalInfoState extends State<ItemNewAdditionalInfo> {
  final addServingTimeController = TextEditingController();
  final addNutritionTimeController = TextEditingController();
  final addTagsController = TextEditingController();
  bool addInfo = false;
  bool saveInfo = false;
  @override
  Widget build(BuildContext context) {
    bool isTablet = false;
    if (Device.get().isTablet) {
      isTablet = true;
    }
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5),
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
                  NewRecipeText.labelAdditionalInfoText,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.37,
                        color: AppColor.primaryBlack,
                      ),
                ),
                if (addInfo == false)
                  (Image.asset("assets/images/icons/edit_icon.png"))
                else
                  (InkWell(
                    onTap: () {
                      setState(() {
                        addInfo = false;
                      });
                    },
                    child: Icon(Icons.close),
                  ))
              ],
            ),
            SizedBox(height: 20.h),
            if (addInfo == false)
              (InkWell(
                onTap: () {
                  setState(() {
                    addInfo = true;
                    saveInfo = false;
                    addServingTimeController.text = "";
                    addNutritionTimeController.text = "";
                    addTagsController.text = "";
                  });
                },
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: 5.h, bottom: 5.h, left: 15.w, right: 0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: NewRecipeScreenColor.borderButtonColor),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(
                          Icons.add_outlined,
                          size: 20,
                          color: AppColor.primaryBlack.withOpacity(0.5),
                        ),
                      ),
                      Expanded(
                        child: Text(NewRecipeText.hintAdditionalInfoText,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color:
                                        AppColor.primaryBlack.withOpacity(0.5),
                                    fontSize: 17)),
                      ),
                    ],
                  ),
                ),
              ))
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(NewRecipeText.servingTimeText,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColor.secondaryGrey)),
                    saveInfo
                        ? Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            width: isTablet ? 480.w : 280.w,
                            child: Text(
                              addServingTimeController.text,
                              softWrap: true,
                              style: Theme.of(context).textTheme.subtitle1,
                            ))
                        : TextField(
                            controller: addServingTimeController,
                            cursorColor: AppColor.green,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.green,
                                  width: 2,
                                ),
                              ),
                            )),
                    SizedBox(height: 12.h),
                    Text(NewRecipeText.nutritionFactText,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColor.secondaryGrey)),
                    saveInfo
                        ? Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            width: isTablet ? 480.w : 280.w,
                            child: Text(
                              addNutritionTimeController.text,
                              softWrap: true,
                              style: Theme.of(context).textTheme.subtitle1,
                            ))
                        : TextField(
                            controller: addNutritionTimeController,
                            cursorColor: AppColor.green,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.green,
                                  width: 2,
                                ),
                              ),
                            )),
                    SizedBox(height: 12.h),
                    Text(NewRecipeText.tagsText,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: AppColor.secondaryGrey)),
                    saveInfo
                        ? Container(
                            margin: EdgeInsets.only(top: 10.h),
                            padding: EdgeInsets.symmetric(horizontal: 6.w),
                            width: isTablet ? 480.w : 280.w,
                            child: Text(
                              addTagsController.text,
                              softWrap: true,
                              style: Theme.of(context).textTheme.subtitle1,
                            ))
                        : TextField(
                            controller: addTagsController,
                            cursorColor: AppColor.green,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColor.green,
                                  width: 2,
                                ),
                              ),
                            )),
                    SizedBox(height: 12.h),
                    if (saveInfo == false)
                      (SizedBox(
                        height: 35,
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {
                              context.read<NewRecipeBloc>().add(
                                  NewRecipeSaveAdditionalInfoSubmitted(
                                      addServingTimeController.text,
                                      addNutritionTimeController.text,
                                      addTagsController.text));
                              setState(() {
                                saveInfo = true;
                              });
                            },
                            child: Text(
                              NewRecipeText.saveInfoText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                      color: AppColor.green,
                                      fontWeight: FontWeight.w500),
                            )),
                      ))
                  ],
                )),
              )
          ],
        ),
      ),
    );
  }
}
