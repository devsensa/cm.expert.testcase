import "dart:async";
import "dart:collection";
import "./uploading_process.dart";
import "./file_lifecycle.dart";

class FileUploadingQueue {
  int _fileAddLimit;
  int _concurrentUploadingLimit;
  ListQueue<UploadingProcess> _queue = ListQueue(15);

  StreamController<bool> _emptyStream = StreamController.broadcast();
  StreamController<bool> _uploadingStream = StreamController.broadcast();
  StreamController<UploadingState> _uploadingStateStream =
      StreamController.broadcast();
  StreamController<bool> _canAddFileStream = StreamController.broadcast();
  StreamController<List<UploadingProcess>> _processesStream =
      StreamController.broadcast();

  FileUploadingQueue(
      {int fileAddLimit = 30, int concurrentUploadingLimit = 3}) {
    _fileAddLimit = fileAddLimit;
    _concurrentUploadingLimit = concurrentUploadingLimit;
    _emptyStream.add(false);
    _uploadingStream.add(false);
    _uploadingStateStream.add(UploadingState(0, 0));
    _canAddFileStream.add(true);
    _processesStream.add([]);
  }

/* --------------------------------- Getters -------------------------------- */
  int get fileAddLimit {
    return _fileAddLimit;
  }

  int get concurrentUploadingLimit {
    return _concurrentUploadingLimit;
  }

  Stream<bool> empty() {}
  Stream<bool> uploading() {}
  Stream<UploadingState> uploadingState() {}
  Stream<bool> canAddFile() {}
  Stream<List<UploadingProcess>> processes() {}

/* ------------------------------- Operations ------------------------------- */

  Future<void> cancel() async {
    _queue.clear();
    updateEmptyStream();
  }

  Future<void> save() async {
    return;
  }

  Future<void> add(String fileName) async {
    var process = UploadingProcess(fileName);
    _queue.add(process);
  }

  Future<void> delete(int hashCode) async {
    _queue.removeWhere(
        (UploadingProcess process) => process.hashCode == hashCode);
  }

/* ------------------------------ Util methods ------------------------------ */
  void updateEmptyStream() {
    _emptyStream.add(_queue.isEmpty);
  }

  void updateUploadingStream() {
    _uploadingStream.add(_queue.any((UploadingProcess process) =>
        process.status != FileLifecycle.uploaded));
  }

  void updateUploadingStateStream() {
    var allFiles = _queue.length;
    var inProcess = _queue
        .where((UploadingProcess process) =>
            process.status != FileLifecycle.uploaded)
        .length;
    _uploadingStateStream.add(UploadingState(inProcess, allFiles));
  }

  void updateCanAddFileStream() {
    _canAddFileStream.add(_queue.length < _fileAddLimit);
  }

  void updateProcessesStream() {
    _processesStream.add(_queue.toList(growable: false));
  }
}

class UploadingState {
  int filesInProcessCount;
  int allFilesCount;
  UploadingState(this.filesInProcessCount, this.allFilesCount);
}
