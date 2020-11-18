import 'package:flutter/material.dart';
import 'package:mapa_app/custom_markers/custom_markers.dart';



class TestMarkerPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 150,
          color: Colors.red,
          child: CustomPaint(
            painter: MarkerInicioPainter(160),
            // painter: MarkerDestinoPainter(
            //   'Mi casa por algun lado del mundo, esta aquí, asdasdasdsd',
            //   25090
            // ),
          )
        ),
     ),
   );
  }
}