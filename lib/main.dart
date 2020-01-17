import "package:flutter/material.dart";
import "package:property_change_notifier/property_change_notifier.dart";

import "./file_uploading_queue.dart";
import "./file_uploader.dart";
import "./file_uploader_screen.dart";
import "./cancel_button.dart";
import "./save_button.dart";
import "./files_subtitle.dart";

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PropertyChangeProvider(
      value: FileUploadingQueue(FileUploader()),
      child: MaterialApp(
          title: 'Тестовое задание',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _navToFileUploadScreen() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext screenContext) => FileUploaderScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home page'),
        ),
        body: Container(
          child: ListTile(
            title: Text("Файлы"),
            trailing: Icon(Icons.arrow_forward_ios),
            subtitle: FilesSubtitle(),
            onTap: _navToFileUploadScreen,
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CancelButton(),
            SaveButton(),
          ],
        ));
  }
}
