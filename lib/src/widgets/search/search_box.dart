import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/search_bloc/search_bloc.dart';
import '../../blocs/search_bloc/search_event.dart';
import '../../blocs/search_bloc/search_state.dart';
import '../../constants/constant_colors.dart';
import '../../constants/constant_text.dart';
import '../../models/recipe_model.dart';
import '../../widgets/custom_notification.dart';

class SearchBox extends StatefulWidget {
  SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final double circularProgressIndicatorSize = 20.w;
  final double iconSize = 24.w;
  late FocusNode searchFocusNode;

  double searchContainerBoxShadowOpacity = 0.2;
  double searchAndNotificationSizedBoxWidth = 0;
  BorderSide searchContainerBottomBorder = BorderSide(width: 0);
  EdgeInsets searchBoxPadding = EdgeInsets.fromLTRB(25.w, 11.h, 25.w, 24.h);
  EdgeInsets searchTextFieldContainerPadding = EdgeInsets.all(11.w);
  EdgeInsets searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);
  EdgeInsets dropdownMargin = EdgeInsets.zero;
  EdgeInsets dropdownPadding =
      EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h);
  String searchHintText = SearchScreenText.searchHintText;
  Widget customNotificationWidget = SizedBox.shrink();

  List<RecipeModel> recipesByName = [];
  OverlayEntry? dropdownOverlayEntry;
  StreamSubscription? searchStreamSubscription;
  TextEditingController searchTextEditingController = TextEditingController();
  Timer? _searchTimer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: searchBoxPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 0.7109.sw,
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
                  padding: searchTextFieldContainerPadding,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: searchContainerBottomBorder,
                    ),
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
                            controller: searchTextEditingController,
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
                              setState(() =>
                                  _searchTimer = Timer(duration, handleChange));
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
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          customNotificationWidget
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (Device.get().isTablet) {
      searchContainerBoxShadowOpacity = 0;
      searchAndNotificationSizedBoxWidth = 38.w;
      searchContainerBottomBorder =
          BorderSide(width: 1.w, color: AppColor.secondaryGrey);
      searchBoxPadding = EdgeInsets.fromLTRB(25.w, 29.h, 25.w, 20);
      searchTextFieldContainerPadding = EdgeInsets.only(top: 7.h, bottom: 7.h);
      searchTextFieldContentPadding = EdgeInsets.only(left: 5.w, right: 25.w);
      dropdownMargin = EdgeInsets.only(left: 25.w);
      dropdownPadding = EdgeInsets.fromLTRB(29.w, 12.h, 29.w, 12.h);
      searchHintText = SearchScreenText.searchHintTextTablet;
      customNotificationWidget = CustomNotification();
    }

    searchStreamSubscription =
        context.read<SearchBloc>().stream.listen((searchState) {
      if (searchState is SearchRecipeTextFieldChangeSuccess &&
          searchTextEditingController.text.isEmpty) {
        _removeDropdownOverlay();
      }
      if (searchState is SearchFindRecipeInProgress) {
        _showDropdownOverlay(context);
      }
      if (searchState is SearchFindRecipeSuccess) {
        setState(() {
          recipesByName = searchState.recipes;
        });
      }
      Overlay.of(context)?.setState(() {});
    });

    searchFocusNode = FocusNode();
    searchFocusNode.addListener(() {
      if (!searchFocusNode.hasFocus) {
        _removeDropdownOverlay();
      } else if (recipesByName.isNotEmpty) {
        _showDropdownOverlay(context);
      }
    });

    super.initState();
  }

  Widget? _dropdownWidget() {
    final searchState = context.read<SearchBloc>().state;

    if (searchState is SearchFindRecipeInProgress) {
      return Center(
        child: SizedBox(
          width: circularProgressIndicatorSize,
          height: circularProgressIndicatorSize,
          child: CircularProgressIndicator(
            color: AppColor.green,
          ),
        ),
      );
    }

    if (searchState is SearchFindRecipeSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...recipesByName.toSet().take(7).map((recipe) => Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: InkWell(
                  onTap: () => null,
                  child: _getRichTextWithBoldKeyword(
                      keyword: searchTextEditingController.text.toLowerCase(),
                      searchResultText: recipe.name.toLowerCase()),
                ),
              )),
        ],
      );
    }

    if (searchState is SearchFindRecipeFailure) {
      return Text(
        searchState.failureMessage,
        style: TextStyle(color: AppColor.secondaryGrey),
      );
    }
  }

  Widget _getRichTextWithBoldKeyword(
      {String keyword = '', String searchResultText = ''}) {
    final int keywordStartIndex = searchResultText.indexOf(keyword);
    final int keywordEndIndex =
        keywordStartIndex != -1 ? keywordStartIndex + keyword.length - 1 : -1;
    final stringBeforeKeyword = keywordStartIndex != -1
        ? searchResultText.substring(0, keywordStartIndex)
        : '';
    final stringAfterKeyword = keywordEndIndex != -1
        ? searchResultText.substring(keywordEndIndex + 1)
        : '';

    return RichText(
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: AppColor.primaryBlack,
                ),
            children: [
              TextSpan(
                text: stringBeforeKeyword,
              ),
              stringBeforeKeyword.isEmpty && stringAfterKeyword.isEmpty
                  ? TextSpan(text: searchResultText)
                  : TextSpan(
                      text: keyword,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              TextSpan(
                text: stringAfterKeyword,
              )
            ]));
  }

  void _removeDropdownOverlay() {
    dropdownOverlayEntry!.remove();
  }

  void _showDropdownOverlay(BuildContext context) async {
    dropdownOverlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          top: 59.h,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      border: Border.all(
                        color: AppColor.secondaryGrey,
                      )),
                  width: 0.7109.sw,
                  padding: recipesByName.isNotEmpty ||
                          context.read<SearchBloc>().state
                              is SearchFindRecipeInProgress
                      ? dropdownPadding
                      : null,
                  margin: recipesByName.isNotEmpty ||
                          context.read<SearchBloc>().state
                              is SearchFindRecipeInProgress
                      ? dropdownMargin
                      : null,
                  child: _dropdownWidget()),
            ),
          ));
    });

    if (dropdownOverlayEntry != null) {
      Overlay.of(context)?.insert(dropdownOverlayEntry!);
    }
  }
}
