import 'package:finalpdf/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:path_provider/path_provider.dart';

class ConvertPage extends StatelessWidget {
  const ConvertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 80, 20, 40),
      child: Column(children: const <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Converting .... ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: headerColor,
              fontSize: 30,
            ),
          ),
        ),
        Divider(
          color: lineColor,
          height: 50,
          thickness: 2,
        )
      ]),
    );
  }
}
class Conv extends StatefulWidget{
  ConvertImage createState()=> ConvertImage();
}

class ConvertImage extends State<Conv> {
  // const ConvertImage({super.key});
  final picker = ImagePicker();
  final pdf = pw.Document();
  late File _image;
  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      alignment: Alignment.center,
      // width: 160,
      child: Column(
        children: <Widget>[
         SizedBox(
            width: 160,
            child: Image.asset('images/sett.png'),
          ),
          const SizedBox(
            child: Text(
              'Oops There are no converted files',
              textAlign: TextAlign.center,
              textWidthBasis: TextWidthBasis.parent,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15,
                color: upperText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class Con extends StatefulWidget{
  ConvertFile createState()=> ConvertFile();
}

class ConvertFile extends State<Con> {
//   // const ConvertFile({super.key});
  final picker = ImagePicker();
  final pdf = pw.Document();
  late File _image;

  getImageFromGallery()async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState((){
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
}
createPDF() async{
  final image = pw.MemoryImage(_image.readAsBytesSync());
  pdf.addPage(pw.Page(pageFormat : PdfPageFormat.a4, build: (pw.Context contex){
    return pw.Center(child: pw.Image(image));
  }));
}
savePDF()async{
  try {
    final dir = await getExternalStorageDirectory();
    final file = File('/storage/emulated/0/Download/filename.pdf');
    await file.writeAsBytes(await pdf.save());
    showPrintedMessage('Sucess', 'Saved to Downloads');
  } catch (e) {
    print('hey');
    showPrintedMessage('error', e.toString());
  }
}
 showPrintedMessage(String title, String msg){
    Flushbar(
      title: title,
      message: msg,
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(Icons.info, color: primaryColor)
    )..show(context);
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      alignment: Alignment.center,
      // width: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Divider(
              color: lineColor,
              height: 10,
              thickness: 2,
          ),
            SizedBox(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // foregroundColor: txtColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(280, 70),
                ),
                icon: const Text(
                  'Select Image File  ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                label: Icon(Icons.insert_drive_file_outlined),
                onPressed: () => getImageFromGallery(),//Backend
              ),
            ),
            SizedBox(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // foregroundColor: txtColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(280, 70),
                ),
                icon: const Text(
                  'Convert File  ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                label: Icon(Icons.file_open_outlined),
                onPressed: () {
                  createPDF(); savePDF();
                },//Backend
              ),
            ),
          ]),
    );
  }
}

