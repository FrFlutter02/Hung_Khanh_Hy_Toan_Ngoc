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

class SearchBar extends StatefulWidget {
  SearchBar({Key? key}) : super(key: key);
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final double circularProgressIndicatorSize = 20.w;
  final double iconSize = 24.w;
  final FocusNode searchFocusNode = FocusNode();
  bool searchHasFocus = false;
  double searchContainerBoxShadowOpacity = 0.2;
  double searchContainerWidth = 1.sw;
  double searchAndNotificationSizedBoxWidth = 0;
  BorderSide searchContainerTopLeftRightBorder = BorderSide(width: 0);
  BorderSide searchContainerBottomBorder = BorderSide(width: 0);
  EdgeInsets searchTextFieldContainerPadding = EdgeInsets.all(11.w);
  EdgeInsets searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);
  EdgeInsets dropdownMargin = EdgeInsets.symmetric(horizontal: 25.w);
  EdgeInsets dropdownPadding =
      EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h);
  SizedBox searchBottomBorder = SizedBox.shrink();
  String searchHintText = SearchScreenText.searchHintText;

  List<RecipeModel> _recipesByName = [];
  OverlayEntry? _dropdownOverlayEntry;
  StreamSubscription? _searchStreamSubscription;
  TextEditingController _searchTextEditingController = TextEditingController();
  Timer? _searchTimer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: searchContainerWidth,
          padding: searchTextFieldContainerPadding,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(8),
            border: _searchTextFieldBorder(),
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
                    controller: _searchTextEditingController,
                    focusNode: searchFocusNode,
                    onChanged: (text) {
                      const duration = Duration(milliseconds: 500);
                      final VoidCallback handleChange = () {
                        context.read<SearchBloc>().add(
                            SearchTextFieldChanged(recipeTextFieldValue: text));
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
        searchBottomBorder,
      ],
    );
  }

  @override
  void dispose() {
    _searchStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (Device.get().isTablet) {
      searchContainerBoxShadowOpacity = 0;
      searchAndNotificationSizedBoxWidth = 38.w;
      searchContainerWidth = 0.7109.sw;
      searchContainerBottomBorder =
          BorderSide(width: 1.w, color: AppColor.secondaryGrey);
      searchTextFieldContainerPadding = EdgeInsets.only(bottom: 7.h);
      searchTextFieldContentPadding = EdgeInsets.symmetric(horizontal: 5.w);
      dropdownMargin = EdgeInsets.only(left: 25.w);
      dropdownPadding = EdgeInsets.fromLTRB(29.w, 12.h, 29.w, 12.h);
      searchBottomBorder = SizedBox(
        width: searchContainerWidth,
        child: Divider(
          height: 1.h,
          color: AppColor.secondaryGrey,
        ),
      );
      searchHintText = SearchScreenText.searchHintTextTablet;
    }

    _searchStreamSubscription =
        context.read<SearchBloc>().stream.listen((searchState) {
      if (searchState is SearchRecipeInProgress) {
        _showDropdownOverlay(context);
      }
      if (searchState is SearchTextFieldChangeSuccess &&
          searchState.recipeTextFieldValue.isEmpty) {
        _removeDropdownOverlay();
      }
      if (searchState is SearchRecipeSuccess) {
        _recipesByName = searchState.recipes;
      }
      Overlay.of(context)!.setState(() {});
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() => searchHasFocus = true);
      }
      if (!searchFocusNode.hasFocus) {
        setState(() => searchHasFocus = false);
        _removeDropdownOverlay();
      } else if (_recipesByName.isNotEmpty) {
        print(_recipesByName);
        _showDropdownOverlay(context);
      }
      Overlay.of(context)!.setState(() {});
    });

    super.initState();
  }

  Border _searchTextFieldBorder() {
    return Border.all(
        color: (context.read<SearchBloc>().state is SearchRecipeInProgress ||
                    context.read<SearchBloc>().state is SearchRecipeSuccess ||
                    context.read<SearchBloc>().state is SearchRecipeFailure) &&
                searchHasFocus &&
                _searchTextEditingController.text.isNotEmpty
            ? AppColor.secondaryGrey
            : AppColor.white);
  }

  Widget? _dropdownWidget() {
    final searchState = context.read<SearchBloc>().state;

    if (searchState is SearchRecipeInProgress) {
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

    if (searchState is SearchRecipeSuccess) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._recipesByName
              .where((recipe) => recipe.name
                  .toLowerCase()
                  .contains(_searchTextEditingController.text.toLowerCase()))
              .toSet()
              .take(7)
              .map((recipe) => Padding(
                    padding: EdgeInsets.only(bottom: 14.h),
                    child: InkWell(
                      onTap: () => null,
                      child: _getRichTextWithBoldKeyword(
                          keyword:
                              _searchTextEditingController.text.toLowerCase(),
                          searchResultText: recipe.name.toLowerCase()),
                    ),
                  )),
        ],
      );
    }

    if (searchState is SearchRecipeFailure) {
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
    if (_dropdownOverlayEntry != null) {
      _dropdownOverlayEntry!.remove();
      _dropdownOverlayEntry = null;
      if (_searchTextEditingController.text.isEmpty) {
        _recipesByName = [];
      }
    }
  }

  void _showDropdownOverlay(BuildContext context) async {
    if (_dropdownOverlayEntry == null) {
      _dropdownOverlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Positioned(
            top: 59.h,
            child: Material(
              color: Colors.transparent,
              child: SafeArea(
                child: SizedBox(
                  width: 1.sw,
                  child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          border: Border.all(
                            color: AppColor.secondaryGrey,
                          )),
                      width: searchContainerWidth,
                      margin: dropdownMargin,
                      padding: dropdownPadding,
                      child: _dropdownWidget()),
                ),
              ),
            ));
      });
      Overlay.of(context)?.insert(_dropdownOverlayEntry!);
    }
  }
}
