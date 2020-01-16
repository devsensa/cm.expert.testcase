import "package:flutter_test/flutter_test.dart";
import "package:file_uploading_demo/file_uploader.dart";
import "package:file_uploading_demo/uploading_process.dart";
import "package:file_uploading_demo/file_lifecycle.dart";

void main() {
  FileUploader uploader;

  setUp(() {
    uploader = FileUploader();
  });

  test("should upload between 1..5 seconds", () async {
    var stopwatch = Stopwatch();
    stopwatch.start();
    await uploader.fetchFile(UploadingProcess("file.txt"));
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds < 6000, true);
  });

  test("it should fetch multiple completedProcesses concurrently", () async {
    var stopwatch = Stopwatch();
    var processes = [
      UploadingProcess("file1.txt"),
      UploadingProcess("file2.txt"),
      UploadingProcess("file3.txt")
    ];
    stopwatch.start();
    var completedProcesses = await uploader.fetch(processes);
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds < 6000, true);
    expect(processes.length, completedProcesses.length);
    completedProcesses.forEach((UploadingProcess process) {
      expect(process.status, FileLifecycle.uploaded);
    });
  });
}
