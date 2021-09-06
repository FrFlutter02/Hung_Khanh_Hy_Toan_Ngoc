import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../constants/constant_text.dart';
import '../../screens/new_recipe_screen.dart';
import '../../constants/constant_colors.dart';

class BottomSheetPickImage extends StatelessWidget {
  const BottomSheetPickImage({Key? key, required this.typeImage})
      : super(key: key);

  final ImageType typeImage;
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
                  if (typeImage == ImageType.imageMain) {
                    context
                        .read<NewRecipeBloc>()
                        .add(NewRecipeMainImagePicked(ImageSource.camera));
                  } else if (typeImage == ImageType.imageForGallery) {
                    context
                        .read<NewRecipeBloc>()
                        .add(NewRecipeGalleryImagePicked(ImageSource.camera));
                  } else {
                    context.read<NewRecipeBloc>().add(
                        NewRecipeIngredientImagePicked(ImageSource.camera));
                  }
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
                  if (typeImage == ImageType.imageMain) {
                    context
                        .read<NewRecipeBloc>()
                        .add(NewRecipeMainImagePicked(ImageSource.gallery));
                  } else if (typeImage == ImageType.imageForGallery) {
                    context
                        .read<NewRecipeBloc>()
                        .add(NewRecipeGalleryImagePicked(ImageSource.gallery));
                  } else {
                    context.read<NewRecipeBloc>().add(
                        NewRecipeIngredientImagePicked(ImageSource.gallery));
                  }
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
