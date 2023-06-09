import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';
class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  const ColorPickerButton(this._controller, this._background, {super.key});

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(

        title: const Text('Select color'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                alignment: Alignment.center,
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (Color c) => pickerColor = c,
                )),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _color = pickerColor;
              });
              Navigator.pop(context, 'OK');},
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}