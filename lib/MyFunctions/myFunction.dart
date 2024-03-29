import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:zit_admin_screens/constant.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class MyFunctions {
Future<http.MultipartFile?> pickAndConvertToMultipartFile() async {
  Uint8List? imageFile;

  try {
    // Access the static method directly from the class
    imageFile = await ImagePickerWeb.getImageAsBytes();
  } catch (e) {
    print('Error while picking image: $e');
    return null;
  }

  if (imageFile == null) {
    return null;
  }

  final imageBytes = http.ByteStream.fromBytes(imageFile);
  final imageLength = imageFile.length;
  const imageFilename = 'Image.png';

  print('Image size: ${imageLength} bytes');
  return http.MultipartFile(
    'Image',
    imageBytes,
    imageLength,
    filename: imageFilename,
    contentType: MediaType('image', 'png'),
  );
}

  noImageField(
    context,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("خطأ"),
              content: const Text("حقل الصورة مطلوب"),
              actions: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Pcolor),
                    child: const Text(
                      "إغلاق",
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ]);
        });
  }
}
