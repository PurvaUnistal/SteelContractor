import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:steel_contractor/Utils/common_widgets/Background/background_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/icon_button.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_icon.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_styles.dart';
import 'package:steel_contractor/Utils/common_widgets/res/common_style.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/Utils/common_widgets/text_form_widget.dart';
import 'package:steel_contractor/features/ClearingGrading/presentation/widget/rejectApproveWidget.dart';
import 'package:steel_contractor/features/Levelling/domain/bloc/levelling_bloc.dart';
import 'package:steel_contractor/features/Levelling/domain/bloc/levelling_event.dart';
import 'package:steel_contractor/features/Levelling/domain/bloc/levelling_state.dart';

class LevellingPage extends StatefulWidget {
  const LevellingPage({super.key});

  @override
  State<LevellingPage> createState() => _LevellingPageState();
}

class _LevellingPageState extends State<LevellingPage> {
  ScrollController _horizontalScrollController = ScrollController();
  ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<LevellingBloc>(
      context,
    ).add(LevellingPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(boolLeading: true, title: AppString.levelling),
      body: BackgroundWidget(
        child: BlocBuilder<LevellingBloc, LevellingState>(
          builder: (context, state) {
            if (state is LevellingLoadedDataState) {
              return _itemBuilder(dataState: state);
            } else {
              return Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }

  Widget _itemBuilder({required LevellingLoadedDataState dataState}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              CommonStyle.vertical(context: context),
              _searchTextField(dataState: dataState),
            ],
          ),
        ),
        CommonStyle.vertical(context: context),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _dataTableWidget(dataState: dataState),
          ),
        ),
      ],
    );
  }

  Widget _searchTextField({required LevellingLoadedDataState dataState}) {
    return TextFieldWidget(
      label: AppString.reportNumber,
      hintText: AppString.reportNumber,
      controller: dataState.reportNumberController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      suffixIcon: IconButtonWidget(
        iconData: Icons.search_rounded,
        onPressed: () {},
      ),
      onChanged: (val) {
        BlocProvider.of<LevellingBloc>(
          context,
        ).add(SearchBpNumberEvent(context: context, searchBpNumber: val));
      },
    );
  }

  Widget _dataTableWidget({required LevellingLoadedDataState dataState}) {
    return dataState.reportActivityModel.success == 400
        ? Center(child: Text("No records found"))
        : Theme(
          data: ThemeData(
            highlightColor: EnvironmentConfig.of(context)!.secondaryTheme,
          ),
          child: Scrollbar(
            controller: _verticalScrollController,
            thickness: 3.0,
            scrollbarOrientation: ScrollbarOrientation.right,
            thumbVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: _verticalScrollController,
              child: Theme(
                data: ThemeData(
                  highlightColor: EnvironmentConfig.of(context)!.secondaryTheme,
                ),
                child: Scrollbar(
                  controller: _horizontalScrollController,
                  thickness: 3.0,
                  scrollbarOrientation: ScrollbarOrientation.top,
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    controller: _horizontalScrollController,
                    scrollDirection: Axis.horizontal,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerColor:
                            EnvironmentConfig.of(context)!.primaryTheme,
                      ),
                      child: DataTable(
                        sortAscending: true,
                        columnSpacing: 0,
                        horizontalMargin: 0,
                        showCheckboxColumn: false,
                        dataTextStyle: Styles.texts,
                        dataRowHeight:
                            MediaQuery.of(context).size.height * 0.04,
                        headingRowColor: MaterialStateColor.resolveWith(
                          (states) =>
                              EnvironmentConfig.of(context)!.primaryTheme,
                        ),
                        dividerThickness: 1,
                        columns: [
                          CommonStyle.dataColumn(label: "S.No"),
                          CommonStyle.dataCheckBox(
                            widget: Icon(
                              Icons.picture_as_pdf_outlined,
                              color:
                              EnvironmentConfig.of(context)!.secondaryTheme,
                            ),
                          ),
                          CommonStyle.dataCheckBox(
                            widget: Checkbox(
                              activeColor:
                                  EnvironmentConfig.of(context)!.secondaryTheme,
                              side: WidgetStateBorderSide.resolveWith((states) {
                                if (states.contains(WidgetState.selected)) {
                                  return BorderSide(
                                    color:
                                        EnvironmentConfig.of(
                                          context,
                                        )!.secondaryTheme,
                                    width: 2,
                                  ); // when checked
                                }
                                return BorderSide(
                                  color: AppColor.white,
                                  width: 2,
                                ); // when unchecked
                              }),
                              value: dataState.isAllSelected,
                              onChanged: (bool? selected) {
                                if (selected!) {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (_) => CustomCupertinoDialog(
                                      onReject: () {
                                        BlocProvider.of<LevellingBloc>(context).add(
                                          ActivityRejectEvent(context: context),
                                        );
                                      },
                                      onApprove: () {
                                        BlocProvider.of<LevellingBloc>(context).add(
                                          ActivityApprovedEvent(context: context),
                                        );
                                      },
                                    ),
                                  );
                                }
                                BlocProvider.of<LevellingBloc>(
                                  context,
                                ).add(SelectAllCheckBoxEvent(isSelected: selected, list: dataState.listOfFilterReportActivity),
                                );
                              },
                            ),
                          ),
                          CommonStyle.dataColumn(label: "Report Number"),
                          CommonStyle.dataColumn(label: "Date"),
                          CommonStyle.dataColumn(label: "Chainage From"),
                          CommonStyle.dataColumn(label: "Chainage To"),
                          CommonStyle.dataColumn(label: "Spread"),
                          CommonStyle.dataColumn(label: "Weather"),
                          CommonStyle.dataColumn(label: "File"),
                          CommonStyle.dataColumn(label: "Section"),
                        ],
                        rows: dataState.listOfFilterReportActivity.mapIndexed((index, user,) {
                              String originalDateString = user.activityDate.toString();
                              DateTime parsedDate = DateTime.parse(originalDateString,);
                              String formattedDate = DateFormat('dd-MM-yyyy',).format(parsedDate);
                              return DataRow(
                                cells: <DataCell>[
                                  CommonStyle.dataCell(
                                    label: (dataState.listOfFilterReportActivity.indexOf(user) + 1 + (dataState.pageNo - 1) * 10).toString(),
                                  ),
                                  DataCell(
                                    user.attachFile!.isNotEmpty
                                        ? InkWell(

                                      onTap: () {
                                        BlocProvider.of<LevellingBloc>(
                                          context,
                                        ).add(
                                          DownloadPdfEvent(
                                            url: user.downloadLink ?? "",
                                            context: context,
                                          ),
                                        );
                                      },
                                      child: Image.asset(AppIcon.pdfIcon,width: 18,height: 18,),
                                    )
                                        :Text("No PDF",style: TextStyle(
                                        fontSize: 8
                                    )),
                                  ),
                                  DataCell(
                                    Checkbox(
                                      activeColor: EnvironmentConfig.of(context,)!.secondaryTheme,
                                      side: WidgetStateBorderSide.resolveWith((
                                        states,
                                      ) {
                                        return BorderSide(
                                          color: EnvironmentConfig.of(context,)!.secondaryTheme,
                                          width: 2,
                                        ); // when unchecked
                                      }),
                                      value: dataState.selectedRowIds.contains(
                                        user.id.toString(),
                                      ),
                                      onChanged: (bool? selected) {
                                        BlocProvider.of<LevellingBloc>(
                                          context,
                                        ).add(
                                          SelectRowIdCheckBoxEvent(
                                            context: context,
                                            isSelected: selected ?? false,
                                            itemId: user.id.toString(),
                                          ),
                                        );
                                        if (selected!) {
                                          showCupertinoDialog(
                                            context: context,
                                            builder: (_) => CustomCupertinoDialog(
                                              onReject: () {
                                                BlocProvider.of<LevellingBloc>(context).add(
                                                  ActivityRejectEvent(context: context),
                                                );
                                              },
                                              onApprove: () {
                                                BlocProvider.of<LevellingBloc>(context).add(
                                                  ActivityApprovedEvent(context: context),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.reportNo.toString(),
                                  ),
                                  CommonStyle.dataCell(
                                    label: formattedDate.toString(),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.chainageFrom.toString(),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.chainageTo.toString(),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.sectionName.toString(),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.weather.toString(),
                                  ),
                                  DataCell(
                                    user.attachFile!.isNotEmpty
                                        ? InkWell(
                                      onTap: () {
                                        BlocProvider.of<LevellingBloc>(
                                          context,
                                        ).add(
                                          ImageViewEvent(
                                            url: user.image ?? "",
                                            context: context,
                                          ),
                                        );
                                      },
                                      child: Icon(Icons.image, color: EnvironmentConfig.of(context)!.secondaryTheme,),
                                    )
                                        :Text("No File",style: TextStyle(
                                        fontSize: 8
                                    )),
                                  ),
                                  CommonStyle.dataCell(
                                    label: user.sectionName.toString(),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
