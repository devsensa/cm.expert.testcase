import "package:flutter/material.dart";

import "./file_lifecycle.dart";

class FileStatus extends StatelessWidget {
  final FileLifecycle status;

  FileStatus(this.status);

  Widget build(BuildContext context) {
    var displayText = "";
    switch (status) {
      case FileLifecycle.waiting:
        {
          displayText = "В ожидании";
          break;
        }
      case FileLifecycle.uploading:
        {
          displayText = "Загружается";
          break;
        }
      case FileLifecycle.uploaded:
        {
          displayText = "";
          break;
        }
    }
    return Text(displayText);
  }
}
