import 'dart:convert';
import 'dart:convert';

import 'package:finalpdf/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:open_file/open_file.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class SmartPDF extends StatelessWidget {
  const SmartPDF({super.key});

  @override
  Widget build(BuildContext context) {
    // double c_width = MediaQuery.of(context).size.width*0.3;
    return Container(
      // width: c_width,
      margin: const EdgeInsets.fromLTRB(30, 80, 30, 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "Smart ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: domTxtColor,
                            fontSize: 24),
                      ),
                      Text(
                        "PDF",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: domTxtColor,
                            fontSize: 24),
                      ),
                      Text(
                        "Converter",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: domTxtColor,
                            fontSize: 24),
                      ),
                      Text(
                        'The ultimate PDF to text tool for you device',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        softWrap: false,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: upperText,
                            fontSize: 14),
                      )
                    ],
                    //
                  ),
                )
              ],
            ),
          ),
          SizedBox(
              width: 160, child: Image.asset("images/Scene Wireframe.png")),
        ],
      ),
    );
  }
  // @override
  // Widget build(BuildContext context){}
}

class Oofs extends StatelessWidget {
  const Oofs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      alignment: Alignment.center,
      width: 160,
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Image.asset('images/Asset 100.png'),
          ),
          const SizedBox(
              child: Text(
            'Oops There are no converted files',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300, fontSize: 15, color: upperText),
          )),
        ],
      ),
    );
  }
}


class PdfT extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const PdfT({
    Key? key,
    required this.files,
    required this.onOpenedFile}) : super(key: key);

  @override
  State<PdfT> createState() => _PdfTState();
}

class _PdfTState extends State<PdfT> {
  @override
  Widget build(BuildContext context) 
    => Scaffold(
      appBar: AppBar(
        title: const Text('PDF to txt page',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), ),
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(icon:  const Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context);
          },)
        ],
      ),
      body: Center(
        child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6), 
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          final file = widget.files[index];
          return buildFile(file);
        },),
      ),
      bottomNavigationBar: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: const RoundedRectangleBorder(
                  ),
                  minimumSize: const Size(220, 80),
                ),
                child: const Text(
                  'Convert to Text',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                   showPrintedMessage(String title, String msg){
                    Flushbar(
                      title: title,
                      message: msg,
                      duration: const Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      icon: const Icon(Icons.info, color: primaryColor)
                    ).show(context);
                }
                  showPrintedMessage('Text file Created Successfully', 'Saved to Download Folder');
                  // Future <File> help(Platform file) async{
                  //   final appStorage = File('/storage/emulated/0/Download/');
                  //   final newFile = File('${appStorage.path}/${file}');
                  //   PdfTextExtractor extractor = PdfTextExtractor(newFile);
                  //   return newFile;
                  //  }
                },
              ),
            ),
    );

    Widget buildFile(PlatformFile file){
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB': '${kb.toStringAsFixed(2)} KB';
      final extension = file.extension ?? 'none';
      const color = primaryColor;

      return InkWell(
        onTap: () => widget.onOpenedFile(file),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '.$extension',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 8,),
                Text(
                  file.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis
                  ,),
                  Text(
                    fileSize,
                    style: TextStyle(fontSize: 16),
                  )
            ],
          ),
        ),
      );
    }
  }

  class PdfTT extends StatefulWidget {
  final List<PlatformFile> files;
  final ValueChanged<PlatformFile> onOpenedFile;
  const PdfTT({
    Key? key,
    required this.files,
    required this.onOpenedFile}) : super(key: key);

  @override
  State<PdfT> createState() => _PdfTState();
}

class _PdfTTState extends State<PdfTT> {
  @override
  Widget build(BuildContext context) 
    => Scaffold(
      appBar: AppBar(
        title: const Text('TXT to PDF page',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), ),
        backgroundColor: primaryColor,
        actions: <Widget>[
          IconButton(icon:  const Icon(Icons.navigate_before),
          onPressed: (){
            Navigator.pop(context);
          },)
        ],
      ),
      body: Center(
        child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6), 
        itemCount: widget.files.length,
        itemBuilder: (context, index) {
          final file = widget.files[index];
          return buildFile(file);
        },),
      ),
      bottomNavigationBar: SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: const RoundedRectangleBorder(
                  ),
                  minimumSize: const Size(220, 80),
                ),
                child: const Text(
                  'Convert to PDF',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                   showPrintedMessage(String title, String msg){
                    Flushbar(
                      title: title,
                      message: msg,
                      duration: const Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      icon: const Icon(Icons.info, color: primaryColor)
                    ).show(context);
                }
                  showPrintedMessage('Pdf file created Successfully', 'Saved to Download Folder');
                  // Future <File> help(Platform file) async{
                  //   final appStorage = File('/storage/emulated/0/Download/');
                  //   final newFile = File('${appStorage.path}/${file}');
                  //   PdfTextExtractor extractor = PdfTextExtractor(newFile);
                  //   return newFile;
                  //  }
                },
              ),
            ),
    );

    Widget buildFile(PlatformFile file){
      final kb = file.size / 1024;
      final mb = kb / 1024;
      final fileSize =
        mb >= 1 ? '${mb.toStringAsFixed(2)} MB': '${kb.toStringAsFixed(2)} KB';
      final extension = file.extension ?? 'none';
      const color = primaryColor;

      return InkWell(
        onTap: () => widget.onOpenedFile(file),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '.$extension',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                ),
                const SizedBox(height: 8,),
                Text(
                  file.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis
                  ,),
                  Text(
                    fileSize,
                    style: TextStyle(fontSize: 16),
                  )
            ],
          ),
        ),
      );
    }
  }


class Buton extends StatefulWidget {
  const Buton({super.key});

  @override
  State<Buton> createState() => _ButonState();
}

class _ButonState extends State<Buton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      alignment: Alignment.center,
      // width: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: buttonColor,
                  // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  // foregroundColor: txtColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: const Size(220, 80),
                ),
                child: const Text(
                  'PDF to TXT',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onPressed: () async{
                  await _createPDF();
                }, //Backend
              ),
            ),
            SizedBox(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  // padding: const EdgeInsets.all(20),
                  // foregroundColor: txtColor,
                  minimumSize: const Size(220, 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'TXT to PDF',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _createTxt(),
              ),
            ),
          ]),
    );
  }

  Future<void> _createPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['pdf']
  );
  if (result != null) {
    PlatformFile file = await result.files.first;

    print(file.name);
    print(file.bytes);
    print(file.size);
    print(file.extension);
    print(file.path);

    final newFile = await saveFilePermanently(file);
    final output = await _createFile();
    // openFiles(result.files);

    print('From path : ${file.path}');
    print('to path : ${newFile.path}');
    openFiles(result.files);
    File(newFile.path).copy(output.toString());
  } else {
    print('User canceled the picker');
  }
}
void openFiles(List<PlatformFile> files){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => PdfT(
      files: files,
      onOpenedFile: openFile,
                  ),
                  ));
}

void openFile(PlatformFile file){
  OpenFile.open(file.path);
}

Future <File> saveFilePermanently(PlatformFile file) async{
  final appStorage = await File('/storage/emulated/0/Download/');
  final newFile = File('${appStorage.path}/${file.name}');
  return File(file.path !).copy(newFile.path);
}

Future<File> _createFile() async {
  File file = await File('/storage/emulated/0/Download//output.txt');
  return await file;
}


  Future<void> _createTxt() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['txt']
  );
  if (result != null) {
    PlatformFile file = result.files.first;

    print(file.name);
    print(file.bytes);
    print(file.size);
    print(file.extension);
    print(file.path);

    final newFile = await saveFilePermanently(file);
    final output = await _createFile();
    // openFiles(result.files);

    print('From path : ${file.path}');
    print('to path : ${newFile.path}');
    openFiles(result.files);
    // File(newFile.readAsString() as String).copy(output.readAsStringSync());
  } else {
    // User canceled the picker
  }
}
void openTxt(List<PlatformFile> files){
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => PdfTT(
      files: files,
      onOpenedFile: openFile,
                  ),
                  ));
}

void openTxts(PlatformFile file){
  OpenFile.open(file.path);
}

Future <File> saveFilePermanentlys(PlatformFile file) async{
  final appStorage = File('/storage/emulated/0/Download/');
  final newFile = File('${appStorage.path}/${file.name}');
  return File(file.path !).copy(newFile.path);
}



}

class SaveFile {
  static Future<void> saveAndLaunchFile(
      String text, String fileName) async {
    //Get external storage directory
    final directory = File('/storage/emulated/0/Download/');

    //Get directory path
    String path = directory.path;

    //Create an empty file to write PDF data
    File file = File('$path/$fileName');

    //Write PDF data
    await file.writeAsString(text, flush: true);
    
    //Open the PDF document in mobile
    OpenFile.open('$path/$fileName');
  }
}
