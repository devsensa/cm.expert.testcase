import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import './file_uploading_queue.dart';

class SaveButton {
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
        builder: (context, model, properties) {
      return FlatButton(
        child: Text('Сохранить'),
        onPressed: model.empty && model.uploading ? null : model.save,
      );
    });
  }
}
