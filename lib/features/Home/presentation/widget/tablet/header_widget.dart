import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';

class HeaderWidget extends StatelessWidget {
  final FetchHomeDataState dataState;

  const HeaderWidget({super.key, required this.dataState});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor.white, boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(2, 0),
          blurRadius: 3.0,
        ),
      ]),
      height: MediaQuery.of(context).size.height * 0.13,
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [

          ],
        ),
      ),
    );
  }
}
