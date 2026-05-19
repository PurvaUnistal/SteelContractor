import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:steel_contractor/Utils/common_widgets/app_bar_widget.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_color.dart';
import 'package:steel_contractor/Utils/common_widgets/res/app_icon.dart';
import 'package:steel_contractor/Utils/common_widgets/res/environment_config.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_bloc.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_event.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/bloc/approver_activity_state.dart';
import 'package:steel_contractor/features/ApproverActivity/domain/model/ReportActivityModel.dart';
import 'package:steel_contractor/features/ApproverActivity/presentation/widgets/rejectApproveWidget.dart';
import 'package:steel_contractor/features/Home/domain/model/ActivitySectionModel.dart';

class ApproverActivityPage extends StatefulWidget {
  final ActivitySectionData data;
  const ApproverActivityPage({super.key, required this.data});

  @override
  State<ApproverActivityPage> createState() => _ApproverActivityPageState();
}

class _ApproverActivityPageState extends State<ApproverActivityPage>
    with TickerProviderStateMixin {
  late final AnimationController _listCtrl;

  @override
  void initState() {
    super.initState();
    _listCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
    BlocProvider.of<ApproverActivityBloc>(context)
        .add(ApproverActivityPageLoadEvent(context: context));
  }

  @override
  void dispose() {
    _listCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      appBar: AppBarWidget(
        boolLeading: true,
        title: widget.data.activityName.toString(),
      ),
      body: BlocBuilder<ApproverActivityBloc, ApproverActivityState>(
        builder: (context, state) {
          if (state is ApproverActivityLoadedDataState) {
            return _buildContent(state);
          }
          return const _Skeleton();
        },
      ),
    );
  }

  Widget _buildContent(ApproverActivityLoadedDataState state) {
    final items = state.listOfFilterReportActivity;
    final isEmpty =
        state.reportActivityModel.success == 400 || items.isEmpty;

    return Column(
      children: [
        // ── Search bar ──
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: _SearchBar(
            controller: state.reportNumberController,
            onChanged: (val) {
              BlocProvider.of<ApproverActivityBloc>(context).add(
                SearchBpNumberEvent(context: context, searchBpNumber: val),
              );
            },
          ),
        ),

        // ── Select-all row ──
        if (!isEmpty)
          _SelectAllRow(
            isAllSelected: state.isAllSelected,
            count: items.length,
            onSelectAll: (selected) {
              if (selected!) {
                showCupertinoDialog(
                  context: context,
                  builder: (_) => CustomCupertinoDialog(
                    onReject: () => BlocProvider.of<ApproverActivityBloc>(context)
                        .add(ActivityRejectEvent(context: context)),
                    onApprove: () => BlocProvider.of<ApproverActivityBloc>(context)
                        .add(ActivityApprovedEvent(context: context)),
                  ),
                );
              }
              BlocProvider.of<ApproverActivityBloc>(context).add(
                SelectAllCheckBoxEvent(
                    isSelected: selected, list: items),
              );
            },
          ),

        // ── List ──
        Expanded(
          child: isEmpty
              ? const _EmptyState()
              : _buildList(state),
        ),
      ],
    );
  }

  Widget _buildList(ApproverActivityLoadedDataState state) {
    final items = state.listOfFilterReportActivity;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
            child: Text(
              'REPORTS · ${items.length} TOTAL',
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
                final user = items[i];
                final start = (i * 0.07).clamp(0.0, 0.85);
                final end = (start + 0.45).clamp(0.0, 1.0);
                final anim = CurvedAnimation(
                  parent: _listCtrl,
                  curve: Interval(start, end, curve: Curves.easeOutCubic),
                );
                final sNo = i + 1 + (state.pageNo - 1) * 10;

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
                    child: _ReportCard(
                      user: user,
                      sNo: sNo,
                      isSelected: state.selectedRowIds
                          .contains(user.id.toString()),
                      onCheckChanged: (selected) {
                        BlocProvider.of<ApproverActivityBloc>(context).add(
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
                              onReject: () =>
                                  BlocProvider.of<ApproverActivityBloc>(context)
                                      .add(ActivityRejectEvent(context: context)),
                              onApprove: () =>
                                  BlocProvider.of<ApproverActivityBloc>(context)
                                      .add(ActivityApprovedEvent(context: context)),
                            ),
                          );
                        }
                      },
                      onPdfTap: user.downloadLink?.isNotEmpty == true
                          ? () => BlocProvider.of<ApproverActivityBloc>(context)
                          .add(DownloadPdfEvent(
                          url: user.downloadLink ?? '',
                          context: context))
                          : null,
                      onFileTap: () => _handleFileTap(user.image ?? ''),
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }

  void _handleFileTap(String link) {
    if (link.trim().isEmpty ||
        link == '-' ||
        link.toLowerCase() == 'null') return;

    final isPdf = link.toLowerCase().endsWith('.pdf');
    if (isPdf) {
      BlocProvider.of<ApproverActivityBloc>(context)
          .add(DownloadPdfEvent(url: link, context: context));
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: AppColor.bg,
            appBar: AppBarWidget(boolLeading: true, title: 'Image'),
            body: Center(
              child: InteractiveViewer(
                child: Image.network(
                  link,
                  loadingBuilder: (_, child, progress) =>
                  progress == null ? child : const CircularProgressIndicator(),
                  errorBuilder: (_, __, ___) =>
                  const Text('No Image URL Found'),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
}

// ─────────────────────────────────────────────
// Search Bar
// ─────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColor.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.border, width: 0.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 12),
          const Icon(Icons.search_rounded, color: AppColor.textHint, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 14,
                color: AppColor.text,
              ),
              decoration: const InputDecoration(
                hintText: 'Search report number…',
                hintStyle: TextStyle(color: AppColor.textHint, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Select-all row
// ─────────────────────────────────────────────

class _SelectAllRow extends StatelessWidget {
  final bool isAllSelected;
  final int count;
  final ValueChanged<bool?> onSelectAll;
  const _SelectAllRow(
      {required this.isAllSelected,
        required this.count,
        required this.onSelectAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: AppColor.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColor.border, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Checkbox(
              value: isAllSelected,
              onChanged: onSelectAll,
              activeColor: AppColor.blue,
              side: const BorderSide(color: AppColor.textHint, width: 1.5),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
            const SizedBox(width: 8),
            Text(
              isAllSelected ? 'Deselect all' : 'Select all  ($count)',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColor.text,
              ),
            ),
            const Spacer(),
            if (isAllSelected)
              Row(
                children: [
                  _ActionChip(
                    label: 'Approve',
                    color: AppColor.green,
                    bgColor: AppColor.greenBg,
                    icon: Icons.check_rounded,
                  ),
                  const SizedBox(width: 6),
                  _ActionChip(
                    label: 'Reject',
                    color: AppColor.red,
                    bgColor: const Color(0xFFFCEBEB),
                    icon: Icons.close_rounded,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final Color color;
  final Color bgColor;
  final IconData icon;
  const _ActionChip(
      {required this.label,
        required this.color,
        required this.bgColor,
        required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w700, color: color)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Report Card
// ─────────────────────────────────────────────

class _ReportCard extends StatefulWidget {
  final ReportActivityData user;
  final int sNo;
  final bool isSelected;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback? onPdfTap;
  final VoidCallback onFileTap;

  const _ReportCard({
    required this.user,
    required this.sNo,
    required this.isSelected,
    required this.onCheckChanged,
    required this.onPdfTap,
    required this.onFileTap,
  });

  @override
  State<_ReportCard> createState() => _ReportCardState();
}

class _ReportCardState extends State<_ReportCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final u = widget.user;
    String formattedDate = '—';
    try {
      formattedDate =
          DateFormat('dd-MM-yyyy').format(DateTime.parse(u.activityDate.toString()));
    } catch (_) {}

    final hasFile = u.image != null &&
        u.image.toString().trim().isNotEmpty &&
        u.image.toString() != '-' &&
        u.image.toString().toLowerCase() != 'null';
    final isPdf = hasFile && u.image.toString().toLowerCase().endsWith('.pdf');

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () => widget.onCheckChanged(!widget.isSelected),
      child: AnimatedScale(
        scale: _pressed ? 0.975 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isSelected
                ? AppColor.blueBg
                : AppColor.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: widget.isSelected
                  ? AppColor.blue.withOpacity(0.35)
                  : _pressed
                  ? AppColor.blue.withOpacity(0.35)
                  : AppColor.border,
              width: widget.isSelected ? 1.0 : 0.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Serial number badge
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: widget.isSelected
                            ? AppColor.blue.withOpacity(0.12)
                            : AppColor.surfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: widget.isSelected
                              ? AppColor.blue.withOpacity(0.25)
                              : AppColor.border,
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.sNo}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: widget.isSelected
                                ? AppColor.blue
                                : AppColor.textHint,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Report number + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            u.reportNo?.toString() ?? '—',
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
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColor.textHint,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Actions: PDF + file icons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (u.downloadLink?.isNotEmpty == true)
                          GestureDetector(
                            onTap: widget.onPdfTap,
                            child: Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFCEBEB),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.asset(AppIcon.pdfIcon,
                                  width: 16, height: 16),
                            ),
                          ),
                        if (hasFile)
                          GestureDetector(
                            onTap: widget.onFileTap,
                            child: Container(
                              width: 32,
                              height: 32,
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: AppColor.blueBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                isPdf
                                    ? Icons.picture_as_pdf_rounded
                                    : Icons.image_rounded,
                                size: 16,
                                color: AppColor.blue,
                              ),
                            ),
                          ),
                        // Checkbox
                        Checkbox(
                          value: widget.isSelected,
                          onChanged: widget.onCheckChanged,
                          activeColor: AppColor.blue,
                          side:
                          const BorderSide(color: AppColor.textHint, width: 1.5),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ── Divider ──
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: Divider(color: AppColor.divider, thickness: 0.5, height: 1),
              ),

              // ── Meta pills ──
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    _MetaPill(label: 'FROM',    value: u.chainageFrom?.toString() ?? '—'),
                    _MetaPill(label: 'TO',      value: u.chainageTo?.toString()   ?? '—'),
                    _MetaPill(label: 'SPREAD',  value: u.spreadName?.toString()       ?? '—'),  // ← add this
                    _MetaPill(label: 'WEATHER', value: u.weather?.toString()      ?? '—'),
                    _MetaPill(label: 'SECTION', value: u.sectionName?.toString()  ?? '—'),
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
// Meta Pill
// ─────────────────────────────────────────────

class _MetaPill extends StatelessWidget {
  final String label;
  final String value;
  const _MetaPill({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.border, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label  ',
            style: const TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: AppColor.textHint,
              letterSpacing: 0.8,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColor.text,
            ),
          ),
        ],
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
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.inbox_rounded,
                color: AppColor.textHint, size: 28),
          ),
          const SizedBox(height: 12),
          const Text(
            'No records found',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColor.text),
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
    return Column(
      children: [
        // Search bar skeleton
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: AnimatedBuilder(
            animation: _pulse,
            builder: (_, __) => Container(
              height: 44,
              decoration: BoxDecoration(
                color: Color.lerp(
                    AppColor.surface, AppColor.surfaceAlt, _pulse.value),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColor.border, width: 0.5),
              ),
            ),
          ),
        ),
        // Card skeletons
        Expanded(
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (_, __) => AnimatedBuilder(
                      animation: _pulse,
                      builder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color.lerp(AppColor.surface,
                                AppColor.surfaceAlt, _pulse.value),
                            borderRadius: BorderRadius.circular(14),
                            border:
                            Border.all(color: AppColor.border, width: 0.5),
                          ),
                        ),
                      ),
                    ),
                    childCount: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
