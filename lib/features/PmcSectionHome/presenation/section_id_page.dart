import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/common_widgets/Background/background_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/WaveLoaderWidget.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Home/presentation/widget/logout_widget.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_event.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_state.dart';

class SectionIdPage extends StatefulWidget {
  const SectionIdPage({super.key});

  @override
  State<SectionIdPage> createState() => _SectionIdPageState();
}

class _SectionIdPageState extends State<SectionIdPage> {
  @override
  void initState() {
    BlocProvider.of<PmcSectionHomeBloc>(context).add(PmcSectionHomePageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child:Scaffold(
        // drawer: PmcSectionHomeDrawerWidget(),
        appBar: AppBarWidget(
          title:"PMC Section Home",
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
          child: BlocBuilder<PmcSectionHomeBloc, PmcSectionHomeState>(
            builder: (context, state) {
              if (state is FetchPmcSectionHomeDataState) {
                return _buildLayout(dataState: state);
              } else {
                return const Center(child: WaveLoaderWidget());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLayout({required FetchPmcSectionHomeDataState dataState}) {

    return ListView.builder(
      itemCount: dataState.listOfSectionId.length,
      itemBuilder: (BuildContext context, int i) {
        final data = dataState.listOfSectionId[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Card(
              child: ListTile(
                onTap: () {
                  AppConfig.instanceInit()?.setSectionId(newSectionId: data.sectionId!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage()
                    ),
                  );
                },
                title: Text(data.sectionName ?? "No Section Name"),
              ),
            ),
          );

      },
    );
  }




  Future<bool> _onWillPop() async {
    return (await showDialog(
        context: context,
        builder: (BuildContext mContext) => MessageBoxTwoButtonPopWidget(
            message: "Do you want to exit an App?",
            okButtonText: "Exit",
            onPressed: () => Navigator.of(context).pop(true)))) ??
        false;
  }
}




