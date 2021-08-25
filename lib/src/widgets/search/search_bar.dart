import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/keyword_search_bloc/keyword_search_bloc.dart';
import '../../blocs/keyword_search_bloc/keyword_search_event.dart';
import '../../blocs/keyword_search_bloc/keyword_search_state.dart';
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
  final Radius searchTextFieldAndDropdownRadius = Radius.circular(8);
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
              borderRadius: dropdownOverlayEntry != null
                  ? BorderRadius.only(
                      topLeft: searchTextFieldAndDropdownRadius,
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(8),
              border: Border.all(
                color: dropdownOverlayEntry != null
                    ? AppColor.secondaryGrey
                    : AppColor.white,
              ),
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
                    onChanged: (text) => _textFieldOnChangedCallback(text),
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
        context.read<KeywordSearchBloc>().stream.listen((searchState) {
      if (searchState is KeywordSearchRecipeInProgress) {
        openDropdown(context);
      }
      if (searchState is SearchTextFieldChangeSuccess &&
          searchState.recipeTextFieldValue.isEmpty) {
        closeDropdown();
      }
      if (searchState is KeywordSearchRecipeSuccess) {
        recipesByName = searchState.recipes;
      }
      if (searchState is KeywordSearchAutofillSuccess) {
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
          context.read<KeywordSearchBloc>().state.runtimeType !=
              KeywordSearchInitial) {
        openDropdown(context);
      }
      Overlay.of(context)!.setState(() {});
    });

    super.initState();
  }

  Widget? getDropdownWidget() {
    final searchState = context.read<KeywordSearchBloc>().state;
    if (searchState is KeywordSearchRecipeInProgress) {
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
    if (searchState is KeywordSearchRecipeSuccess) {
      print('hehehe');
      return Column(
        children: [
          ...recipesByName.map((recipe) {
            return InkWell(
              onTap: () {
                context
                    .read<KeywordSearchBloc>()
                    .add(KeywordSearchAutofilled(autofillValue: recipe.name));
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
                          children: getFormattedResult(
                              keyword: searchTextEditingController.text,
                              result: recipe.name))),
                ),
              ),
            );
          }),
        ],
      );
    }
    if (searchState is KeywordSearchRecipeFailure) {
      return Padding(
        padding: dropdownPadding,
        child: Text(
          searchState.failureMessage,
          style: TextStyle(color: AppColor.secondaryGrey),
        ),
      );
    }
  }

  List<TextSpan> getFormattedResult(
      {required String keyword, required String result}) {
    String _resultToLowerCase = result.toLowerCase();
    List<TextSpan> _textSpanList = [];

    while (_resultToLowerCase.isNotEmpty) {
      int _indexOfKeyword = _resultToLowerCase.indexOf(keyword);
      _textSpanList.add(
        TextSpan(
          text: _resultToLowerCase.substring(0, keyword.length),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
      _indexOfKeyword = _resultToLowerCase.indexOf(keyword, keyword.length);
      _textSpanList.add(
        TextSpan(
          text: _resultToLowerCase.substring(
              keyword.length,
              _indexOfKeyword == -1
                  ? _resultToLowerCase.length
                  : _indexOfKeyword),
        ),
      );
      _resultToLowerCase = _resultToLowerCase.substring(
          _indexOfKeyword == -1 ? _resultToLowerCase.length : _indexOfKeyword);
    }
    return _textSpanList;
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
            offset: Offset(0, size.height),
            child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    border: Border.all(
                      color: AppColor.secondaryGrey,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: searchTextFieldAndDropdownRadius,
                      bottomRight: searchTextFieldAndDropdownRadius,
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

  void _textFieldOnChangedCallback(String text) {
    const _duration = Duration(milliseconds: 500);
    final _searchBloc = context.read<KeywordSearchBloc>();
    final VoidCallback searchRequest = () {
      _searchBloc.add(KeywordSearchRecipeRequested(searchQuery: text));
    };
    _searchBloc.add(KeywordSearchTextFieldChanged(recipeTextFieldValue: text));
    if (_searchBloc.state is KeywordSearchAutofillSuccess) return;
    if (searchTimer != null) {
      searchTimer!.cancel();
    }
    if (text.isNotEmpty) {
      setState(() => searchTimer = Timer(_duration, searchRequest));
    }
  }
}
