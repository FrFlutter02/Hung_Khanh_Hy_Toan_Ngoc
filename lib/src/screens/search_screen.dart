import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_bloc.dart';
import 'package:mobile_app/src/blocs/search_bloc/search_state.dart';
import 'package:mobile_app/src/constants/constant_colors.dart';
import 'package:mobile_app/src/widgets/search/search_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  EdgeInsets distanceFromSearchBorderTopToNextSection =
      EdgeInsets.only(top: 36.h);

  bool isTablet = Device.get().isTablet;

  @override
  void initState() {
    if (isTablet) {
      distanceFromSearchBorderTopToNextSection = EdgeInsets.only(top: 80.h);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Stack(children: [
              ListView(
                padding: distanceFromSearchBorderTopToNextSection,
                children: [
                  Divider(
                    height: 0.6.h,
                    color: AppColor.secondaryGrey,
                  ),
                ],
              ),
              SearchBox(
                recipesByName:
                    state is SearchFindRecipeSuccess ? state.recipes : [],
              ),
            ]);
          },
        ),
      ),
    );
  }
}
