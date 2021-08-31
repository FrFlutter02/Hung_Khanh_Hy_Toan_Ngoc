import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/widgets/new_recipe/item_new_category.dart';

import '../blocs/login_bloc/login_bloc.dart';
import '../blocs/login_bloc/login_event.dart';
import '../blocs/login_bloc/login_state.dart';
import '../widgets/custom_button.dart';
import '../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../blocs/new_recipe_bloc/new_recipe_state.dart';
import '../widgets/new_recipe/item_new_how_to_cook.dart';
import '../widgets/new_recipe/bottom_sheet_pick_image.dart';
import '../widgets/new_recipe/item_new_gallery.dart';
import '../widgets/new_recipe/item_new_ingredients.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/new_recipe/item_new_additional_info.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  NewRecipeScreenState createState() => NewRecipeScreenState();
}

enum ImageType { imageMain, imageForGallery, imageForIngredient }

class NewRecipeScreenState extends State<NewRecipeScreen> {
  final nameRecipeController = TextEditingController();
  final categoryController = TextEditingController();

  bool isTablet = false;
  File imageMain = File('');
  String user = "";
  StreamSubscription? authenStreamSubscription;

  @override
  void initState() {
    context.read<LoginBloc>().add(LogInGetUserRequested());
    authenStreamSubscription =
        context.read<LoginBloc>().stream.listen((loginState) {
      if (loginState is LoginGetUserSuccess) {
        user = loginState.user.email!;
        context
            .read<NewRecipeBloc>()
            .add(NewRecipeGetCategoriesRequested(user));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    authenStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Device.get().isTablet) {
      isTablet = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: BlocConsumer<NewRecipeBloc, NewRecipeState>(
        builder: (context, state) {
          return Stack(children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: isTablet ? 76.h : 30.h,
                      left: isTablet ? 113.w : 20.w,
                      bottom: 15.h),
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left_outlined),
                        Text(
                          NewRecipeText.leadingText,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: NewRecipeScreenColor.leadingTextColor),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: isTablet ? 118.w : 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isTablet
                            ? NewRecipeText.titleTabletText
                            : NewRecipeText.titleText,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: AppColor.primaryBlack,
                            height: 1.33,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: isTablet ? 25.h : 33.h),
                      Row(
                        children: [
                          Container(
                            height: 62.w,
                            width: 62.w,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      NewRecipeScreenColor.borderButtonColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  primary: AppColor.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: ((builder) => BottomSheetPickImage(
                                          typeImage: ImageType.imageMain,
                                        )),
                                  );
                                },
                                child: imageMain.path == ""
                                    ? Image.asset(
                                        "assets/images/icons/plus_icon.png")
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(imageMain.path),
                                          fit: BoxFit.fill,
                                          height: double.infinity,
                                          width: double.infinity,
                                        ),
                                      )),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    NewRecipeText.labelRecipeNameText,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2!
                                        .copyWith(
                                            height: 1.57,
                                            color: AppColor.secondaryGrey),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 15.h),
                                    child: SizedBox(
                                      height: isTablet ? 22.h : 20.h,
                                      child: TextField(
                                        controller: nameRecipeController,
                                        cursorColor: AppColor.green,
                                        decoration: InputDecoration(
                                          hintText:
                                              NewRecipeText.hintRecipeNameText,
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColor.green,
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ItemNewGallery(),
                      ItemNewIngredients(),
                      ItemNewHowToCook(),
                      ItemNewAdditionalInfo(),
                      SizedBox(height: isTablet ? 50.h : 20.h),
                      Text(
                        NewRecipeText.saveToText,
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: AppColor.primaryGrey,
                              height: 1.57,
                            ),
                      ),
                      SizedBox(height: 10.h),
                      Wrap(
                        children: [
                          ItemNewCategory(),
                          SizedBox(width: 15.w),
                          SizedBox(
                            height: 50.h,
                            width: isTablet ? 155.w : 120.w,
                            child: OutlinedButton(
                                onPressed: () async {
                                  context.read<NewRecipeBloc>().add(
                                      NewRecipeSaved(
                                          nameRecipeController.text, user));
                                },
                                style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                        color: AppColor.green, width: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                child: Text(
                                  NewRecipeText.saveRecipeText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: AppColor.green,
                                        letterSpacing: 0.32,
                                        height: 1.37,
                                      ),
                                )),
                          ),
                          SizedBox(width: isTablet ? 15.w : 0.w),
                          Container(
                            margin: EdgeInsets.only(top: isTablet ? 0.h : 30.h),
                            child: CustomButton(
                              height: 50.h,
                              width: isTablet ? 155.w : double.infinity,
                              value: NewRecipeText.postToFeedText,
                              buttonOnPress: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isTablet ? 70.h : 36.h),
                    ],
                  ),
                ),
              ],
            ),
            if (state is NewRecipeLoading)
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: (Container(
                      width: 1.sw,
                      height: 1.sh,
                      color: Colors.grey.withOpacity(0.2),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.green,
                        ),
                      ))))
          ]);
        },
        listener: (context, state) {
          print(state);
          switch (state.runtimeType) {
            case NewRecipeAddImageMainSuccess:
              state as NewRecipeAddImageMainSuccess;
              setState(() {
                imageMain = state.file;
              });
              break;
            case NewRecipeSaveRecipeSuccess:
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(NewRecipeText.saveNewRecipeSuccessText),
              ));
              break;
            case NewRecipeValidateFailure:
              state as NewRecipeValidateFailure;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "${state.props.where((e) => e.toString().isNotEmpty).join(', ')} should not be empty"),
              ));
              break;
          }
        },
      )),
    );
  }
}
