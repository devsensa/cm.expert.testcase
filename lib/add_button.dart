import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";
import "package:faker/faker.dart";

import "./file_uploading_queue.dart";

class AddButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
        builder: (context, model, properties) {
      var addAction = () => model.add("${faker.lorem.word()}.txt");
      return Visibility(
        visible: model.canAddFile,
        child: FloatingActionButton(
              onPressed: addAction,
              tooltip: 'Add file',
              child: Icon(Icons.add),
            )
      );
    });
  }
}
