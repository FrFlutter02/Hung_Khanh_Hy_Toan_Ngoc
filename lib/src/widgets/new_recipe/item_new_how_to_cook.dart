import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:duration_picker/duration_picker.dart';

import '../../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../blocs/new_recipe_bloc/new_recipe_state.dart';
import '../../models/how_to_cook_model.dart';
import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';

class ItemNewHowToCook extends StatefulWidget {
  const ItemNewHowToCook({
    Key? key,
  }) : super(key: key);

  @override
  ItemNewHowToCookState createState() => ItemNewHowToCookState();
}

class ItemNewHowToCookState extends State<ItemNewHowToCook> {
  final List<HowToCookModel> howToCookList = [];
  final addLinkController = TextEditingController();
  final addStepController = TextEditingController();
  bool addLink = false;
  int step = 1;
  Duration? resultDuration = Duration(minutes: 3);
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    bool isTablet = false;
    if (Device.get().isTablet) {
      isTablet = true;
    }
    return BlocListener<NewRecipeBloc, NewRecipeState>(
      child: Container(
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    errorText,
                    style: TextStyle(color: AppColor.red),
                  )),
              errorText.isEmpty ? SizedBox.shrink() : SizedBox(height: 10.h),
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
                            context.read<NewRecipeBloc>().add(
                                NewRecipeAddLinkHowToCookSubmitted(
                                    addLinkController.text));
                            setState(() {
                              addLink = true;
                            });
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
                                    width: isTablet ? 460.w : 260.w,
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 5),
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
                                if (addStepController.text.isNotEmpty) {
                                  context.read<NewRecipeBloc>().add(
                                      NewRecipeAddStepHowToCookSubmitted(
                                          step,
                                          addStepController.text,
                                          resultDuration.toString()));
                                  step++;
                                  addStepController.text = "";
                                  resultDuration = Duration(minutes: 3);
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
                                  resultDuration = await showDurationPicker(
                                      context: context,
                                      initialTime: Duration(minutes: 3),
                                      decoration: BoxDecoration(
                                          color: AppColor.white,
                                          borderRadius:
                                              BorderRadius.circular(10)));
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
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
      ),
      listener: (context, state) {
        switch (state.runtimeType) {
          case NewRecipeAddStepHowToCookSuccess:
            state as NewRecipeAddStepHowToCookSuccess;
            setState(() {
              howToCookList.add(state.listStep);
            });
            break;
          case NewRecipeValidateSuccess:
            errorText = '';
            break;
          case NewRecipeValidateFailure:
            state as NewRecipeValidateFailure;
            errorText = state.howToCookErrorMessage;
            break;
        }
      },
    );
  }
}
