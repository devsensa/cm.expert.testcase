import "dart:math";
import "dart:typed_data";
import "./file.dart";
import "./uploading_process.dart";

class FileUploader {
  Future<UploadingProcess> fetchFile(UploadingProcess process) {
    var rnd = Random();
    var delay = rnd.nextInt(4) + 1;
    return Future.delayed(Duration(seconds: delay), () {
      var file = File(process.fileName, Uint8List(rnd.nextInt(255)));
      process.completeWithFile(file);
      return process;
    });
  }

  Future<List<UploadingProcess>> fetch(List<UploadingProcess> processes) {
    return Future.wait(processes.map((UploadingProcess process) => fetchFile(process)));
  }
}
