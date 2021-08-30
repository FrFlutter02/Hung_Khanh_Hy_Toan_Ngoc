import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../blocs/new_recipe_bloc/new_recipe_state.dart';
import '../../screens/new_recipe_screen.dart';
import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';
import 'bottom_sheet_pick_image.dart';

class ItemNewGallery extends StatefulWidget {
  const ItemNewGallery({
    Key? key,
  }) : super(key: key);

  @override
  ItemNewGalleryState createState() => ItemNewGalleryState();
}

class ItemNewGalleryState extends State<ItemNewGallery> {
  List<File> imageGallerys = [];
  int imageOverbalance = 0;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    int imageOverbalance = 0;
    int imageLimit = 4;
    bool isTablet = false;
    if (Device.get().isTablet) {
      isTablet = true;
      imageLimit = 7;
    }
    if (imageGallerys.length > imageLimit) {
      imageOverbalance = imageGallerys.length - imageLimit;
      imageGallerys.removeRange(imageLimit, imageGallerys.length);
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
                      NewRecipeText.labelGalleryText,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            height: 1.37,
                            color: AppColor.primaryBlack,
                          ),
                    ),
                    Image.asset("assets/images/icons/edit_icon.png")
                  ],
                ),
                SizedBox(height: 10.h),
                if (errorText.isNotEmpty)
                  (Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errorText,
                        style: TextStyle(color: AppColor.red),
                      ))),
                SizedBox(height: 10.h),
                Container(
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    padding: EdgeInsets.only(top: 0, bottom: 5.h),
                    crossAxisCount: isTablet ? 7 : 3,
                    itemCount: imageGallerys.length,
                    itemBuilder: (context, index) {
                      if (index == (imageLimit - 1) && imageOverbalance > 0) {
                        return Stack(
                          children: [
                            Opacity(
                              opacity: 0.5,
                              child: Image.file(
                                File(imageGallerys[index].path),
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                            Center(
                              child: Text(
                                "+$imageOverbalance",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          ],
                        );
                      } else {
                        return Image.file(File(imageGallerys[index].path),
                            fit: BoxFit.cover);
                      }
                    },
                    staggeredTileBuilder: (index) => isTablet
                        ? StaggeredTile.count(
                            (index % 8 == 0) ? 4 : 1, (index % 8 == 0) ? 2 : 1)
                        : StaggeredTile.count((index % 4 == 0) ? 3 : 1,
                            (index % 4 == 0) ? 1.5 : 1),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: ((builder) => BottomSheetPickImage(
                            typeImage: ImageType.imageForGallery,
                          )),
                    );
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
                          child: Text(NewRecipeText.hintGalleryText,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: AppColor.primaryBlack
                                          .withOpacity(0.5),
                                      fontSize: 17)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        listener: (context, state) {
          switch (state.runtimeType) {
            case NewRecipeAddImageGallerySuccess:
              state as NewRecipeAddImageGallerySuccess;
              setState(() {
                imageGallerys.addAll(state.listFile);
              });
              break;
            case NewRecipeValidateSuccess:
              errorText = '';
              break;
            case NewRecipeValidateFailure:
              state as NewRecipeValidateFailure;
              errorText = state.galleryErrorMessage;
              break;
          }
        });
  }
}
