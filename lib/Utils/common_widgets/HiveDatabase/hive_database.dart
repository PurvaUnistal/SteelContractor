import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HiveDataBase {


Future<void> init() async {
  Directory tempDir = await getApplicationDocumentsDirectory();
  Directory filesDir = Directory(tempDir.path)..createSync(recursive: true);


}
}