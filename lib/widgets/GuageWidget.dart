import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../color.dart';

class GuageWidget extends StatefulWidget {
  final String name;
  final int value;
  final int type;

  const GuageWidget(
      {super.key, required this.name, required this.value, required this.type});

  @override
  State<GuageWidget> createState() => _GuageWidgetState();
}

class _GuageWidgetState extends State<GuageWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(240, 64, 68, 75),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(color: col_grey, fontSize: 25),
                      textAlign: TextAlign.left,
                    ),
                    Text(widget.value.toString(),
                        style: const TextStyle(color: col_grey)),
                  ],
                ),
              ),
              Expanded(
                child: SfRadialGauge(
                  
                  axes: <RadialAxis>[
                  RadialAxis(minimum: 0, maximum: 180, ranges: <GaugeRange>[
                    GaugeRange(
                        startValue: 0, endValue: 60, color: Colors.green),
                    GaugeRange(
                        startValue: 60, endValue: 120, color: Colors.orange),
                    GaugeRange(
                        startValue: 120, endValue: 180, color: Colors.red)
                  ], 
                  
                  pointers: <GaugePointer>[
                    
                    NeedlePointer(
                      
                        value: widget.value.toDouble(), enableAnimation: true)
                  ], 
                  
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Text(widget.value.toString(),
                            style: TextStyle(
                                color: col_grey,
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        angle: 90,
                        positionFactor: 0.5)
                  ])
                ]),
              )
            ],
          )),
    );
  }
}
