import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";
import "./file_uploading_queue.dart";

class FilesSubtitle extends StatelessWidget {
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
        builder: (context, model, properties) {
      var displayText = "";
      if (model.empty) displayText = "Нет файлов";
      model.lengthOfProcessing == 0
          ? "Кол-во файлов: ${model.length}"
          : "Осталось загрузить: ${model.lengthOfProcessing}. Всего файлов: ${model.length}";
      return Text(displayText);
    });
  }
}
