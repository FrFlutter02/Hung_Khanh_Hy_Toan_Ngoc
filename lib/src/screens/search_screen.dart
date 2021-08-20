import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../blocs/search_bloc/search_bloc.dart';
import '../blocs/search_bloc/search_state.dart';
import '../constants/constant_colors.dart';
import '../widgets/custom_notification.dart';
import '../widgets/search/search_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  EdgeInsets screenHeaderPadding = EdgeInsets.fromLTRB(25.w, 11.h, 25.w, 24.h);
  SizedBox tabletDivider = SizedBox.shrink();
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
                  padding: screenHeaderPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: SearchBar()),
                      customNotificationWidget
                    ],
                  ),
                ),
                tabletDivider
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
      screenHeaderPadding = EdgeInsets.fromLTRB(25.w, 29.h, 25.w, 19.h);
      tabletDivider = SizedBox(
        child: Divider(
          height: 0.6.h,
          color: AppColor.secondaryGrey,
        ),
      );
      customNotificationWidget = CustomNotification();
    }
    super.initState();
  }
}
