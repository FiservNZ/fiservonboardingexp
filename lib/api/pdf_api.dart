import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();

    pdf.addPage(
      Page(
        build: (context) => Center(
          child: Text(text, style: const TextStyle(fontSize: 48)),
        ),
      ),
    );

    return saveToTemporaryFile(pdf);
  }

  static Future<File> saveToTemporaryFile(Document pdf) async {
    User? user = FirebaseAuth.instance.currentUser;

    final uniqueFileName =
        '${DateTime.now().millisecondsSinceEpoch}_${user!.email?.split('@')[0]}';
    final storageRef = firebase_storage.FirebaseStorage.instance.ref();
    final folderRef = storageRef.child('${user.email?.split('@')[0]}/');
    final pdfRef = folderRef.child(uniqueFileName);

    final bytes = await pdf.save();

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/${user.email?.split('@')[0]}.pdf');

    await file.writeAsBytes(bytes);
    await pdfRef.putFile(file);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
