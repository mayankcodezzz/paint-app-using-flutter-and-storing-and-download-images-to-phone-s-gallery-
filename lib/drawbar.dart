import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'colorpickerbutton.dart';

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  const DrawBar(this._controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(child:
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Slider(
                secondaryActiveColor: Colors.black,
                value: _controller.thickness,
                onChanged: (double value) => setState(() {
                  _controller.thickness = value;
                }),
                min: 1.0,
                max: 20.0,
                activeColor: Colors.redAccent,
              );
            })),
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return RotatedBox(
                  quarterTurns: _controller.eraseMode ? 2 : 0,
                  child: IconButton(
                      icon: const Icon(Icons.create),
                      tooltip: '${_controller.eraseMode ? 'Disable' : 'Enable'} eraser',
                      onPressed: () {
                        setState(() {
                          _controller.eraseMode = !_controller.eraseMode;
                        });
                      }));
            }),
        ColorPickerButton(_controller, false),
        ColorPickerButton(_controller, true),
      ],
    );
  }
}