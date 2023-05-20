import 'package:super_editor/super_editor.dart';

///文档序列化
abstract class AbsDocumentSerialize {

  ///反序列化
  DocumentNode? deserialize(Map<String,dynamic> map);

  ///序列化
  Map<String,dynamic>? serialize(DocumentNode node);

}




