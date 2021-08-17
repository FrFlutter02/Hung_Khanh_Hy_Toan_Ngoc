import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/utils/image_picker.dart';

import '../widgets/new_recipe/bottom_sheet_pick_image.dart';
import '../widgets/new_recipe/item_new_gallery.dart';
import '../widgets/new_recipe/item_new_ingredients.dart';
import '../constants/constant_colors.dart';
import '../constants/constant_text.dart';
import '../widgets/new_recipe/item_new_recipe.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({Key? key}) : super(key: key);

  @override
  _NewRecipeScreenState createState() => _NewRecipeScreenState();
}

String dropdownValue = 'Western';
bool isTablet = false;
List<File> imageGallerys = [];
var imageMain;
File imageIngredient = File('');
int imageOverbalance = 0;
List<String> listRecipe = ['Western', 'Quick Lunch', 'Vegies'];
enum ImageType { imageMain, imageForGallery, imageForIngredient }
ImageType imageType = ImageType.imageMain;

class _NewRecipeScreenState extends State<NewRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    if (Device.get().isTablet) {
      isTablet = true;
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: isTablet ? 76.h : 30.h,
                left: isTablet ? 113.w : 20.w,
                bottom: 15.h),
            child: Row(
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
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isTablet ? 118.w : 25.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  NewRecipeText.titleText,
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
                            color: NewRecipeScreenColor.borderButtonColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                          onTap: () {
                            imageType = ImageType.imageMain;
                            showModalBottomSheet(
                              context: context,
                              builder: ((builder) => BottomSheetPickImage(
                                  photoCamera: () =>
                                      takePhoto(ImageSource.camera),
                                  photoGallery: () =>
                                      takePhoto(ImageSource.gallery))),
                            );
                          },
                          child: imageMain == null
                              ? Image.asset("assets/images/icons/plus_icon.png")
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(imageMain.path),
                                    fit: BoxFit.fill,
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
                                  decoration: InputDecoration(
                                      hintText:
                                          NewRecipeText.hintRecipeNameText,
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
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ItemNewGallery(
                  dataImage: imageGallerys,
                  imageOverbalance: imageOverbalance,
                  addImageGallery: () {
                    imageType = ImageType.imageForGallery;
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => BottomSheetPickImage(
                          photoCamera: () => takePhoto(ImageSource.camera),
                          photoGallery: () => takePhoto(ImageSource.gallery))),
                    );
                  },
                ),
                ItemNewIngredients(
                  dataImage: imageIngredient,
                  addImageIngredient: () {
                    imageType = ImageType.imageForIngredient;
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => BottomSheetPickImage(
                          photoCamera: () => takePhoto(ImageSource.camera),
                          photoGallery: () => takePhoto(ImageSource.gallery))),
                    );
                  },
                  resetImageIngredient: resetImageIngredient,
                ),
                ItemNewRecipe(
                  label: NewRecipeText.labelHowToCookText,
                  hintText: NewRecipeText.hintHowToCookText,
                ),
                ItemNewRecipe(
                  label: NewRecipeText.labelAdditionalInfoText,
                  hintText: NewRecipeText.hintAdditionalInfoText,
                ),
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
                    Container(
                      width: 190.w,
                      height: 50.h,
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
                        icon: Icon(Icons.expand_more_outlined),
                        iconSize: 23,
                        isExpanded: true,
                        style: const TextStyle(color: AppColor.primaryBlack),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                        items: listRecipe
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text("$value (${listRecipe.length})"),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(width: 15.w),
                    SizedBox(
                      height: 50.h,
                      width: isTablet ? 155.w : 120.w,
                      child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(color: AppColor.green, width: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            NewRecipeText.saveRecipeText,
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: AppColor.green,
                                      letterSpacing: 0.32,
                                      height: 1.37,
                                    ),
                          )),
                    ),
                    SizedBox(width: isTablet ? 15.w : 0.w),
                    Container(
                      width: isTablet ? 155.w : double.infinity,
                      height: 50.h,
                      margin: EdgeInsets.only(top: isTablet ? 0.h : 30.h),
                      child: TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: AppColor.green),
                        child: Text(
                          NewRecipeText.postToFeedText,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.white,
                                    height: 1.31,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: isTablet ? 70.h : 36.h),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Future takePhoto(ImageSource source) async {
    if (imageType == ImageType.imageMain) {}
    final file = await ImagePickerUtils.pickMedia(
      source: source,
    );
    if (file == null) return;
    setState(() => {
          if (imageType == ImageType.imageMain)
            {imageMain = file}
          else if (imageType == ImageType.imageForGallery)
            {
              imageGallerys.add(file),
              imageOverbalance = imageGallerys.length - 4
            }
          else
            {imageIngredient = file}
        });
  }

  resetImageIngredient() {
    setState(() {
      imageIngredient = File("");
    });
  }
}
