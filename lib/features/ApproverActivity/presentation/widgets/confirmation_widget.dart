import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steel_contractor/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:steel_contractor/Utils/common_widgets/dropdown_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'package:steel_contractor/Utils/common_widgets/text_form_widget.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_bloc.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_event.dart';
import 'package:steel_contractor/features/Home/domain/model/tpi_model.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final Future<void> Function() onConfirm;
  final VoidCallback onCancel;
  final bool showDropdown;
  final bool isBtnLoading;
  final TpiModel? dropdownValue;
  final List<TpiModel>? items;
  final TextEditingController? remarksController;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    this.showDropdown = false,
    this.isBtnLoading = false,
    this.dropdownValue,
    this.items,
    this.remarksController,
  });

  @override
  Widget build(BuildContext context) {
    final roleType = AppConfig.instanceInit()?.loginData.user!.role.toString();
    return Material(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              if (showDropdown && items != null)
                roleType != null && roleType.toLowerCase().toString() == "client" ? SizedBox.shrink()
                    :  DropdownWidget<TpiModel>(
                  hint: roleType != null && roleType.toLowerCase().toString() == "tpi"
                          ? "Select PMC"
                          : roleType != null && roleType.toLowerCase().toString() == "pmc"
                          ? "Select Client"
                          :  "Select TPI",
                  label: roleType != null && roleType.toLowerCase().toString() == "tpi"
                      ? "Select PMC"
                      : roleType != null && roleType.toLowerCase().toString() == "pmc"
                      ? "Select Client"
                      :  "Select TPI",
                  dropdownValue: dropdownValue?.iD == null ? null : dropdownValue,
                  items: items!,
                  onChanged: (val) {
                    context
                        .read<ApproverActivityBloc>()
                        .add(SelectTpiEvent(tpiValue: val!));
                  },
                )
              else
                const SizedBox(),

              if (showDropdown) const SizedBox(height: 16),
              TextFieldWidget(
                hintText: "Remarks",
                label: "Remarks",
                controller: remarksController,
              ),

              const SizedBox(height: 16),

              /// Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isBtnLoading
                      ? const DottedLoaderWidget()
                      : TextButton(
                    onPressed: onConfirm,
                    child: const Text("OK"),
                  ),
                  TextButton(
                    onPressed: onCancel,
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}