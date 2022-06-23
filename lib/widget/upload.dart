import 'dart:async';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class UploadProgress extends StatefulWidget {
  final Function progress;
  final bool requestBack;

  const UploadProgress({Key? key, required this.progress, this.requestBack = false}) : super(key: key);

  @override
  _UploadProgressState createState() => _UploadProgressState();
}

class _UploadProgressState extends State<UploadProgress> {
  Timer? timers;
  @override
  void initState() {
    super.initState();
    timers = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      print(widget.progress());
      final value = widget.progress();
      if (value == 100) {
        timer.cancel();
        Timer(const Duration(seconds: 1), () {
          Navigator.of(context).pop();
          if (widget.requestBack) {
            Navigator.of(context).pop();
          }
        });
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (timers != null) timers!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.progress();
    return Center(
      child: Material(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfRadialGauge(animationDuration: 1000, axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  startAngle: 270,
                  endAngle: 270,
                  showLabels: false,
                  showTicks: false,
                  radiusFactor: 0.75,
                  axisLineStyle: AxisLineStyle(
                    thickness: 0.1,
                    color: Theme.of(context).backgroundColor,
                    thicknessUnit: GaugeSizeUnit.factor,
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: (1.0 * value),
                      color: Theme.of(context).primaryColor,
                      width: 0.1,
                      sizeUnit: GaugeSizeUnit.factor,
                      enableAnimation: true,
                      animationDuration: 600,
                      animationType: AnimationType.linear,
                    ),
                  ],
                )
              ]),
              const Text(
                'Proses unggah...',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
