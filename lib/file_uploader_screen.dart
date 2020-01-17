import "package:flutter/material.dart";

import "./add_button.dart";
import "./files_list.dart";

class FileUploaderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Файлы"),
      ),
      body: Container(
        child: FilesList(),
      ),
      floatingActionButton: AddButton(),
    );
  }
}
