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
  EdgeInsets _screenHeaderPadding = EdgeInsets.fromLTRB(25.w, 11.h, 25.w, 24.h);
  Widget _tabletDivider = SizedBox.shrink();
  Widget _customNotificationWidget = SizedBox.shrink();

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
                  padding: _screenHeaderPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: SearchBar()),
                      SizedBox(
                        width: 38.w,
                      ),
                      _customNotificationWidget
                    ],
                  ),
                ),
                _tabletDivider,
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
      _screenHeaderPadding = EdgeInsets.fromLTRB(25.w, 29.h, 25.w, 19.h);
      _tabletDivider = Divider(
        height: 0.6.h,
        color: AppColor.secondaryGrey,
      );
      _customNotificationWidget = CustomNotification();
    }
    super.initState();
  }
}
