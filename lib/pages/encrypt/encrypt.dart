import 'package:file_selector/file_selector.dart';
import 'package:finalpdf/widgets/constant.dart';
import 'package:finalpdf/widgets/header.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:flutter/services.dart';


class EncryptHeader extends StatelessWidget {
  const EncryptHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 80, 20, 0),
      child: Column(children: const <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Encrypting .... ",
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

class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  State<EncryptPage> createState() => _EncryptPageState();
}

class _EncryptPageState extends State<EncryptPage> {
  bool _isGranted = true;
  // final filename = FilePicker.platform.pickFiles();
  FilePickerResult? filename;
  // File filename = File(result.files.first);
  // final filename = filename;

  Future<Directory?> get getAppDir async{
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }
  Future<Directory> get getExternalVisibleDir async{
    if (await Directory('/storage/emulated/0/MyEncFolder').exists()) {
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }else{
      await Directory('/storage/emulated/0/MyEncFolder')
        .create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/MyEncFolder');
      return externalDir;
    }
  }
  requestStoragePErmission() async{
    if (!await Permission.storage.isGranted){
      PermissionStatus result = await Permission.storage.request();
      if (result.isGranted) {
        setState(() {
          _isGranted = true;
        });
      }else{
        _isGranted = false;
      }
    }
  }
  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 8;
    final double itemWidth = size.width / 1;
    return Scaffold(
       body: Container(
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 1,mainAxisSpacing: 10,crossAxisSpacing: 10,
          childAspectRatio: (itemWidth / itemHeight),
          children: [
          InkWell(
            onTap: () async{
                  filename = await FilePicker.platform.pickFiles(allowMultiple: true );
                    if (filename == null) {
                        print("No file selected");
                      } else {
                      setState(() {
                      });
                        filename?.files.forEach((element) {
                          print(element.name);
                        });
                        };
                  if (_isGranted){
                    Directory d = await getExternalVisibleDir;
                    _downloadAndCreate(d,filename);
                  }else{
                    print('No permission granted.');
                    requestStoragePErmission();
                  }
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: primaryColor,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
              Text("Encrypt",style: TextStyle(color: txtColor,fontSize: 22),),
              Icon(Icons.lock,size: 24,color: Colors.white,),
            ],),
            ),
          ),
         InkWell(
             onTap: () async {
              filename = await FilePicker.platform.pickFiles(allowMultiple: true );
                    if (filename == null) {
                        print("No file selected");
                      } else {
                      setState(() {
                      });
                        filename?.files.forEach((element) {
                          print(element.name);
                        });
                        };
              if (_isGranted){
                Directory d = await getExternalVisibleDir;
                _getNormalFile(d,filename);
              }else{
                print('No permission granted.');
                const AlertDialog(title: Text('No permission granted'),);
                requestStoragePErmission();
              }
                          },
           child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: buttonColor,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                Text("Decrypt",style: TextStyle(color: txtColor,fontSize: 22),),
              Icon(Icons.lock_open_outlined,size: 24,color: Colors.white,),
            ],),
            ),
         ),
          InkWell(
              onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SmartPDF()));
            },
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: primaryColor,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
              Text("password",style: TextStyle(color: txtColor,fontSize: 22),),
              Icon(Icons.password,size: 24,color: Colors.white,),
            ],),
            ),
          ),
        ],
        ),
      ),),
    );
  }
//   Future<void> _createPDF() async {
//     // _handlePermission();
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['pdf']
//   );
//   if (result != null) {
//     PlatformFile file = result.files.first;

//     print(file.name);
//     print(file.bytes);
//     print(file.size);
//     print(file.extension);
//     print(file.path);

//     final newFile = await saveFilePermanently(file);
//     // final output = await _createFile();
//     // openFiles(result.files);

//     print('From path : ${file.path}');
//     print('to path : ${newFile.path}');
//     openFiles(result.files);
//     // File(newFile.readAsString() as String).copy(output.readAsStringSync());
//   } else {
//     // User canceled the picker
//   }
// }
// void openFiles(List<PlatformFile> files){
//   Navigator.of(context).push(MaterialPageRoute(
//     builder: (context) => PdfT(
//       files: files,
//       onOpenedFile: openFile,
//                   ),
//                   ));
// }

// void openFile(PlatformFile file){
//   OpenFile.open(file.path);
// }

// Future <File> saveFilePermanently(PlatformFile file) async{
//   final appStorage = File('/storage/emulated/0/Download/');
//   final newFile = File('${appStorage.path}/${file.name}');
//   // final Uint8List data = newFile.readAsBytesSync();
//   // data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
//   // PdfTextExtractor extractor = PdfTextExtractor(SaveFile());
//   // newFile.writeAsBytesSync(List.from(await data));
//   return File(file.path !).copy(newFile.path);
// }
}

// class EncryptDta extends StatefulWidget {
//   const EncryptDta({super.key});

//   @override
//   State<EncryptDta> createState() => _EncryptDtaState();
// }

// class _EncryptDtaState extends State<EncryptDta> {
//   bool _isGranted = true;
//   // final filename = FilePicker.platform.pickFiles();
//   FilePickerResult? filename;
//   // File filename = File(result.files.first);
//   // final filename = filename;

//   Future<Directory?> get getAppDir async{
//     final appDocDir = await getExternalStorageDirectory();
//     return appDocDir;
//   }
//   Future<Directory> get getExternalVisibleDir async{
//     if (await Directory('/storage/emulated/0/MyEncFolder').exists()) {
//       final externalDir = Directory('/storage/emulated/0/MyEncFolder');
//       return externalDir;
//     }else{
//       await Directory('/storage/emulated/0/MyEncFolder')
//         .create(recursive: true);
//       final externalDir = Directory('/storage/emulated/0/MyEncFolder');
//       return externalDir;
//     }
//   }
//   requestStoragePErmission() async{
//     if (!await Permission.storage.isGranted){
//       PermissionStatus result = await Permission.storage.request();
//       if (result.isGranted) {
//         setState(() {
//           _isGranted = true;
//         });
//       }else{
//         _isGranted = false;
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     requestStoragePErmission();
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         title: Text('Encrypt File', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),),
//         ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Column(
            
//             mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: primaryColor,
//                   // padding: const EdgeInsets.all(20),
//                   // foregroundColor: txtColor,
//                   minimumSize: const Size(220, 80),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Text('Encrypt'),
//                 onPressed: () async{
//                   filename = await FilePicker.platform.pickFiles(allowMultiple: true );
//                     if (filename == null) {
//                         print("No file selected");
//                       } else {
//                       setState(() {
//                       });
//                         filename?.files.forEach((element) {
//                           print(element.name);
//                         });
//                         };
//                   if (_isGranted){
//                     Directory d = await getExternalVisibleDir;
//                     _downloadAndCreate(d,filename);
//                   }else{
//                     print('No permission granted.');
//                     requestStoragePErmission();
//                   }
//                 },),
//             ],
//           ),
//             ElevatedButton(
//             child: Text('Decrypt'),
//             onPressed: () async{
//               if (_isGranted){
//                 Directory d = await getExternalVisibleDir;
//                 _getNormalFile(d,filename);
//               }else{
//                 print('No permission granted.');
//                 AlertDialog(title: Text('No permission granted'),);
//                 requestStoragePErmission();
//               }
//             },)
//       ]),
//     );
//   }
// }
_downloadAndCreate(Directory d, filename) async{
  var encResult = _encryptData(filename.bodyBytes);
  String P = await _writeData(encResult, d.path + '/$filename');
  print('file encrypted succesfully');
  }

_getNormalFile(Directory d, filename) async{
  Uint8List encData = await _readData(d.path +'/$filename.aes');
  var encResult = await _decryptData(encData);
  String P = await _writeData(encResult, d.path + '/$filename');
  print('file encrypted succesfully $P');

}

_encryptData(plainString){
  print('Encrypting File...');
  final encrypted = MyEncrypt.myEncrypter.encryptBytes(plainString, iv: MyEncrypt.myIv);
  return encrypted.bytes;
}

_decryptData(encData){
  print('Decrypting File...');
  enc.Encrypted en = new enc.Encrypted(encData);
  return MyEncrypt.myEncrypter.decryptBytes(en, iv: MyEncrypt.myIv);
}

Future<Uint8List> _readData(fileNameWithPath) async {
  print("Reading data...");
  File f = File(fileNameWithPath);
  return await f.readAsBytes();
}

Future<String> _writeData(dataToWrite, fileNameWithPath) async {
  print("Writting Data...");
  File f = File(fileNameWithPath);
  await f.writeAsBytes(dataToWrite);
  return f.absolute.toString();
}

class MyEncrypt {
  static final myKey = enc.Key.fromUtf8('JohnnyRocks');
  static final myIv = enc.IV.fromUtf8("StormAES");
  static final myEncrypter = enc.Encrypter(enc.AES(myKey));
}


// class Encrypt extends StatefulWidget {
//   final List<PlatformFile> files;
//   final ValueChanged<PlatformFile> onOpenedFile;
//   const Encrypt({
//     Key? key,
//     required this.files,
//     required this.onOpenedFile}) : super(key: key);

//   @override
//   State<Encrypt> createState() => _EncryptState();
// }

// class _EncryptState extends State<Encrypt> {
//   @override
//   Widget build(BuildContext context) 
//     => Scaffold(
//       appBar: AppBar(
//         title: const Text('PDF to txt page',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), ),
//         backgroundColor: primaryColor,
//         actions: <Widget>[
//           IconButton(icon:  const Icon(Icons.navigate_before),
//           onPressed: (){
//             Navigator.pop(context);
//           },)
//         ],
//       ),
//       body: Center(
//         child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 6,
//           crossAxisSpacing: 6), 
//         itemCount: widget.files.length,
//         itemBuilder: (context, index) {
//           final file = widget.files[index];
//           return buildFile(file);
//         },),
//       ),
//       bottomNavigationBar: SizedBox(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: buttonColor,
//                   shape: const RoundedRectangleBorder(
//                   ),
//                   minimumSize: const Size(220, 80),
//                 ),
//                 child: const Text(
//                   'Convert to Text',
//                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 ),
//                 onPressed: (){
//                    showPrintedMessage(String title, String msg){
//                     Flushbar(
//                       title: title,
//                       message: msg,
//                       duration: const Duration(seconds: 2),
//                       flushbarPosition: FlushbarPosition.TOP,
//                       icon: const Icon(Icons.info, color: primaryColor)
//                     ).show(context);
//                 }
//                   showPrintedMessage('Text file Created Successfully', 'Saved to Download Folder');
//                   // Future <File> help(Platform file) async{
//                   //   final appStorage = File('/storage/emulated/0/Download/');
//                   //   final newFile = File('${appStorage.path}/${file}');
//                   //   EncryptextExtractor extractor = EncryptextExtractor(newFile);
//                   //   return newFile;
//                   //  }
//                 },
//               ),
//             ),
//     );

//     Widget buildFile(PlatformFile file){
//       final kb = file.size / 1024;
//       final mb = kb / 1024;
//       final fileSize =
//         mb >= 1 ? '${mb.toStringAsFixed(2)} MB': '${kb.toStringAsFixed(2)} KB';
//       final extension = file.extension ?? 'none';
//       const color = primaryColor;

//       return InkWell(
//         onTap: () => widget.onOpenedFile(file),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: color,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     '.$extension',
//                     style: const TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 ),
//                 const SizedBox(height: 8,),
//                 Text(
//                   file.name,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   overflow: TextOverflow.ellipsis
//                   ,),
//                   Text(
//                     fileSize,
//                     style: TextStyle(fontSize: 16),
//                   )
//             ],
//           ),
//         ),
//       );
//     }
//   }