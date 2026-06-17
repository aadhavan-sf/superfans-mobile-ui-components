import 'package:flutter/material.dart';

import '../../foundation/app_colors.dart';
import '../../foundation/type_scale_preview.dart';
import '../../preview/molecule_preview.dart';
import 'sf_countdown_timer.dart';

class CountdownTimerPlaygroundPage extends StatefulWidget {
  const CountdownTimerPlaygroundPage({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.showDays,
  });

  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool showDays;

  @override
  State<CountdownTimerPlaygroundPage> createState() =>
      _CountdownTimerPlaygroundPageState();
}

class _CountdownTimerPlaygroundPageState
    extends State<CountdownTimerPlaygroundPage> {
  late DateTime _target;
  int _restartToken = 0;
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    _target = _buildTarget();
  }

  @override
  void didUpdateWidget(CountdownTimerPlaygroundPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.days != oldWidget.days ||
        widget.hours != oldWidget.hours ||
        widget.minutes != oldWidget.minutes ||
        widget.seconds != oldWidget.seconds) {
      setState(() {
        _target = _buildTarget();
        _completed = false;
        _restartToken++;
      });
    }
  }

  DateTime _buildTarget() {
    return DateTime.now().add(
      Duration(
        days: widget.days,
        hours: widget.hours,
        minutes: widget.minutes,
        seconds: widget.seconds,
      ),
    );
  }

  void _restart() {
    setState(() {
      _target = _buildTarget();
      _completed = false;
      _restartToken++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MoleculePlaygroundScaffold(
      title: 'Countdown timer',
      subtitle: widget.showDays ? 'With days' : 'Hours, mins, secs only',
      specs: [
        'Days: ${widget.days}',
        'Hours: ${widget.hours}',
        'Minutes: ${widget.minutes}',
        'Seconds: ${widget.seconds}',
        'Show days: ${widget.showDays}',
        'Target: ${_target.toIso8601String()}',
      ],
      footer: Column(
        children: [
          if (_completed)
            Text(
              'Countdown complete',
              style: AppTypeScaleToken.textSm.style(
                AppTypeWeight.semibold,
                color: AppColors.brand600,
              ),
            ),
          TextButton(onPressed: _restart, child: const Text('Restart')),
        ],
      ),
      child: SfCountdownTimer(
        key: ValueKey(_restartToken),
        target: _target,
        showDays: widget.showDays,
        onComplete: () => setState(() => _completed = true),
      ),
    );
  }
}

class CountdownTimerVariantsPage extends StatelessWidget {
  const CountdownTimerVariantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sampleTarget = DateTime.now().add(
      const Duration(days: 2, hours: 10, minutes: 45, seconds: 5),
    );
    final shortTarget = DateTime.now().add(
      const Duration(hours: 1, minutes: 30, seconds: 15),
    );

    return MoleculeVariantsScaffold(
      title: 'Countdown timer',
      sections: [
        MoleculeSection(
          title: 'Live countdown',
          subtitle: 'Counts down every second until zero.',
          child: SfCountdownTimer(target: sampleTarget),
        ),
        MoleculeSection(
          title: 'Static display',
          subtitle: 'Fixed values for layout reference.',
          child: const SfCountdownTimerDisplay(
            duration: SfCountdownDuration(
              days: 2,
              hours: 10,
              minutes: 45,
              seconds: 5,
            ),
          ),
        ),
        MoleculeSection(
          title: 'Without days',
          child: SfCountdownTimer(
            target: shortTarget,
            showDays: false,
          ),
        ),
      ],
    );
  }
}
