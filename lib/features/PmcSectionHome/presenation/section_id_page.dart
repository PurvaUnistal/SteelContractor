import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/app_update_message_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/message_box_two_button_pop.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_config.dart';
import 'package:steel_contractor/features/Home/presentation/page/home_page.dart';
import 'package:steel_contractor/features/Home/presentation/widget/logout_widget.dart';
import 'package:steel_contractor/features/Home/presentation/widget/stat_pill_widget.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_bloc.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_event.dart';
import 'package:steel_contractor/features/PmcSectionHome/domain/bloc/pmc_section_home_state.dart';

class SectionIdPage extends StatefulWidget {
  const SectionIdPage({super.key});

  @override
  State<SectionIdPage> createState() => _SectionIdPageState();
}

class _SectionIdPageState extends State<SectionIdPage>
    with TickerProviderStateMixin {
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
    BlocProvider.of<PmcSectionHomeBloc>(
      context,
    ).add(PmcSectionHomePageLoadEvent(context: context));
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkForUpdate() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final String applicationId = packageInfo.packageName;
      final String androidPlayStoreUrl =
          'https://play.google.com/store/apps/details?id=$applicationId&hl=en&gl=US';
      final dynamic result = await _channel.invokeMethod('getAppUpdate');
      if (!mounted) return;
      if (Platform.isAndroid) {
        if (kDebugMode) debugPrint('Upgrade Message ============== $result');
        if (result.toString() == 'success') {
          try {
            AppUpdateMessage.showAlertDialog(
              context: context,
              url: androidPlayStoreUrl,
              isLater: false,
            );
          } catch (_) {
            AppUpdateMessage.showAlertDialog(
              context: context,
              url: androidPlayStoreUrl,
            );
          }
        }
      }
    } on PlatformException catch (e) {
      debugPrint('PlatformException: ${e.message}');
    }
  }

  Future<bool> _onWillPop() async =>
      (await showDialog<bool>(
        context: context,
        builder:
            (_) => MessageBoxTwoButtonPopWidget(
              message: 'Do you want to exit the App?',
              okButtonText: 'Exit',
              onPressed: () => Navigator.of(context).pop(true),
            ),
      )) ??
      false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColor.bg,
        appBar: AppBarWidget(
          title: 'Section Home',
          boolLeading: false,
          actions: [
            Builder(
              builder:
                  (context) => IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed:
                        () => showModalBottomSheet(
                          context: context,
                          builder: (_) => const LogoutWidget(),
                        ),
                  ),
            ),
          ],
        ),
        body: BlocBuilder<PmcSectionHomeBloc, PmcSectionHomeState>(
          builder: (context, state) {
            if (state is FetchPmcSectionHomeDataState) {
              if (state.sectionIdModel.success == 400) {
                return const _EmptyState();
              }
              return _buildList(state);
            }
            return const _Skeleton();
          },
        ),
      ),
    );
  }

  Widget _buildList(FetchPmcSectionHomeDataState state) {
    final items = state.listOfSectionId.where((d) => d.sectionName?.isNotEmpty == true).toList();

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Text(
              'SECTIONS · ${items.length} TOTAL',
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
            delegate: SliverChildBuilderDelegate((context, i) {
              final data = items[i];
              final start = (i * 0.07).clamp(0.0, 0.85);
              final end = (start + 0.45).clamp(0.0, 1.0);
              final anim = CurvedAnimation(
                parent: _listCtrl,
                curve: Interval(start, end, curve: Curves.easeOutCubic),
              );
              return AnimatedBuilder(
                animation: anim,
                builder:
                    (_, child) => Opacity(
                      opacity: anim.value,
                      child: Transform.translate(
                        offset: Offset(0, 22 * (1 - anim.value)),
                        child: child,
                      ),
                    ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _SectionCard(data: data),
                ),
              );
            }, childCount: items.length),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Section Card
// ─────────────────────────────────────────────

class _SectionCard extends StatefulWidget {
  final dynamic data; // your SectionId model type
  const _SectionCard({required this.data});

  @override
  State<_SectionCard> createState() => _SectionCardState();
}

class _SectionCardState extends State<_SectionCard> {
  bool _pressed = false;

  void _navigate() {
    AppConfig.instanceInit()?.setSectionId(
      newSectionId: widget.data.sectionId!,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => const HomePage(),
        transitionsBuilder:
            (_, anim, __, child) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
                ),
                child: child,
              ),
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: _navigate,
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color:
                  _pressed
                      ? const Color(0xFFC7D9FA) // blue-border accent on press
                      : AppColor.border,
              width: 0.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header row ──
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon badge
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF4FF),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFC7D9FA),
                          width: 0.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.grid_view_rounded,
                        color: Color(0xFF2563EB),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Name
                    Expanded(
                      child: Text(
                        d.sectionName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColor.text,
                          letterSpacing: 0.1,
                        ),
                      ),
                    ),
                    // Arrow
                    Container(
                      width: 28,
                      height: 28,
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
                child: Divider(
                  color: AppColor.divider,
                  thickness: 0.5,
                  height: 1,
                ),
              ),

              // ── Stats row ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Row(
                  children: [
                    StatPill(
                      label: 'SECTION ID',
                      value: d.sectionId?.toString() ?? '—',
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

// ─────────────────────────────────────────────
// Empty state
// ─────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColor.surfaceAlt,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.inbox_rounded,
              color: AppColor.textHint,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No records found',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColor.text,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'There are no sections available.',
            style: TextStyle(fontSize: 13, color: AppColor.textHint),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Skeleton loader
// ─────────────────────────────────────────────

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
                builder:
                    (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            AppColor.surface,
                            AppColor.surfaceAlt,
                            _pulse.value,
                          ),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColor.border,
                            width: 0.5,
                          ),
                        ),
                      ),
                    ),
              ),
              childCount: 4,
            ),
          ),
        ),
      ],
    );
  }
}
