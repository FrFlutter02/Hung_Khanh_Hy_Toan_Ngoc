import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/src/utils/image_picker.dart';

import '../../constants/constant_colors.dart';

class BottomSheetPickImage extends StatelessWidget {
  const BottomSheetPickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose option",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
                onTap: () {
                  // takePhoto(ImageSource.camera);
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
                      "Camera",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )),
            InkWell(
                onTap: () {
                  // takePhoto(ImageSource.gallery);
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
                      "Gallery",
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                )),
          ])
        ],
      ),
    );
  }
}
