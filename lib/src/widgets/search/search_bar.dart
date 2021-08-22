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
  SearchBarState createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  final double circularProgressIndicatorSize = 20.w;
  final double iconSize = 24.w;
  final FocusNode searchFocusNode = FocusNode();
  final LayerLink layerLink = LayerLink();
  bool searchHasFocus = false;
  double searchContainerBoxShadowOpacity = 0.2;
  EdgeInsets searchTextFieldContainerPadding = EdgeInsets.all(11.w);
  EdgeInsets searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);
  EdgeInsets dropdownPadding =
      EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h);
  String searchHintText = SearchScreenText.searchHintText;
  Widget searchBottomBorder = SizedBox.shrink();

  List<RecipeModel> recipesByName = [];
  OverlayEntry? dropdownOverlayEntry;
  StreamSubscription? searchStreamSubscription;
  TextEditingController searchTextEditingController = TextEditingController();
  Timer? searchTimer;

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        children: [
          Container(
            padding: searchTextFieldContainerPadding,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: getSearchTextFieldBorderRadius(),
              border: getSearchTextFieldBorder(),
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
                  child: TextField(
                    controller: searchTextEditingController,
                    focusNode: searchFocusNode,
                    onChanged: (text) => textFieldOnChangedCallback(text),
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
      searchTextFieldContainerPadding = EdgeInsets.only(bottom: 7.h);
      searchTextFieldContentPadding = EdgeInsets.symmetric(horizontal: 5.w);
      dropdownPadding = EdgeInsets.fromLTRB(29.w, 12.h, 29.w, 12.h);
      searchHintText = SearchScreenText.searchHintTextTablet;
      searchBottomBorder = Divider(
        height: 1.h,
        color: AppColor.secondaryGrey,
      );
    }

    searchStreamSubscription =
        context.read<SearchBloc>().stream.listen((searchState) {
      if (searchState is SearchRecipeInProgress) {
        openDropdown(context);
      }
      if (searchState is SearchTextFieldChangeSuccess &&
          searchState.recipeTextFieldValue.isEmpty) {
        closeDropdown();
      }
      if (searchState is SearchRecipeSuccess) {
        recipesByName = searchState.recipes;
      }
      if (searchState is SearchAutofillSuccess) {
        closeDropdown();
        searchTextEditingController.text = searchState.autofillValue;
        searchTextEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: searchTextEditingController.text.length));
      }
      Overlay.of(context)!.setState(() {});
    });

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() => searchHasFocus = true);
      }
      if (!searchFocusNode.hasFocus) {
        setState(() => searchHasFocus = false);
        closeDropdown();
      } else if (recipesByName.isNotEmpty &&
          context.read<SearchBloc>().state.runtimeType != SearchInitial) {
        openDropdown(context);
      }
      Overlay.of(context)!.setState(() {});
    });

    super.initState();
  }

  void textFieldOnChangedCallback(String text) {
    const _duration = Duration(milliseconds: 500);
    final _searchBloc = context.read<SearchBloc>();
    final VoidCallback handleChange = () {
      _searchBloc.add(SearchTextFieldChanged(recipeTextFieldValue: text));
    };
    if (_searchBloc.state is SearchAutofillSuccess) return;
    if (searchTimer != null) {
      searchTimer!.cancel();
    }
    setState(() => searchTimer = Timer(_duration, handleChange));
  }

  void openDropdown(BuildContext context) async {
    if (dropdownOverlayEntry != null) return;

    final RenderBox _renderBox = (context.findRenderObject() as RenderBox);
    final size = _renderBox.size;

    dropdownOverlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height - 1.h),
            child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.secondaryGrey,
                    )),
                child: Material(
                    color: Colors.transparent, child: getDropdownWidget())),
          ));
    });
    Overlay.of(context)?.insert(dropdownOverlayEntry!);
  }

  void closeDropdown() {
    if (dropdownOverlayEntry != null) {
      dropdownOverlayEntry!.remove();
      dropdownOverlayEntry = null;
      if (searchTextEditingController.text.isEmpty) {
        recipesByName = [];
      }
    }
  }

  Border getSearchTextFieldBorder() {
    return Border.all(
      color: dropdownOverlayEntry != null
          ? AppColor.secondaryGrey
          : AppColor.white,
    );
  }

  BorderRadius getSearchTextFieldBorderRadius() {
    return dropdownOverlayEntry != null
        ? BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          )
        : BorderRadius.circular(8);
  }

  Widget? getDropdownWidget() {
    final searchState = context.read<SearchBloc>().state;
    if (searchState is SearchRecipeInProgress) {
      return Padding(
        padding: dropdownPadding,
        child: Center(
          child: SizedBox(
            width: circularProgressIndicatorSize,
            height: circularProgressIndicatorSize,
            child: CircularProgressIndicator(
              color: AppColor.green,
            ),
          ),
        ),
      );
    }
    if (searchState is SearchRecipeSuccess) {
      final _list = getFormattedResult(
          keyword: searchTextEditingController.text.toLowerCase(),
          recipes: recipesByName);
      return Column(
        children: [
          ..._list.map((recipe) {
            return InkWell(
              onTap: () {
                context.read<SearchBloc>().add(SearchAutofilled(
                    autofillValue:
                        searchTextEditingController.text.toLowerCase()));
              },
              child: SizedBox(
                width: 1.sw,
                child: Padding(
                  padding: dropdownPadding,
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    color: AppColor.primaryBlack,
                                  ),
                          children: [
                            TextSpan(
                              text: recipe['beforeKeyword'],
                            ),
                            recipe['beforeKeyword']!.isEmpty &&
                                    recipe['afterKeyword']!.isEmpty
                                ? TextSpan(text: recipe['result'])
                                : TextSpan(
                                    text: searchTextEditingController.text,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                            TextSpan(
                              text: recipe['afterKeyword'],
                            )
                          ])),
                ),
              ),
            );
          }),
        ],
      );
    }
    if (searchState is SearchRecipeFailure) {
      return Padding(
        padding: dropdownPadding,
        child: Text(
          searchState.failureMessage,
          style: TextStyle(color: AppColor.secondaryGrey),
        ),
      );
    }
  }

  List<Map<String, String>> getFormattedResult(
      {String keyword = '', required List<RecipeModel> recipes}) {
    return List<Map<String, String>>.from(recipes.map((element) {
      final int keywordStartIndex = element.name.indexOf(keyword);
      final int keywordEndIndex =
          keywordStartIndex != -1 ? keywordStartIndex + keyword.length - 1 : -1;
      final stringBeforeKeyword = keywordStartIndex != -1
          ? element.name.substring(0, keywordStartIndex)
          : '';
      final stringAfterKeyword = keywordEndIndex != -1
          ? element.name.substring(keywordEndIndex + 1)
          : '';

      return {
        'beforeKeyword': stringBeforeKeyword,
        'result': element.name,
        'afterKeyword': stringAfterKeyword,
      };
    }));
  }
}
