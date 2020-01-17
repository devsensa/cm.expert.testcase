import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";

import "./file_uploading_queue.dart";

class CancelButton extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
      builder: (context, model, properties) {
        return FlatButton(
              child: Text('Сбросить'),
              onPressed: model.empty ? null : model.cancel
            );
      }
    );
  }
}