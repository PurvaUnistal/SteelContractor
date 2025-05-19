import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';
import 'package:steel_contractor/features/Home/presentation/widget/tablet/header_widget.dart';
import 'package:steel_contractor/features/Home/presentation/widget/tablet/table_drawer_widget.dart';

class TabletHomeWidget extends StatefulWidget {
  const TabletHomeWidget({super.key});

  @override
  State<TabletHomeWidget> createState() => _TabletHomeWidgetState();
}

class _TabletHomeWidgetState extends State<TabletHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is FetchHomeDataState) {
            return Row(
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 3.5,
                    child: TabletDrawerWidget(dataState: state)),
                Expanded(
                  flex: 1,
                  child: Column(children: [
                    HeaderWidget(dataState: state),
                  ]),
                ),
              ],
            );
          } else {
            return const Center(
              child: DottedLoaderWidget(),
            );
          }
        }));
  }
}
