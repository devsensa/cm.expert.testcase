import 'package:flutter/material.dart';
import 'package:property_change_notifier/property_change_notifier.dart';

import './file_uploading_queue.dart';

class SaveButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
      builder: (context, model, properties) {
        var handlePress = () async {
          model.save().then((value) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text("Файлы сохранены"),
                );
              },
            );
          });
        };
        return FlatButton(
          child: Text('Сохранить'),
          onPressed: model.empty || model.uploading ? null : handlePress,
        );
      },
    );
  }
}
