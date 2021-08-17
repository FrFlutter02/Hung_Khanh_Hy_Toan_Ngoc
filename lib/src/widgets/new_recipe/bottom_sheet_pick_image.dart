import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/constants/constant_text.dart';

import '../../constants/constant_colors.dart';

class BottomSheetPickImage extends StatelessWidget {
  const BottomSheetPickImage(
      {Key? key, required this.photoCamera, required this.photoGallery})
      : super(key: key);
  final void Function() photoCamera;
  final void Function() photoGallery;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            NewRecipeText.chooseOption,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            InkWell(
                onTap: () {
                  photoCamera();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.camera,
                        color: AppColor.green,
                      ),
                    ),
                    Text(
                      NewRecipeText.camera,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )),
            InkWell(
                onTap: () {
                  photoGallery();
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.photo,
                        color: AppColor.green,
                      ),
                    ),
                    Text(
                      NewRecipeText.gallery,
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  ],
                )),
          ])
        ],
      ),
    );
  }
}
