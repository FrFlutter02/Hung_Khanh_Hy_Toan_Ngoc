import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duration_picker/duration_picker.dart';

import '../../models/how_to_cook_model.dart';
import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';

class ItemNewHowToCook extends StatefulWidget {
  const ItemNewHowToCook({
    Key? key,
  }) : super(key: key);

  @override
  _ItemNewHowToCookState createState() => _ItemNewHowToCookState();
}

final List<HowToCookModel> howToCookList = [];
final addLinkController = TextEditingController();
final addStepController = TextEditingController();

bool addLink = false;

class _ItemNewHowToCookState extends State<ItemNewHowToCook> {
  Duration? resultDuration = Duration(minutes: 3);
  int step = 1;
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
                  NewRecipeText.labelHowToCookText,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        height: 1.37,
                        color: AppColor.primaryBlack,
                      ),
                ),
                Image.asset("assets/images/icons/edit_icon.png")
              ],
            ),
            SizedBox(height: 20.h),
            if (addLink == false)
              (Container(
                height: 50.h,
                width: double.infinity,
                padding: EdgeInsets.only(
                    top: 10.h, bottom: 10.h, left: 15.w, right: 5.w),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: NewRecipeScreenColor.borderButtonColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15.w),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            addLink = true;
                          });
                          print(addLink);
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
                        controller: addLinkController,
                        cursorColor: AppColor.green,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 7.h),
                          hintText: NewRecipeText.hintHowToCookText,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
            else
              (Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.smart_display_outlined,
                            size: 26,
                            color: AppColor.green.withOpacity(0.7),
                          ),
                        ),
                        Expanded(
                            child: Text(
                          addLinkController.text,
                          style: Theme.of(context).textTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                        )),
                      ],
                    ),
                  ),
                  Column(
                    children: howToCookList
                        .map((data) => Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 22.w,
                                  width: 22.w,
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: AppColor.green)),
                                  child: Center(
                                      child: Text(
                                    "${data.step}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(color: AppColor.green),
                                  )),
                                ),
                                Container(
                                  width: 260.w,
                                  padding:
                                      const EdgeInsets.only(left: 15, right: 5),
                                  child: Text(
                                    "${data.textHowToCook}",
                                    softWrap: true,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                ),
                              ],
                            )))
                        .toList(),
                  ),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 5.h, bottom: 5.h, left: 15.w, right: 5.w),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: NewRecipeScreenColor.borderButtonColor),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15.w),
                          child: InkWell(
                            onTap: () {
                              addHowToCook(addStepController.text,
                                  resultDuration.toString());
                              step++;
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
                            controller: addStepController,
                            cursorColor: AppColor.green,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom: 8.h),
                              hintText: NewRecipeText.stepHintText,
                            ),
                          ),
                        ),
                        Container(
                          height: 39.h,
                          width: 56.w,
                          decoration: BoxDecoration(
                              color:
                                  NewRecipeScreenColor.buttonIngredientsColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                              onTap: () async {
                                resultDuration = Duration(minutes: 3);
                                resultDuration = await showDurationPicker(
                                    context: context,
                                    initialTime: Duration(minutes: 3),
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius:
                                            BorderRadius.circular(10)));
                                // var resultDurationString = resultDuration.toString().split(".");
                              },
                              child: Icon(Icons.timer_outlined)),
                        )
                      ],
                    ),
                  ),
                ],
              ))
          ],
        ),
      ),
    );
  }

  void addHowToCook(String textHowToCook, String duration) {
    final howToCook = HowToCookModel(
        id: DateTime.now().toString(),
        step: step,
        textHowToCook: textHowToCook,
        duration: duration);
    setState(() {
      howToCookList.add(howToCook);
    });
  }
}
