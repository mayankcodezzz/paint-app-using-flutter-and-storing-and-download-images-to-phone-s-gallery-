import 'dart:io';
import 'dart:typed_data';
import 'package:crayonant/savedimages.dart';
import 'package:painter/painter.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'colorpickerbutton.dart';

///shows the canvas for drawing
class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key}) : super(key: key);

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  PainterController _controller = _newController();
  bool _isClicked = false;
  List pathImage=[];
  @override
  void initState() {
    super.initState();
  }

  static PainterController _newController() {
    PainterController controller = PainterController();
    controller.thickness = 5.0;
    controller.backgroundColor = Colors.white;
    return controller;
  }

  void navigate(imageData) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: const Text('Image Saved !'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.memory(imageData!),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    actions = <Widget>[
      IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SavedImagesHomePage()));
          },
          icon: const Icon(Icons.grid_view_sharp)),
      IconButton(
          icon: const Icon(Icons.restart_alt_outlined),
          tooltip: 'Clear',
          onPressed: _controller.clear),
      IconButton(
          icon: const Icon(Icons.save),
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text("Save image"),
                content: const Text("Are you Sure to save this paint"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("Cancel"),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _show(_controller.finish(), context);
                      setState(() {
                        _controller = _newController();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      child: const Text("okay"),
                    ),
                  ),
                ],
              ),
            );
          }),
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          'Draw your Imagination',
          style: TextStyle(fontSize: 18, fontFamily: "Comfortaa"),
        ),
        actions: actions,
      ),
      body: SafeArea(
        child: Stack(children: [
          Painter(_controller),
          Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.grey]),
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isClicked = !_isClicked;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_up),
                            ),
                          ),
                        )
                      : Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.white, Colors.grey]),
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isClicked = !_isClicked;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: const Icon(
                                Icons.undo,
                              ),
                              tooltip: 'Undo',
                              onPressed: () {
                                if (_controller.isEmpty) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Text('Nothing to undo'));
                                } else {
                                  _controller.undo();
                                }
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: const Icon(
                                Icons.redo,
                              ),
                              tooltip: 'redo',
                              onPressed: () {
                                if (_controller.isEmpty) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Text('Nothing to redo'));
                                } else {
                                  _controller.undo();
                                }
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              onPressed: () {
                                final snackBar = SnackBar(
                                  content: StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
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
                                  }),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              },
                              icon:
                                  const Icon(Icons.stacked_line_chart_rounded)),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return RotatedBox(
                                quarterTurns: _controller.eraseMode ? 2 : 0,
                                child: IconButton(
                                    icon: const Icon(Icons.create),
                                    tooltip:
                                        '${_controller.eraseMode ? 'Disable' : 'Enable'} eraser',
                                    onPressed: () {
                                      setState(() {
                                        _controller.eraseMode =
                                            !_controller.eraseMode;
                                      });
                                    }));
                          }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: ColorPickerButton(_controller, false))
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: ColorPickerButton(_controller, true))
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),

                  ///circle
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: const Icon(
                                Icons.circle_outlined,
                              ),
                              tooltip: 'Undo',
                              onPressed: () {
                                if (_controller.isEmpty) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Text('Nothing to undo'));
                                } else {
                                  _controller.undo();
                                }
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),

                  ///rectangle
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: const Icon(
                                Icons.rectangle_outlined,
                              ),
                              tooltip: 'Undo',
                              onPressed: () {
                                if (_controller.isEmpty) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Text('Nothing to undo'));
                                } else {
                                  _controller.undo();
                                }
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),

                  ///line
                  _isClicked
                      ? Container(
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.white, Colors.grey]),
                              shape: BoxShape.circle),
                          child: IconButton(
                              icon: const Icon(
                                Icons.linear_scale_outlined,
                              ),
                              tooltip: 'Undo',
                              onPressed: () {
                                if (_controller.isEmpty) {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          const Text('Nothing to undo'));
                                } else {
                                  _controller.undo();
                                }
                              }),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 3,
                  ),
                ],
              )),
        ]),
      ),
    );
  }

  void _show(PictureDetails picture, BuildContext context) async {
    setState(() {});
    Uint8List? imageData;
    try {
      imageData = await picture.toPNG();
    } catch (e) {
      const snackBar = SnackBar(
        content: Text('looks something is cookin hot'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    if (imageData != null) {
      final String fileName =
          '${DateTime.now().toString().replaceAll(':', '-')}.png';
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDir.path}/$fileName';
      await File(filePath).writeAsBytes(imageData);
      pathImage.add(filePath);
      navigate(imageData);
    }
  }
}
