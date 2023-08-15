import 'package:super_editor/super_editor.dart';

///文档序列化抽象
///Document serialization abstraction
abstract class AbsDocumentSerialize {
  ///反序列化
  ///在创建节点的时候，节点需要什么数据，就要在[serialize]处理的时候保存什么数据。
  DocumentNode? deserialize(Map<String, dynamic> map);

  ///序列化
  Map<String, dynamic>? serialize(DocumentNode node);
}
