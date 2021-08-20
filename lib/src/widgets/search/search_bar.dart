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
  final double _circularProgressIndicatorSize = 20.w;
  final double _iconSize = 24.w;
  final FocusNode _searchFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  bool _searchHasFocus = false;
  double _searchContainerBoxShadowOpacity = 0.2;
  EdgeInsets _searchTextFieldContainerPadding = EdgeInsets.all(11.w);
  EdgeInsets _searchTextFieldContentPadding =
      EdgeInsets.symmetric(horizontal: 9.w);
  EdgeInsets _dropdownPadding =
      EdgeInsets.symmetric(horizontal: 44.w, vertical: 12.h);
  String _searchHintText = SearchScreenText.searchHintText;
  Widget _searchBottomBorder = SizedBox.shrink();

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
          padding: _searchTextFieldContainerPadding,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            border: _getSearchTextFieldBorder(),
            boxShadow: [
              BoxShadow(
                color: AppColor.secondaryGrey
                    .withOpacity(_searchContainerBoxShadowOpacity),
                blurRadius: 12,
                spreadRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: CompositedTransformTarget(
            link: _layerLink,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/icons/search_icon.png',
                  width: _iconSize,
                  height: _iconSize,
                  color: AppColor.iconText,
                ),
                Expanded(
                  child: BlocListener<SearchBloc, SearchState>(
                    listener: (context, _) {},
                    child: TextField(
                      controller: _searchTextEditingController,
                      focusNode: _searchFocusNode,
                      onChanged: (text) => textFieldOnChangedCallback(text),
                      style: TextStyle(color: AppColor.primaryBlack),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: _searchTextFieldContentPadding,
                        hintText: _searchHintText,
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
                    width: _iconSize,
                    height: _iconSize,
                    color: AppColor.iconText,
                  ),
                ),
              ],
            ),
          ),
        ),
        _searchBottomBorder,
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
    _setTabletVariables();
    _listenToSearchBlocStream();
    _listenToSearchFocusNode();
    super.initState();
  }

  void _setTabletVariables() {
    if (Device.get().isTablet) {
      _searchContainerBoxShadowOpacity = 0;
      _searchTextFieldContainerPadding = EdgeInsets.only(bottom: 7.h);
      _searchTextFieldContentPadding = EdgeInsets.symmetric(horizontal: 5.w);
      _dropdownPadding = EdgeInsets.fromLTRB(29.w, 12.h, 29.w, 12.h);
      _searchHintText = SearchScreenText.searchHintTextTablet;
      _searchBottomBorder = Divider(
        height: 1.h,
        color: AppColor.secondaryGrey,
      );
    }
  }

  void _listenToSearchBlocStream() {
    _searchStreamSubscription =
        context.read<SearchBloc>().stream.listen((searchState) {
      if (searchState is SearchRecipeInProgress) {
        _openDropdown(context);
      }
      if (searchState is SearchTextFieldChangeSuccess &&
          searchState.recipeTextFieldValue.isEmpty) {
        _closeDropdown();
      }
      if (searchState is SearchRecipeSuccess) {
        _recipesByName = searchState.recipes;
      }
      if (searchState is SearchAutofillSuccess) {
        _closeDropdown();
        _searchTextEditingController.text = searchState.autofillValue;
        _searchTextEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _searchTextEditingController.text.length));
      }
      Overlay.of(context)!.setState(() {});
    });
  }

  void _listenToSearchFocusNode() {
    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus) {
        setState(() => _searchHasFocus = true);
      }
      if (!_searchFocusNode.hasFocus) {
        setState(() => _searchHasFocus = false);
        _closeDropdown();
      } else if (_recipesByName.isNotEmpty &&
          context.read<SearchBloc>().state.runtimeType != SearchInitial) {
        _openDropdown(context);
      }
      Overlay.of(context)!.setState(() {});
    });
  }

  void textFieldOnChangedCallback(String text) {
    const _duration = Duration(milliseconds: 500);
    final _searchBloc = context.read<SearchBloc>();
    final VoidCallback handleChange = () {
      _searchBloc.add(SearchTextFieldChanged(recipeTextFieldValue: text));
    };
    if (_searchBloc.state is SearchAutofillSuccess) {
      return;
    }
    if (_searchTimer != null) {
      _searchTimer!.cancel();
    }
    setState(() => _searchTimer = Timer(_duration, handleChange));
  }

  void _openDropdown(BuildContext context) async {
    if (_dropdownOverlayEntry == null) {
      RenderBox renderBox = (context.findRenderObject() as RenderBox);
      final size = renderBox.size;
      _dropdownOverlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Positioned(
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, size.height - 4.h),
                child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        border: Border.all(
                          color: AppColor.secondaryGrey,
                        )),
                    padding: _dropdownPadding,
                    child: _getDropdownWidget()),
              ),
            ));
      });
      Overlay.of(context)?.insert(_dropdownOverlayEntry!);
    }
  }

  void _closeDropdown() {
    if (_dropdownOverlayEntry != null) {
      _dropdownOverlayEntry!.remove();
      _dropdownOverlayEntry = null;
      if (_searchTextEditingController.text.isEmpty) {
        _recipesByName = [];
      }
    }
  }

  Border _getSearchTextFieldBorder() {
    return Border.all(
        color: (context.read<SearchBloc>().state is SearchRecipeInProgress ||
                    context.read<SearchBloc>().state is SearchRecipeSuccess ||
                    context.read<SearchBloc>().state is SearchRecipeFailure) &&
                _searchHasFocus &&
                _searchTextEditingController.text.isNotEmpty
            ? AppColor.secondaryGrey
            : AppColor.white);
  }

  Widget? _getDropdownWidget() {
    final searchState = context.read<SearchBloc>().state;
    if (searchState is SearchRecipeInProgress) {
      return Center(
        child: SizedBox(
          width: _circularProgressIndicatorSize,
          height: _circularProgressIndicatorSize,
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
          ..._recipesByName.map((recipe) => Padding(
                padding: EdgeInsets.only(bottom: 14.h),
                child: InkWell(
                  onTap: () {
                    context.read<SearchBloc>().add(SearchAutofilled(
                        autofillValue: recipe.name.toLowerCase()));
                  },
                  child: _getRichTextWithBoldKeyword(
                      keyword: _searchTextEditingController.text.toLowerCase(),
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
}
