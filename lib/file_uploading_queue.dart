import "dart:async";

class FileUploadingQueue {
  int _fileAddLimit;
  int _concurrentUploadingLimit;

  FileUploadingQueue({int fileAddLimit = 30, int concurrentUploadingLimit = 3})
      : _fileAddLimit = fileAddLimit,
        _concurrentUploadingLimit = concurrentUploadingLimit;

  Stream<bool> empty() {}
  Stream<bool> uploading() {}
  Stream<UploadingState> uploadingState() {}
  Stream<bool> canAddFile() {}
  Stream<List<UploadingProcess>> processes() {}

  Future<void> cancel() async {}
  Future<void> save() async {}
  Future<void> add(String fileName) async {}
  Future<void> delete(String filename) async {}
}

class UploadingState {
  int filesInProcessCount;
  int allFilesCount;
}

class UploadingProcess {}
