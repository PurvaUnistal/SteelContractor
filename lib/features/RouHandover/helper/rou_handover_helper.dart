import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/Utils.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:steel_contractor/Utils/common_widgets/Routes/routes.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/common_style.dart';
import 'package:steel_contractor/Utils/common_widgets/text_form_widget.dart';
import 'package:steel_contractor/features/RouHandover/domain/bloc/rou_handover_bloc.dart';

class RouHandoverHelper{
  static showConfirmationDialog({
    required BuildContext context,
    required emit,
    required bool isApproval,
    required TextEditingController remarksController,
    required Future<void> Function() onConfirm,
  }) async {
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return BlocBuilder<RouHandoverBloc, RouHandoverState>(
          builder: (context, state) {
            if (state is RouHandoverLoadedDataState) {
              return Material(
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Confirm?",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          CommonStyle.vertical(context: context),
                          Text(
                            isApproval
                                ? "Are you sure you want to approve this record?"
                                : "Are you sure you want to reject this record?",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          CommonStyle.vertical(context: context),
                          if (!isApproval)
                            TextFieldWidget(
                              star: AppString.star,
                              label: AppString.remarks,
                              hintText: AppString.remarks,
                              controller: remarksController,
                            ),
                          CommonStyle.vertical(context: context),
                          state.isBtnLoader
                              ? DottedLoaderWidget()
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if(remarksController.text.isEmpty && !isApproval){
                                    return Utils.errorSnackBar(
                                      msg: "This Remarks is required",
                                      context:context,
                                    );
                                  }
                                  await onConfirm();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                child: Text("OK"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text("Cancel"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}