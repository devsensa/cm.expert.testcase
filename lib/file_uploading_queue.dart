import "dart:async";
import "dart:collection";

import "package:property_change_notifier/property_change_notifier.dart";
import "./uploading_process.dart";
import "./file_lifecycle.dart";

class FileUploadingQueue extends PropertyChangeNotifier<String> {
  int _fileAddLimit;
  int _concurrentUploadingLimit;
  ListQueue<UploadingProcess> _queue = ListQueue(15);

  FileUploadingQueue({int fileAddLimit = 30, int concurrentUploadingLimit = 3})
      : _fileAddLimit = fileAddLimit,
        _concurrentUploadingLimit = concurrentUploadingLimit;

/* --------------------------------- Getters -------------------------------- */
  int get fileAddLimit {
    return _fileAddLimit;
  }

  int get concurrentUploadingLimit {
    return _concurrentUploadingLimit;
  }

  bool get empty => _queue.isEmpty;
  bool get uploading => _queue.any(
      (UploadingProcess process) => process.status != FileLifecycle.uploaded);
  UploadingState get uploadingState {
    var allFiles = _queue.length;
    var inProcess = _queue
        .where((UploadingProcess process) =>
            process.status != FileLifecycle.uploaded)
        .length;
    return UploadingState(inProcess, allFiles);
  }

  bool get canAddFile => _queue.length < _fileAddLimit;
  List<UploadingProcess> get processes => _queue.toList(growable: false);

/* ------------------------------- Operations ------------------------------- */

  Future<void> cancel() async {
    _queue.clear();
    notifyListeners('empty');
  }

  Future<void> save() async {
    return;
    notifyListeners();
  }

  Future<void> add(String fileName) async {
    var process = UploadingProcess(fileName);
    _queue.add(process);
    notifyListeners();
  }

  Future<void> delete(int hashCode) async {
    _queue.removeWhere(
        (UploadingProcess process) => process.hashCode == hashCode);
    notifyListeners();
  }

/* ------------------------------ Util methods ------------------------------ */

}

class UploadingState {
  int filesInProcessCount;
  int allFilesCount;
  UploadingState(this.filesInProcessCount, this.allFilesCount);
}
