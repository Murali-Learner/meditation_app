import 'package:flutter/material.dart';
import 'package:meditation_app/count_provider.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;
import 'package:percent_indicator/circular_percent_indicator.dart';

class CountdownTimerPage extends StatelessWidget {
  const CountdownTimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Center(
        child: Consumer<CountdownTimerProvider>(
          builder: (context, timerProvider, child) {
            double percent = timerProvider.seconds /
                (CountdownTimerProvider.initialMinutes * 60);
            if (percent > 1.0) percent = 1.0;
            double angle = (1.0 - percent) * 2 * math.pi;

            double radius = 150.0;
            double indicatorRadius = radius - 18;
            double indicatorX = indicatorRadius * math.cos(angle);
            double indicatorY = indicatorRadius * math.sin(angle);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: radius,
                      lineWidth: 10.0,
                      percent: percent,
                      center: Text(
                          "${timerProvider.seconds ~/ 60} min ${timerProvider.seconds % 60} s"),
                      progressColor: Colors.blue,
                    ),
                    Positioned(
                      left: radius + indicatorX - 10,
                      top: radius + indicatorY - 10,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        timerProvider.decreaseTimer();
                      },
                    ),
                    IconButton(
                      icon: timerProvider.isPaused
                          ? const Icon(Icons.play_arrow)
                          : const Icon(Icons.pause),
                      onPressed: () {
                        if (timerProvider.isPaused) {
                          timerProvider.resumeTimer();
                        } else {
                          timerProvider.pauseTimer();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        timerProvider.increaseTimer();
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
