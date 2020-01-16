import "package:flutter_test/flutter_test.dart";
import "package:file_uploading_demo/file_uploader.dart";

void main() {
  FileUploader uploader;

  setUp(() {
    uploader = FileUploader();
  });

  test("should upload between 1..5 seconds", () async {
    var stopwatch = Stopwatch();
    stopwatch.start();
    await uploader.fetchFile("some file");
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds < 6000, true);
  });

  test("it should fetch multiple files concurrently", () async {
    var stopwatch = Stopwatch();
    var names = ["one", "two", "three"];
    stopwatch.start();
    var files = await uploader.fetch(names);
    stopwatch.stop();
    expect(stopwatch.elapsedMilliseconds < 6000, true);
    expect(names.length, files.length);
  });
}
