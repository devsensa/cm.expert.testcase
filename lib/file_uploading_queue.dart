import "dart:async";

class FileUploadingQueue {
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
