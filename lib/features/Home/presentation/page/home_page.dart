import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/app_update_message_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/ApproverActivity/presentation/approver_activity_page.dart';
import 'package:steel_contractor/features/Home/domain/bloc/home_bloc.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';
import 'package:steel_contractor/features/Home/presentation/widget/activity_meta.dart';
import 'package:steel_contractor/features/Home/presentation/widget/logout_widget.dart';
import 'package:steel_contractor/features/Home/presentation/widget/stat_pill_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const _channel = MethodChannel('steelApprover');
  late final AnimationController _listCtrl;

  @override
  void initState() {
    super.initState();
    _listCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    _checkForUpdate();
    BlocProvider.of<HomeBloc>(context).add(HomePageLoadEvent(context: context));
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdate() async {
    try {
      final result = await _channel.invokeMethod('getAppUpdate');
      if (result == null) return;
      final data = result as Map<dynamic, dynamic>;
      if (!(data['update'] ?? false)) return;
      final info = await PackageInfo.fromPlatform();
      final url = Platform.isAndroid
          ? 'https://play.google.com/store/apps/details?id=${info.packageName}'
          : 'https://apps.apple.com/app/id${data['appId']}';
      if (!mounted) return;
      AppUpdateMessage.showAlertDialog(context: context, url: url, isLater: false);
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
    }
  }

  Future<bool> _onWillPop() async =>
      (await showDialog<bool>(
        context: context,
        builder: (_) => MessageBoxTwoButtonPopWidget(
          message: 'Do you want to exit the App?',
          okButtonText: 'Exit',
          onPressed: () => Navigator.of(context).pop(true),
        ),
      )) ??
          false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.bg,
     //   extendBodyBehindAppBar: true,
        appBar: AppBarWidget(
          title:"Dasboard",
          boolLeading: true,
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
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is FetchHomeDataState) {
              return _buildList(state);
            }
            return const _Skeleton();
          },
        ),
      ),
    );
  }

  Widget _buildList(FetchHomeDataState state) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              'ACTIVITIES · ${state.listActivityData.length} TOTAL',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColor.textHint,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 40),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, i) {
                final data = state.listActivityData[i];
                // ✅ Fix 2: use `metas` (the list), not `ActivityMeta` (the class)
                // ✅ Fix 3: use `.length` not `..length` (no cascade)
                final meta  = metas[i % metas.length];
                final start = (i * 0.07).clamp(0.0, 0.85);
                final end   = (start + 0.45).clamp(0.0, 1.0);
                final anim  = CurvedAnimation(
                  parent: _listCtrl,
                  curve: Interval(start, end, curve: Curves.easeOutCubic),
                );
                return AnimatedBuilder(
                  animation: anim,
                  builder: (_, child) => Opacity(
                    opacity: anim.value,
                    child: Transform.translate(
                      offset: Offset(0, 22 * (1 - anim.value)),
                      child: child,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ActivityCard(data: data, meta: meta),
                  ),
                );
              },
              childCount: state.listActivityData.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityCard extends StatefulWidget {
  final ActivitySectionData data;
  final ActivityMeta meta;
  const _ActivityCard({required this.data, required this.meta});

  @override
  State<_ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<_ActivityCard> with SingleTickerProviderStateMixin {
  late final AnimationController _barCtrl;
  late final Animation<double> _barAnim;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _barCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _barAnim = CurvedAnimation(parent: _barCtrl, curve: Curves.easeOutCubic);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _barCtrl.forward();
    });
  }

  @override
  void dispose() {
    _barCtrl.dispose();
    super.dispose();
  }

  void _navigate() {
    AppConfig.instanceInit()?.setActivityData(newActivitySectionData: widget.data);
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => ApproverActivityPage(data: widget.data),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween(begin: const Offset(0.04, 0), end: Offset.zero)
                .animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final m = widget.meta;

    return GestureDetector(
      onTapDown:   (_) => setState(() => _pressed = true),
      onTapUp:     (_) => setState(() => _pressed = false),
      onTapCancel: ()  => setState(() => _pressed = false),
      onTap: _navigate,
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _pressed ? m.iconBorder : AppColor.border,
              width: 0.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 38, height: 38,
                      decoration: BoxDecoration(
                        color: m.iconBg,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: m.iconBorder, width: 0.5),
                      ),
                      child: Icon(m.icon, color: m.iconColor, size: 18),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.activityName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColor.text,
                              letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 2),

                        ],
                      ),
                    ),
                    Container(
                      width: 28, height: 28,
                      decoration: BoxDecoration(
                        color: AppColor.surfaceAlt,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColor.textHint,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Divider ──
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Divider(color: AppColor.divider, thickness: 0.5, height: 1),
              ),

              // ── Stats row ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    StatPill(
                      label: 'REJECTED',
                      value: d.rejected?.toString() ?? '—',
                      color: AppColor.red,
                      bgColor: const Color(0xFFFCEBEB),
                    ),
                    const SizedBox(width: 8),
                    StatPill(
                      label: 'DONE',
                      value: d.done?.toString() ?? '—',
                      color: AppColor.green,
                      bgColor: AppColor.greenBg,
                    ),
                    const SizedBox(width: 8),
                    StatPill(
                      label: 'BALANCE',
                      value: d.balance?.toString() ?? '—',
                      color: AppColor.blue,
                      bgColor: AppColor.blueBg,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class _Skeleton extends StatefulWidget {
  const _Skeleton();

  @override
  State<_Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<_Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, __) => AnimatedBuilder(
                animation: _pulse,
                builder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Color.lerp(AppColor.surface, AppColor.surfaceAlt, _pulse.value),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColor.border, width: 0.5),
                    ),
                  ),
                ),
              ),
              childCount: 5,
            ),
          ),
        ),
      ],
    );
  }
}
