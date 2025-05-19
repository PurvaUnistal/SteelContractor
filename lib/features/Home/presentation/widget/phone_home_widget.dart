import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/common_widgets/Background/background_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/WaveLoaderWidget.dart';
import 'package:steel_contractor/Utils/common_widgets/Routes/routes.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';

import 'logout_widget.dart';

class PhoneHomeWidget extends StatefulWidget {
  const PhoneHomeWidget({super.key});

  @override
  State<PhoneHomeWidget> createState() => _PhoneHomeWidgetState();
}

class _PhoneHomeWidgetState extends State<PhoneHomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: HomeDrawerWidget(),
      appBar: AppBarWidget(
        title:"Home",
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                showModalBottomSheet(
                    context: context,
                    builder: (context) => const LogoutWidget());
              },
            ),
          ),
        ],
      ),
      body: BackgroundWidget(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchHomeDataState) {
              return _buildLayout(dataState: state);
            } else {
              return const Center(child: WaveLoaderWidget());
            }
          },
        ),
      ),
    );
  }

  Widget _buildLayout({required FetchHomeDataState dataState}) {
    return ListView.builder(
      itemCount: dataState.listActivityData.length,
      itemBuilder: (BuildContext context, int i) {
        final data = dataState.listActivityData[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
          child: Card(
            child: ListTile(
              onTap: (){
                AppConfig.instanceInit()?.setActivityData(newActivitySectionData: data);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Routes.getRouteForActivity(data)));
              },
              title: Text(data.activityName!),
             // leading: Icon(icon[i]),
            ),
          ),
        );
      },
    );
  }

  List<IconData> icon = [
    Icons.alt_route_sharp,
    Icons.handshake_outlined,
    Icons.handshake_outlined,
    Icons.auto_graph,
    Icons.comment_bank_outlined,
    Icons.fire_hydrant_alt_outlined,
    Icons.offline_share,
    Icons.present_to_all_sharp,
    Icons.air,
    Icons.terrain,
  ];
}
