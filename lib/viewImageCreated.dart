import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ViewImage extends StatefulWidget {
  final path;
  var index;
  final Image imageFil1;
  List<dynamic> savedImages;
  ViewImage({super.key, required this.index,required this.imageFil1,required this.savedImages,required this.path});

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  showSnackBar(snackBar){
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title:const  Text(
             "see your image",
            style: TextStyle(
                fontFamily: "Comfortaa"
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await GallerySaver.saveImage(widget.path);
                const snackBar = SnackBar(
                  content: Text('Image Saved to gallery'),
                );
                showSnackBar(snackBar);
              },
              icon:const Icon(Icons.download,color:Colors.white)
            )
          ],
        ),
        body: widget.imageFil1
    );
  }
}

