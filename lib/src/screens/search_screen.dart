import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.w, 11.h, 25.w, 0),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              return ListView(
                children: [
                  SearchBox(
                    recipesByName:
                        state is SearchFindRecipeSuccess ? state.recipes : [],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
