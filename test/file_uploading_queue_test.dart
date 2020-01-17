import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:file_uploading_demo/file_uploading_queue.dart';
import 'package:file_uploading_demo/file_uploader.dart';

void main() {
  FileUploadingQueue queue;
  FileUploader uploader;
  setUp(() {
    uploader = FileUploader();
    queue = FileUploadingQueue(uploader,
        fileAddLimit: 5, concurrentUploadingLimit: 3);
  });

  test("should have default limits", () {
    var defaultQueue = FileUploadingQueue(uploader);
    expect(defaultQueue.fileAddLimit, 30);
    expect(defaultQueue.concurrentUploadingLimit, 3);
  });

  test("should have user defined limits", () {
    expect(queue.fileAddLimit, 5);
    expect(queue.concurrentUploadingLimit, 3);
  });

  test("should add while not reach add limit", () async {
    var files = ["1", "2", "3", "4", "5"];
    await Future.wait(files.map((String file) => queue.add(file)));
    expect(queue.processes.length, 5);
  });

  test("should throw exception when rich add limit", () async {
    var files = ["1", "2", "3", "4", "5"];
    await Future.wait(files.map((String file) => queue.add(file)));
    expect(queue.add("6"), throwsA(isInstanceOf<Exception>()));
  });

  test("should remove all processes", () async {
    queue..add("1")..add("2")..add("3");
    expect(queue.processes.length, 3);
    await queue.cancel();
    expect(queue.processes.length, 0);
  });

  test("should perform uploading", () async {
    await queue.add("1");
    expect(queue.uploading, true);
    expect(queue.hasUploadingTask, true);
    await queue.add("2");
    await queue.add('3');
    expect(queue.uploadingState.filesInProcessCount, 3);
    await Future.delayed(Duration(seconds: 11), () {});
    expect(queue.uploadingState.filesInProcessCount, 0);
  });
}
