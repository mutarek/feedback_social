import 'package:als_frontend/provider/watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class CustomProgressBar extends StatefulWidget {

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();
}

class _CustomProgressBarState extends State<CustomProgressBar> {

  @override
  void initState() {
    Provider.of<WatchProvider>(context, listen: false).customProgress();
   super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,
        body: Consumer<WatchProvider>(
          builder: (context, provider, child) {
            return Center(
              child: SizedBox(
                width: 300,
                child: Center(
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                            showLabels: false,
                            showTicks: false,
                            startAngle: 270,
                            endAngle: 270,
                            minimum: 0,
                            maximum: 100,
                            radiusFactor: 0.85,
                            axisLineStyle: const AxisLineStyle(
                                color: Color.fromRGBO(106, 110, 246, 0.2),
                                thicknessUnit: GaugeSizeUnit.factor,
                                thickness: 0.1),
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                  angle: 0,
                                  positionFactor: 0.25,
                                  widget: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Loading${provider.annotationValue}',
                                          style: const TextStyle(
                                              fontFamily: 'Times',
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                  value: provider.pointerValue,
                                  cornerStyle: CornerStyle.bothCurve,
                                  enableAnimation: true,
                                  animationDuration: 1200,
                                  animationType: AnimationType.ease,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFF6A6EF6),
                                  width: 0.1),
                            ]),
                      ],
                    )),
              ),
            );
          }
        ));
  }
}
