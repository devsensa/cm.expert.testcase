import "./file_lifecycle.dart";
import "./file.dart";

class UploadingProcess {
  String _fileName;
  FileLifecycle _processStatus = FileLifecycle.waiting;
  File _file;

  UploadingProcess(this._fileName);

  String get fileName {
    return _fileName;
  }

  FileLifecycle get status {
    return _processStatus;
  }

  File get file {
    return _file;
  }

  void startUploading() {
    _processStatus = FileLifecycle.uploading;
  }

  void completeWithFile(File file) {
    _file = file;
    _processStatus = FileLifecycle.uploaded;
  }
}