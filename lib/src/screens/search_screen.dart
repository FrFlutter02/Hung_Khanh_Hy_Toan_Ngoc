import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_app/src/widgets/custom_notification.dart';

import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_state.dart';
import '../constants/constant_colors.dart';
import '../widgets/search/search_box.dart';

class Searchscreen extends StatefulWidget {
  const Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  double searchAndRecipesDividerHeight = 0;
  EdgeInsets searchBoxPadding = EdgeInsets.fromLTRB(25.w, 11.h, 25.w, 24.h);
  Widget customNotificationWidget = SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding: searchBoxPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SearchBox(),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      customNotificationWidget
                    ],
                  ),
                ),
                Divider(
                  height: searchAndRecipesDividerHeight,
                  color: AppColor.secondaryGrey,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    if (Device.get().isTablet) {
      searchAndRecipesDividerHeight = 0.6.h;
      searchBoxPadding = EdgeInsets.fromLTRB(25.w, 29.h, 25.w, 19.h);
      customNotificationWidget = CustomNotification();
    }
    super.initState();
  }
}
