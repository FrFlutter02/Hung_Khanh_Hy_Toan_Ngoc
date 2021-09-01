import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/new_recipe_bloc/new_recipe_bloc.dart';
import '../../blocs/new_recipe_bloc/new_recipe_event.dart';
import '../../blocs/new_recipe_bloc/new_recipe_state.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../models/category.dart';

class ItemNewCategory extends StatefulWidget {
  ItemNewCategory({Key? key}) : super(key: key);

  @override
  ItemNewCategoryState createState() => ItemNewCategoryState();
}

class ItemNewCategoryState extends State<ItemNewCategory> {
  final categoryController = TextEditingController();
  String dropdownValue = '';
  List<CategoryModel> categories = [];
  bool addCategory = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewRecipeBloc, NewRecipeState>(
      child: Container(
        width: 190.w,
        height: 50.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
        child: addCategory
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      key: Key('addCategoryIcon'),
                      onTap: () {
                        setState(() {
                          if (categoryController.text.isEmpty) return;
                          categories.insert(
                              categories.length - 1,
                              CategoryModel(
                                  categoryName: categoryController.text,
                                  totalRecipes: 0));
                          context.read<NewRecipeBloc>().add(
                              NewRecipeAddCategorySubmitted(
                                  categoryController.text));
                          categoryController.text = "";
                          addCategory = false;
                        });
                      },
                      child: Icon(Icons.add_outlined)),
                  SizedBox(
                      width: 120,
                      height: 30,
                      child: TextField(
                        controller: categoryController,
                        cursorColor: AppColor.green,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColor.green,
                              width: 2,
                            ),
                          ),
                        ),
                      )),
                ],
              )
            : DropdownButton<String>(
                key: Key('categoryDropdown'),
                value: dropdownValue,
                icon: Icon(Icons.expand_more_outlined),
                iconSize: 23,
                isExpanded: true,
                style: const TextStyle(color: AppColor.primaryBlack),
                underline: SizedBox(),
                onChanged: (String? newValue) {
                  context
                      .read<NewRecipeBloc>()
                      .add(NewRecipeAddCategorySubmitted(newValue!));
                },
                items: categories
                    .map<DropdownMenuItem<String>>((CategoryModel element) {
                  return DropdownMenuItem<String>(
                    value: element.categoryName,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (element.categoryName == '')
                          InkWell(
                            key: Key('addCategoryText'),
                            onTap: () {
                              setState(() {
                                addCategory = true;
                              });
                            },
                            child: ((Text(
                              NewRecipeText.AddNewCategoryText,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColor.green),
                            ))),
                          )
                        else
                          (Text(
                              "${element.categoryName} (${element.totalRecipes})"))
                      ],
                    ),
                  );
                }).toList(),
              ),
      ),
      listener: (context, state) {
        switch (state.runtimeType) {
          case NewRecipeAddCategorySuccess:
            state as NewRecipeAddCategorySuccess;
            setState(() {
              dropdownValue = state.newCategory;
            });
            break;
          default:
        }
        if (state is NewRecipeCategoriesLoadSuccess) {
          setState(() {
            categories = state.categories;
            dropdownValue = categories[0].categoryName;
          });
        }
      },
    );
  }
}
