import "dart:math";
import "dart:typed_data";
import "./file.dart";

class FileUploader {
  Future<File> fetchFile(String fileName) {
    var rnd = Random();
    var delay = rnd.nextInt(4) + 1;
    return Future.delayed(Duration(seconds: delay), () {
      return File(fileName, Uint8List(rnd.nextInt(255)));
    });
  }

  Future<List<File>> fetch(List<String> names) {
    return Future.wait(names.map((String name) {
      return fetchFile(name);
    }));
  }
}
