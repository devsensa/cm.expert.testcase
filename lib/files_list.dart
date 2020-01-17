import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";

import "./file_uploading_queue.dart";
import "./file_status.dart";

class FilesList extends StatelessWidget {
  Widget build(BuildContext context) {
    return PropertyChangeConsumer<FileUploadingQueue>(
        builder: (context, model, properties) {
      var processes = model.processes;
      return model.empty
          ? Center(child: Text('Нет файлов'))
          : Scrollbar(
              child: ListView.builder(
                  itemCount: model.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(processes[i].fileName),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          model.delete(i);
                        },
                      ),
                      subtitle: FileStatus(processes[i].status),
                    );
                  }),
            );
    });
  }
}
