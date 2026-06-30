import 'dart:async';

import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_radius.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/app_typography.dart';

/// Mobile countdown timer — Flutter port of Dashboard
/// `src/components/mobile-ui/CountdownTimer/CountdownTimer.tsx`.
enum SfCountdownTimerState {
  defaultState('Default');

  const SfCountdownTimerState(this.label);

  final String label;
}

class SfCountdownTime {
  const SfCountdownTime({
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  static const zero = SfCountdownTime(
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0,
  );

  factory SfCountdownTime.fromRemaining(Duration remaining) {
    final totalSeconds = remaining.inSeconds.clamp(0, 1 << 31);
    return SfCountdownTime(
      days: totalSeconds ~/ 86400,
      hours: (totalSeconds ~/ 3600) % 24,
      minutes: (totalSeconds ~/ 60) % 60,
      seconds: totalSeconds % 60,
    );
  }

  Duration get duration => Duration(
    days: days,
    hours: hours,
    minutes: minutes,
    seconds: seconds,
  );

  bool get isComplete =>
      days == 0 && hours == 0 && minutes == 0 && seconds == 0;
}

/// Label tracking 0.2em at 12px — not on the type scale.
const _countdownLabelLetterSpacing = 2.4;

class SfCountdownTimer extends StatefulWidget {
  const SfCountdownTimer({
    super.key,
    this.state,
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.targetDate,
    this.running,
    this.onComplete,
  });

  /// Figma display preset; overrides manual values when set.
  final SfCountdownTimerState? state;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final DateTime? targetDate;
  final bool? running;
  final VoidCallback? onComplete;

  @override
  State<SfCountdownTimer> createState() => _SfCountdownTimerState();
}

class _SfCountdownTimerState extends State<SfCountdownTimer> {
  static const _statePresets = {
    SfCountdownTimerState.defaultState: SfCountdownTime(
      days: 2,
      hours: 10,
      minutes: 45,
      seconds: 5,
    ),
  };

  /// Figma frame width — not on the size scale.
  static const shellWidth = 375.0;

  /// Max shell width — not on the size scale.
  static const shellMaxWidth = 430.0;

  /// min-w-14 (56px) — not on the size scale.
  static const unitMinWidth = 56.0;

  late SfCountdownTime _liveTime;
  Timer? _timer;
  bool _hasCompleted = false;

  SfCountdownTime get _staticTime => _resolveStaticTime();

  bool get _isRunning =>
      widget.running ?? (widget.targetDate != null || widget.state == null);

  @override
  void initState() {
    super.initState();
    _liveTime = _staticTime;
    _syncTimer();
  }

  @override
  void didUpdateWidget(SfCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state ||
        oldWidget.days != widget.days ||
        oldWidget.hours != widget.hours ||
        oldWidget.minutes != widget.minutes ||
        oldWidget.seconds != widget.seconds ||
        oldWidget.targetDate != widget.targetDate ||
        oldWidget.running != widget.running) {
      _hasCompleted = false;
      if (!_isRunning) {
        _liveTime = _staticTime;
      }
      _syncTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  SfCountdownTime _resolveStaticTime() {
    final preset = widget.state;
    if (preset != null && _statePresets.containsKey(preset)) {
      return _statePresets[preset]!;
    }

    return SfCountdownTime(
      days: _clampSegment(widget.days),
      hours: _clampSegment(widget.hours),
      minutes: _clampSegment(widget.minutes),
      seconds: _clampSegment(widget.seconds),
    );
  }

  int _clampSegment(int value) => value < 0 ? 0 : value;

  void _syncTimer() {
    _timer?.cancel();
    _timer = null;

    if (!_isRunning) {
      return;
    }

    final endTimestamp = widget.targetDate?.millisecondsSinceEpoch ??
        DateTime.now().millisecondsSinceEpoch + _staticTime.duration.inMilliseconds;

    void tick() {
      final remaining = Duration(
        milliseconds: endTimestamp - DateTime.now().millisecondsSinceEpoch,
      );
      final nextTime = SfCountdownTime.fromRemaining(remaining);

      if (!mounted) {
        return;
      }

      setState(() => _liveTime = nextTime);

      if (nextTime.isComplete && !_hasCompleted) {
        _hasCompleted = true;
        widget.onComplete?.call();
      }
    }

    tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => tick());
  }

  String _ariaLabel(SfCountdownTime time) {
    return '${time.days} days, ${time.hours} hours, ${time.minutes} minutes, and ${time.seconds} seconds remaining';
  }

  @override
  Widget build(BuildContext context) {
    final time = _isRunning ? _liveTime : _staticTime;

    return Semantics(
      label: _ariaLabel(time),
      liveRegion: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: shellMaxWidth,
          minWidth: shellWidth,
        ),
        child: SizedBox(
          width: shellWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.spacing4,
              vertical: AppSpacing.spacing2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var index = 0; index < _timeUnits.length; index++) ...[
                  if (index > 0) const _CountdownSeparator(),
                  Expanded(
                    child: _CountdownUnit(
                      label: _timeUnits[index].label,
                      value: _formatSegment(time.valueAt(_timeUnits[index].key)),
                      minWidth: unitMinWidth,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _CountdownUnitKey { days, hours, minutes, seconds }

class _TimeUnitDefinition {
  const _TimeUnitDefinition({required this.key, required this.label});

  final _CountdownUnitKey key;
  final String label;
}

const _timeUnits = [
  _TimeUnitDefinition(key: _CountdownUnitKey.days, label: 'DAYS'),
  _TimeUnitDefinition(key: _CountdownUnitKey.hours, label: 'HOURS'),
  _TimeUnitDefinition(key: _CountdownUnitKey.minutes, label: 'MINS'),
  _TimeUnitDefinition(key: _CountdownUnitKey.seconds, label: 'SECS'),
];

extension on SfCountdownTime {
  int valueAt(_CountdownUnitKey key) {
    return switch (key) {
      _CountdownUnitKey.days => days,
      _CountdownUnitKey.hours => hours,
      _CountdownUnitKey.minutes => minutes,
      _CountdownUnitKey.seconds => seconds,
    };
  }
}

String _formatSegment(int value) {
  return value.clamp(0, 99).toString().padLeft(2, '0');
}

class _CountdownUnit extends StatelessWidget {
  const _CountdownUnit({
    required this.label,
    required this.value,
    required this.minWidth,
  });

  final String label;
  final String value;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        minHeight: AppSpacing.spacing20,
        maxHeight: AppSpacing.spacing20,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.neutral50,
          borderRadius: BorderRadius.circular(AppRadius.radius2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacing1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                textAlign: TextAlign.center,
                style: AppTypography.textXxl
                    .bold(color: AppColors.neutral800)
                    .copyWith(
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
              ),
              const SizedBox(height: AppSpacing.spacing1),
              Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.textXs
                    .regular(color: AppColors.neutral800)
                    .copyWith(
                      letterSpacing: _countdownLabelLetterSpacing,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownSeparator extends StatelessWidget {
  const _CountdownSeparator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSpacing.spacing5,
      height: AppSpacing.spacing20,
      child: Center(
        child: SizedBox(
          width: AppSpacing.spacing1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _CountdownDot(),
              SizedBox(height: AppSpacing.spacing1),
              _CountdownDot(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountdownDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.spacing1,
      height: AppSpacing.spacing1,
      decoration: BoxDecoration(
        color: AppColors.neutral400,
        borderRadius: BorderRadius.circular(AppRadius.radius2),
      ),
    );
  }
}

/// Static display for Widgetbook variants that show fixed time values.
class SfCountdownTimerDisplay extends StatelessWidget {
  const SfCountdownTimerDisplay({
    super.key,
    required this.duration,
  });

  final SfCountdownTime duration;

  @override
  Widget build(BuildContext context) {
    return SfCountdownTimer(
      days: duration.days,
      hours: duration.hours,
      minutes: duration.minutes,
      seconds: duration.seconds,
      running: false,
    );
  }
}
