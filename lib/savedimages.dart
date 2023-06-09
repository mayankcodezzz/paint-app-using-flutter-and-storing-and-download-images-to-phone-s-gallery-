import 'dart:io';
import 'package:crayonant/examplepage.dart';
import 'package:crayonant/viewImageCreated.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SavedImagesHomePage extends StatefulWidget {
  const SavedImagesHomePage({Key? key}) : super(key: key);

  @override
  State<SavedImagesHomePage> createState() => _SavedImagesHomePageState();
}

class _SavedImagesHomePageState extends State<SavedImagesHomePage> {
  List<File> savedImages = [];
  File? imageFile1;
  bool isSelected = false;
  List<bool> isImageLongTapped = [];

  @override
  void initState() {
    super.initState();
    loadSavedImages();
  }

  void navigate() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const ExamplePage()));
  }

  Future<void> loadSavedImages() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();
    savedImages = files.whereType<File>().toList();

    setState(() {
      isImageLongTapped = List<bool>.filled(savedImages.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {
          isSelected = false;
          for (int i = 0; i < savedImages.length; i++) {
            isImageLongTapped[i] = false;
          }
        });
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: const Text(
            "Crayonant",
            style: TextStyle(fontSize: 26, fontFamily: "merriweather"),
          ),
          actions: [
            !isSelected
                ? IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExamplePage()));
                    },
                    icon: const Icon(CupertinoIcons.plus))
                : IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Delete Image"),
                          content: const Text(
                              "Sure to Delete this trash made by you"),
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
                                for (int i = 0;
                                    i < isImageLongTapped.length;
                                    i++) {
                                  if (isImageLongTapped[i]) {
                                    final path = savedImages[i].path;
                                    File(path).delete();
                                    isSelected = !isSelected;
                                    navigate();
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                child: const Text("okay"),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.delete_solid))
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              crossAxisCount: 2,
            ),
            itemCount: savedImages.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < savedImages.length) {
                return Stack(
                  children: [
                    GestureDetector(
                        onLongPress: () {
                          setState(() {
                            isSelected = true;
                            for (int i = 0; i < savedImages.length; i++) {
                              if (i != index) {
                                setState(() {
                                  isImageLongTapped[i] = false;
                                });
                              } else {
                                setState(() {
                                  isImageLongTapped[index] = true;
                                });
                              }
                            }
                          });
                        },
                        onTap: () {
                          setState(() {
                            isSelected = false;

                          });
                          final path = savedImages[index].path;
                          List imagesList = savedImages;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewImage(
                                        index: index,
                                        imageFil1:
                                            Image.file(savedImages[index]),
                                        savedImages: imagesList,
                                        path: path,
                                      )));
                        },
                        child: !isSelected
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 2,
                                child: Container(
                                  margin: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      border: Border.all(
                                          color: Colors.black, width: 3)),
                                  child: Image.file(
                                    savedImages[index],
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            : AnimatedScale(
                                scale: 0.95,
                                curve: Curves.easeInOut,
                                duration: const Duration(seconds: 1),
                                child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Container(
                                      margin: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          border: Border.all(
                                              color: Colors.black, width: 3)),
                                      child: Image.file(
                                        savedImages[index],
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              )),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        child: isSelected
                            ? Checkbox(
                                checkColor: Colors.black,
                                activeColor: Colors.grey,
                                value: isImageLongTapped[index],
                                onChanged: (value) {
                                  setState(() {
                                    isImageLongTapped[index] = value!;
                                  });
                                },
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(); // Empty container if index is out of range
              }
            },
          ),
        ),
      ),
    );
  }
}
