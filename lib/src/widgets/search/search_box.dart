import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/recipe_model.dart';
import '../../widgets/custom_notification.dart';
import '../../blocs/search_bloc/search_bloc.dart';
import '../../blocs/search_bloc/search_event.dart';
import '../../blocs/search_bloc/search_state.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';

class SearchBox extends StatefulWidget {
  final List<RecipeModel> recipesByName;

  SearchBox({required this.recipesByName, Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  StreamSubscription? searchStreamSubscription;
  final double circularProgressIndicatorSize = 20.w;
  final double iconSize = 24.w;
  late FocusNode searchFocusNode;

  String searchHintText = SearchScreenText.searchHintText;

  bool isTablet = Device.get().isTablet;

  EdgeInsets searchOuterContainerPadding =
      EdgeInsets.fromLTRB(25.w, 4.h, 25.w, 100.h);

  EdgeInsets searchContainerPadding = EdgeInsets.all(11.w);
  double searchContainerBoxShadowOpacity = 0.2;
  Border? searchContainerBottomBorder;

  EdgeInsets searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);

  EdgeInsets dropdownPadding =
      EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h);
  EdgeInsets dropdownMargin = EdgeInsets.zero;

  Timer? _searchTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: searchOuterContainerPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.secondaryGrey
                        .withOpacity(searchContainerBoxShadowOpacity),
                    blurRadius: 12,
                    spreadRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: searchContainerPadding,
                    decoration: BoxDecoration(
                      border: searchContainerBottomBorder,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/icons/search_icon.png',
                          width: iconSize,
                          height: iconSize,
                          color: AppColor.iconText,
                        ),
                        Expanded(
                          child: BlocListener<SearchBloc, SearchState>(
                            listener: (context, _) {},
                            child: TextField(
                              focusNode: searchFocusNode,
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
                                setState(() => _searchTimer =
                                    Timer(duration, handleChange));
                              },
                              style: TextStyle(color: AppColor.primaryBlack),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: searchTextFieldContentPadding,
                                hintText: searchHintText,
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
                        ),
                      ],
                    ),
                  ),
                  widget.recipesByName.isEmpty
                      ? SizedBox.shrink()
                      : Divider(
                          color: AppColor.secondaryGrey,
                          height: 1.h,
                        ),
                  Container(
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
                      child: context.read<SearchBloc>().state
                              is SearchFindRecipeInProgress
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
                                ...widget.recipesByName
                                    .toSet()
                                    .take(7)
                                    .map((recipe) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.h),
                                          child: InkWell(
                                            onTap: () => null,
                                            child: Text(
                                              recipe.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2!
                                                  .copyWith(
                                                    color:
                                                        AppColor.primaryBlack,
                                                  ),
                                            ),
                                          ),
                                        )),
                              ],
                            ))
                ],
              ),
            ),
          ),
          SizedBox(
            width: 38.w,
          ),
          CustomNotification(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchStreamSubscription?.cancel();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (isTablet) {
      searchHintText = SearchScreenText.searchHintTextTablet;

      searchOuterContainerPadding = EdgeInsets.fromLTRB(25.w, 22.h, 25.w, 0);

      searchContainerPadding = EdgeInsets.only(top: 7.h, bottom: 7.h);
      searchContainerBoxShadowOpacity = 0;
      searchContainerBottomBorder =
          Border(bottom: BorderSide(color: AppColor.secondaryGrey));

      searchTextFieldContentPadding = EdgeInsets.only(left: 5.w, right: 25.w);

      dropdownPadding = EdgeInsets.zero;
      dropdownMargin = EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h);
    }
    super.initState();
  }
}
