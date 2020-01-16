import "dart:typed_data";

class File {
  final String name;
  final Uint8List content;

  File(this.name, this.content);
}
