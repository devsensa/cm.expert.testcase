import "dart:async";
import "dart:collection";

import "package:property_change_notifier/property_change_notifier.dart";
import "./uploading_process.dart";
import "./file_lifecycle.dart";
import "./file_uploader.dart";

class FileUploadingQueue extends PropertyChangeNotifier<String> {
  int _fileAddLimit;
  int _concurrentUploadingLimit;
  ListQueue<UploadingProcess> _queue = ListQueue(15);
  FileUploader _uploader;
  Future<List<UploadingProcess>> _uploadingFuture;

  FileUploadingQueue(this._uploader,
      {int fileAddLimit = 30, int concurrentUploadingLimit = 3})
      : _fileAddLimit = fileAddLimit,
        _concurrentUploadingLimit = concurrentUploadingLimit;

/* --------------------------------- Getters -------------------------------- */
  int get fileAddLimit {
    return _fileAddLimit;
  }

  int get concurrentUploadingLimit {
    return _concurrentUploadingLimit;
  }

  bool get hasUploadingTask => _uploadingFuture != null;

  bool get empty => _queue.isEmpty;
  bool get uploading => _queue.any(
      (UploadingProcess process) => process.status != FileLifecycle.uploaded);
  int get length => _queue.length;
  int get lengthOfProcessing => _queue
      .where((UploadingProcess process) =>
          process.status != FileLifecycle.uploaded)
      .length;

  UploadingState get uploadingState {
    var allFiles = _queue.length;
    var inProcess = _queue
        .where((UploadingProcess process) =>
            process.status != FileLifecycle.uploaded)
        .length;
    return UploadingState(inProcess, allFiles);
  }

  bool get canAddFile => _queue.length <= _fileAddLimit - 1;
  List<UploadingProcess> get processes => _queue.toList(growable: false);

/* ------------------------------- Operations ------------------------------- */

  Future<void> cancel() async {
    _queue.clear();
    notifyListeners();
  }

  Future<void> save() async {
    return;
  }

  Future<void> add(String fileName) async {
    if (!canAddFile) throw Exception();
    var process = UploadingProcess(fileName);
    _queue.add(process);
    notifyListeners();
    if (_uploadingFuture == null) runUploading();
  }

  Future<void> delete(int index) async {
    var el = _queue.elementAt(index);
    _queue.remove(el);
    notifyListeners();
  }

/* ------------------------------ Util methods ------------------------------ */
  void runUploading() {
    var waitingCheck =
        (UploadingProcess p) => p.status == FileLifecycle.waiting;
    var makeStatusUploading = (UploadingProcess p) {
      p.startUploading();
      return p;
    };

    var hasWaitingTask = _queue.any(waitingCheck);
    if (!hasWaitingTask) {
      _uploadingFuture = null;
      return;
    }

    var nextProcesses = _queue
        .where(waitingCheck)
        .take(_concurrentUploadingLimit)
        .map(makeStatusUploading)
        .toList();
    notifyListeners();

    _uploadingFuture =
        _uploader.fetch(nextProcesses).then((List<UploadingProcess> processes) {
      notifyListeners();
      runUploading();
      return;
    });
  }
}

class UploadingState {
  int filesInProcessCount;
  int allFilesCount;
  UploadingState(this.filesInProcessCount, this.allFilesCount);
}
