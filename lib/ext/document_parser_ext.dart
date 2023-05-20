import 'dart:convert';

import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/parser/json/document_json_parser.dart';

import '../parser/document_parser.dart';

extension DocumentJson on Document {

  ///文档转为Json
  String? toJson({List<AbsDocumentSerialize> customSerializeParser = const []}) {
    var dynamicJson =
        documentSerialize(this, customSerializeParser: customSerializeParser);
    return jsonEncode(dynamicJson);
  }

  static Document fromJson(String json,
      {List<AbsDocumentSerialize> customSerializeParser = const []}) {
    return documentDeserialize(jsonDecode(json),
        customSerializeParser: customSerializeParser);
  }

}

extension DocumentNodeJson on DocumentNode {

  String? toJson({List<AbsDocumentSerialize> customSerializeParser = const []}) {
    var dynamicJson =
        documentNodeSerialize(this, customSerializeParser: customSerializeParser);
    return jsonEncode(dynamicJson);
  }

  static DocumentNode fromJson(String json,
      {List<AbsDocumentSerialize> customSerializeParser = const []}) {
    return documentNodeDeserialize(jsonDecode(json),
        customSerializeParser: customSerializeParser);
  }
}
