import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../constants/constant_text.dart';
import '../../constants/constant_colors.dart';

class ItemNewGallery extends StatelessWidget {
  const ItemNewGallery({
    Key? key,
    required this.dataImage,
    required this.addImageGallery,
    required this.imageOverbalance,
  }) : super(key: key);
  final List<File> dataImage;
  final int imageOverbalance;
  final void Function() addImageGallery;
  @override
  Widget build(BuildContext context) {
    List<File> listImage = [];
    listImage.addAll(dataImage);
    if (listImage.length > 4) {
      listImage.removeRange(4, listImage.length);
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
                  NewRecipeText.labelGalleryText,
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
              // height: galleryHeight,
              child: StaggeredGridView.countBuilder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(top: 0, bottom: 5.h),
                crossAxisCount: 3,
                itemCount: listImage.length,
                itemBuilder: (context, index) {
                  if (index == 3 && imageOverbalance > 0) {
                    return Stack(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: Image.file(
                            File(listImage[index].path),
                            fit: BoxFit.cover,
                            height: double.infinity,
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
                    return Image.file(File(listImage[index].path),
                        fit: BoxFit.cover);
                  }
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(
                    (index % 4 == 0) ? 3 : 1, (index % 4 == 0) ? 1.5 : 1),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            ),
            InkWell(
              onTap: addImageGallery,
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
                                  color: AppColor.primaryBlack.withOpacity(0.5),
                                  fontSize: 17)),
                    ),
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
