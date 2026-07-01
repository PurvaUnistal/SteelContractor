import 'dart:async';
import 'package:flutter/material.dart';
import 'package:steel_contractor/Utils/common_widgets/res/enums.dart';
import 'connectivity_helper.dart';
import 'res/app_color.dart';
import 'res/app_styles.dart';
import 'res/environment_config.dart';

class InternetConnectivityPopWidget extends StatefulWidget {
  final VoidCallback? onRetry;
  const InternetConnectivityPopWidget({super.key, this.onRetry});

  @override
  State<InternetConnectivityPopWidget> createState() =>
      _InternetConnectivityPopWidgetState();
}

class _InternetConnectivityPopWidgetState
    extends State<InternetConnectivityPopWidget> {
  Timer? _timer;
  bool _isChecking = false;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      if (_isChecking) return;
      _isChecking = true;
      final connected = await ConnectivityHelper.checkInterNetConnect();
      _isChecking = false;

      if (connected && mounted) {
        _timer?.cancel();
        Navigator.pop(context);
        widget.onRetry?.call();
      }

      if (mounted) {
        setState(() => _isConnected = connected);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Icon(
                  Icons.wifi_off_rounded,
                  size: 100,
                  color: EnvironmentConfig.of(context)!.primaryTheme,
                ),

                const SizedBox(height: 24),

                // Title
                Text(
                  "No Internet Connection",
                  style: Styles.texts.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 12),

                // Subtitle
                Text(
                  "Please check your Wi-Fi or mobile data and we'll reconnect automatically.",
                  style: Styles.texts.copyWith(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 40),

                // Auto-reconnect indicator
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: EnvironmentConfig.of(context)!.primaryTheme,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Waiting for connection...",
                      style: Styles.texts.copyWith(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Manual retry button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() => _isChecking = true);
                      final connected =
                      await ConnectivityHelper.checkInterNetConnect();
                      setState(() => _isChecking = false);
                      if (connected && mounted) {
                        _timer?.cancel();
                        Navigator.pop(context);
                        widget.onRetry?.call();
                      }
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text("Retry Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EnvironmentConfig.of(context)!.primaryTheme,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}