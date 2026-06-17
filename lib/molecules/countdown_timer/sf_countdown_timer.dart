import 'dart:async';

import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

class SfCountdownDuration {
  const SfCountdownDuration({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  static const zero = SfCountdownDuration(
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0,
  );

  bool get isZero =>
      days == 0 && hours == 0 && minutes == 0 && seconds == 0;

  factory SfCountdownDuration.fromRemaining(Duration remaining) {
    final totalSeconds = remaining.inSeconds.clamp(0, 1 << 31);
    final days = totalSeconds ~/ Duration.secondsPerDay;
    final hours = (totalSeconds % Duration.secondsPerDay) ~/ Duration.secondsPerHour;
    final minutes =
        (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;
    final seconds = totalSeconds % Duration.secondsPerMinute;

    return SfCountdownDuration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
    );
  }

  String format(int value) => value.toString().padLeft(2, '0');
}

class SfCountdownTimer extends StatefulWidget {
  const SfCountdownTimer({
    super.key,
    required this.target,
    this.onComplete,
    this.showDays = true,
  });

  final DateTime target;
  final VoidCallback? onComplete;
  final bool showDays;

  @override
  State<SfCountdownTimer> createState() => _SfCountdownTimerState();
}

class _SfCountdownTimerState extends State<SfCountdownTimer> {
  Timer? _timer;
  SfCountdownDuration _duration = SfCountdownDuration.zero;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  @override
  void didUpdateWidget(SfCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.target != widget.target) {
      _completed = false;
      _tick();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _tick() {
    final remaining = widget.target.difference(DateTime.now());
    final nextDuration = remaining.isNegative
        ? SfCountdownDuration.zero
        : SfCountdownDuration.fromRemaining(remaining);

    if (mounted) {
      setState(() => _duration = nextDuration);
    }

    if (nextDuration.isZero && !_completed) {
      _completed = true;
      widget.onComplete?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SfCountdownTimerDisplay(
      duration: _duration,
      showDays: widget.showDays,
    );
  }
}

class SfCountdownTimerDisplay extends StatelessWidget {
  const SfCountdownTimerDisplay({
    super.key,
    required this.duration,
    this.showDays = true,
  });

  final SfCountdownDuration duration;
  final bool showDays;

  static const _cellHeight = 80.0;
  static const _cellMinWidth = 56.0;
  static const _separatorWidth = 20.0;
  static const _labelLetterSpacing = 2.4;

  @override
  Widget build(BuildContext context) {
    final units = <_CountdownUnit>[
      if (showDays)
        _CountdownUnit(
          value: duration.format(duration.days),
          label: 'DAYS',
        ),
      _CountdownUnit(
        value: duration.format(duration.hours),
        label: 'HOURS',
      ),
      _CountdownUnit(
        value: duration.format(duration.minutes),
        label: 'MINS',
      ),
      _CountdownUnit(
        value: duration.format(duration.seconds),
        label: 'SECS',
      ),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 375,
        maxWidth: 430,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spacing4,
          vertical: AppSpacing.spacing2,
        ),
        child: Row(
          children: [
            for (var index = 0; index < units.length; index++) ...[
              if (index > 0) const _CountdownSeparator(),
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: _cellMinWidth),
                  child: _CountdownCell(unit: units[index]),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _CountdownUnit {
  const _CountdownUnit({required this.value, required this.label});

  final String value;
  final String label;
}

class _CountdownCell extends StatelessWidget {
  const _CountdownCell({required this.unit});

  final _CountdownUnit unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SfCountdownTimerDisplay._cellHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.spacing1,
        vertical: AppSpacing.spacing2,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutral50,
        borderRadius: BorderRadius.circular(AppRadius.radius4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            unit.value,
            textAlign: TextAlign.center,
            style: AppTypography.textXxl.bold(color: AppColors.neutral800),
          ),
          const SizedBox(height: AppSpacing.spacing1),
          Text(
            unit.label,
            textAlign: TextAlign.center,
            style: AppTypography.textXs.regular(color: AppColors.neutral800).copyWith(
              letterSpacing: SfCountdownTimerDisplay._labelLetterSpacing,
            ),
          ),
        ],
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SfCountdownTimerDisplay._separatorWidth,
      height: SfCountdownTimerDisplay._cellHeight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot,
            const SizedBox(height: AppSpacing.spacing1),
            _dot,
          ],
        ),
      ),
    );
  }

  static const _dot = SizedBox(
    width: AppSpacing.spacing1,
    height: AppSpacing.spacing1,
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutral400,
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.radius4)),
      ),
    ),
  );
}
