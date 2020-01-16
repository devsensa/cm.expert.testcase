import "dart:async";

class FileUploadingQueue {
  Stream<bool> empty() {}
  Stream<bool> uploading() {}
  Stream<UploadingState> uploadingState;

  Future<void> cancel() async {}
  Future<void> save() async {}
}

class UploadingState {
  int filesInProcessCount;
  int allFilesCount;
}
