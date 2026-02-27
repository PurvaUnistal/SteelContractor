import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_string.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';

class CustomCupertinoDialog extends StatelessWidget {
  final VoidCallback onReject;
  final VoidCallback onApprove;

  const CustomCupertinoDialog({
    super.key,
    required this.onReject,
    required this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // to show rounded corners nicely
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppString.sure,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  AppString.approveRejectMsg,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pop();
                          onReject();
                        },
                        child: Text(
                          AppString.reject,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.of(context).pop();
                          onApprove();
                        },
                        child: Text(
                          AppString.approve,
                          style: TextStyle(
                            color: EnvironmentConfig.of(context)!.primaryTheme,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.cancel, color: Colors.red, size: 28),
          ),
        ],
      ),

    );
  }
}