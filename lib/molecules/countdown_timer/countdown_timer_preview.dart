import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/app_spacing.dart';
import '../../foundation/type_scale_preview.dart';
import '../../preview/molecule_preview.dart';
import 'sf_countdown_timer.dart';

class CountdownTimerPlaygroundPage extends StatelessWidget {
  const CountdownTimerPlaygroundPage({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.running,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool running;

  @override
  Widget build(BuildContext context) {
    return MoleculePlaygroundScaffold(
      title: 'Countdown timer',
      subtitle: running ? 'Live countdown' : 'Static preview',
      footer: Text(
        running
            ? 'Counting down from ${_formatSummary()}'
            : 'Running is off — showing static values',
        style: AppTypeScaleToken.textSm.style(
          AppTypeWeight.regular,
          color: AppColors.neutral600,
        ),
      ),
      child: SfCountdownTimer(
        days: days,
        hours: hours,
        minutes: minutes,
        seconds: seconds,
        running: running,
      ),
    );
  }

  String _formatSummary() {
    return '${days}d ${hours}h ${minutes}m ${seconds}s';
  }
}

class CountdownTimerVariantsPage extends StatefulWidget {
  const CountdownTimerVariantsPage({super.key});

  @override
  State<CountdownTimerVariantsPage> createState() =>
      _CountdownTimerVariantsPageState();
}

class _CountdownTimerVariantsPageState extends State<CountdownTimerVariantsPage> {
  late final DateTime _liveTarget;

  @override
  void initState() {
    super.initState();
    _liveTarget = DateTime.now().add(const Duration(seconds: 90));
  }

  @override
  Widget build(BuildContext context) {
    return MoleculeVariantsScaffold(
      title: 'Countdown timer',
      sections: [
        MoleculeSection(
          title: 'Figma default',
          subtitle: 'Default Figma variant — 2d 10h 45m 05s.',
          child: const SfCountdownTimer(
            state: SfCountdownTimerState.defaultState,
            running: false,
          ),
        ),
        MoleculeSection(
          title: 'Live countdown',
          subtitle: 'Counts down live to a target 90 seconds from load.',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SfCountdownTimer(targetDate: _liveTarget),
              SizedBox(height: AppSpacing.spacing3),
              Text(
                'Target: ${_liveTarget.toLocal()}',
                style: AppTypeScaleToken.textSm.style(
                  AppTypeWeight.regular,
                  color: AppColors.neutral600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
