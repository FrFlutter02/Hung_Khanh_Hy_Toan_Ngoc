import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_event.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_state.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBox extends StatefulWidget {
  final List<String> recipesByName;

  SearchBox({required this.recipesByName, Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final double iconSize = 24.w;

  Timer? _searchTimer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColor.secondaryGrey.withOpacity(0.2),
              blurRadius: 12,
              spreadRadius: 8,
              offset: Offset(0, 0),
            ),
          ]),
      child: Column(
        children: [
          Container(
            width: Device.screenWidth,
            height: 46.h,
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/icons/search_icon.png',
                  width: iconSize,
                  height: iconSize,
                  color: AppColor.primaryBlack,
                ),
                Expanded(
                  child: BlocListener<SearchBloc, SearchState>(
                    listener: (context, state) {},
                    child: TextField(
                      onChanged: (text) {
                        const duration = Duration(milliseconds: 500);
                        final VoidCallback handleChange = () {
                          context.read<SearchBloc>().add(
                              SearchRecipeTextFieldChanged(
                                  recipeTextFieldValue: text));
                        };
                        if (_searchTimer != null) {
                          setState(() => _searchTimer!.cancel());
                        }
                        setState(
                            () => _searchTimer = Timer(duration, handleChange));
                      },
                      style: TextStyle(color: AppColor.primaryBlack),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 9.w, vertical: 12.h),
                        hintText: 'Sweets',
                        hintStyle: TextStyle(
                          color: AppColor.secondaryGrey,
                        ),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Image.asset(
                    'assets/images/icons/filter_icon.png',
                    width: iconSize,
                    height: iconSize,
                    color: AppColor.primaryBlack,
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1.h,
            color: AppColor.secondaryGrey,
          ),
          Container(
              width: 1.sw,
              padding: widget.recipesByName.isNotEmpty ||
                      context.read<SearchBloc>().state
                          is SearchFindRecipeInProgress
                  ? EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h)
                  : null,
              child:
                  context.read<SearchBloc>().state is SearchFindRecipeInProgress
                      ? Center(
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: CircularProgressIndicator(
                              color: AppColor.green,
                            ),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...widget.recipesByName.map((recipeName) => Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: InkWell(
                                    onTap: () => null,
                                    child: Text(
                                      recipeName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                            color: AppColor.primaryBlack,
                                          ),
                                    ),
                                  ),
                                ))
                          ],
                        )),
        ],
      ),
    );
  }
}
