import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_event.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_state.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';

class SearchBox extends StatefulWidget {
  final List<String> recipesByName;

  SearchBox({required this.recipesByName, Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final double circularProgressIndicatorSize = 20.w;
  final double iconSize = 24.w;

  bool isTablet = Device.get().isTablet;

  EdgeInsets searchContainerPadding = EdgeInsets.zero;
  EdgeInsets searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);
  double searchContainerBoxShadowOpacity = 0.2;
  double searchContainerWidth = 1.sw;

  double dropdownWidth = 1.sw;
  EdgeInsets dropdownPadding = EdgeInsets.zero;
  EdgeInsets dropdownMargin = EdgeInsets.zero;

  Timer? _searchTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 1.sw,
          padding: searchContainerPadding,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(8), boxShadow: [
            BoxShadow(
              color: AppColor.secondaryGrey
                  .withOpacity(searchContainerBoxShadowOpacity),
              blurRadius: 12,
              spreadRadius: 8,
              offset: Offset(0, 0),
            ),
          ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColor.secondaryGrey))),
              width: (isTablet ? 0.7109 : 1).sw,
              padding: isTablet
                  ? EdgeInsets.only(bottom: 7.h)
                  : EdgeInsets.symmetric(horizontal: 11.w, vertical: 0),
              child: Row(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/icons/search_icon.png',
                      width: iconSize,
                      height: iconSize,
                      color: AppColor.iconText,
                    ),
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
                          setState(() =>
                              _searchTimer = Timer(duration, handleChange));
                        },
                        style: TextStyle(color: AppColor.primaryBlack),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: searchTextFieldContentPadding,
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
                      color: AppColor.iconText,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
        Container(
            decoration: isTablet &&
                    (widget.recipesByName.isNotEmpty ||
                        context.read<SearchBloc>().state
                            is SearchFindRecipeInProgress)
                ? BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColor.secondaryGrey))
                : null,
            width: dropdownWidth,
            padding: widget.recipesByName.isNotEmpty ||
                    context.read<SearchBloc>().state
                        is SearchFindRecipeInProgress
                ? dropdownPadding
                : null,
            margin: widget.recipesByName.isNotEmpty ||
                    context.read<SearchBloc>().state
                        is SearchFindRecipeInProgress
                ? dropdownMargin
                : null,
            child:
                context.read<SearchBloc>().state is SearchFindRecipeInProgress
                    ? Center(
                        child: SizedBox(
                          width: circularProgressIndicatorSize,
                          height: circularProgressIndicatorSize,
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
                      ))
      ],
    );
  }

  @override
  void initState() {
    if (isTablet) {
      searchContainerPadding = EdgeInsets.fromLTRB(25.w, 29.h, 25.w, 0);
      searchContainerBoxShadowOpacity = 0;
      searchContainerWidth = 0.7109.sw;
      searchTextFieldContentPadding = EdgeInsets.only(left: 5.w, right: 25.w);

      dropdownWidth = 0.7109.sw - 25.w;
      dropdownPadding = EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h);
      dropdownMargin = EdgeInsets.symmetric(horizontal: 25.w);
    }
    super.initState();
  }
}
