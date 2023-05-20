import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/parser/document_parser.dart';

///默认序列化解析器
final defaultSerializeParser = [
  TaskNodeSerializeParser(),
  ImageNodeSerializeParser(),
  ParagraphNodeSerializeParser(),
  HorizontalRuleNodeSerializeParser(),
  ListItemNodeSerializeParser(),
];

///序列化文档
List<dynamic> documentSerialize(
  Document document, {
  List<AbsDocumentSerialize> customSerializeParser = const [],
}) {
  var nodes = document.nodes;
  List<dynamic> allNodes = [];

  for (var node in nodes) {
    allNodes.add(documentNodeSerialize(
      node,
      customSerializeParser: customSerializeParser,
    ));
  }
  return allNodes;
}

///序列化节点
Map<String, dynamic>? documentNodeSerialize(DocumentNode node,
    {List<AbsDocumentSerialize> customSerializeParser = const []}) {
  final parsers = [...customSerializeParser, ...defaultSerializeParser];

  for (var parser in parsers) {
    var data = parser.serialize(node);
    if (data != null) {
      return data;
    }
  }
  throw "the node ${node.runtimeType} cannot be serialized,Please check if there is a corresponding parser";
}

///文档反序列化
Document documentDeserialize(List<dynamic> map,
    {List<AbsDocumentSerialize> customSerializeParser = const []}) {
  List<DocumentNode> nodes = [];
  List<dynamic> jsonNodes = map;

  for (var jsonNode in jsonNodes) {
    nodes.add(documentNodeDeserialize(
      jsonNode,
      customSerializeParser: customSerializeParser,
    ));
  }

  return MutableDocument(nodes: nodes);
}

///节点数据反序列化
DocumentNode documentNodeDeserialize(Map<String, dynamic> map,
    {List<AbsDocumentSerialize> customSerializeParser = const []}) {
  final parsers = [...customSerializeParser, ...defaultSerializeParser];
  for (var parser in parsers) {
    var data = parser.deserialize(map);
    if (data != null) {
      return data;
    }
  }
  throw "If it cannot be resolved, check whether there is a resolver for the corresponding node type。$map ";
}

///封装序列化基类
///- 子类不用进行'节点'类型判断。
///- 封装通用的序列化和反序列化属性方法
abstract class BaseDocumentJsonSerialize<T extends DocumentNode>
    extends AbsDocumentSerialize {
  //region   json数据中node属性保存用到的Key
  final String keyNodeType = "nodeType";
  final String keyNodeInfo = "nodeInfo";
  final String keyNodeId = "nodeId";
  final String keyText = "text";
  final String keySpans = "spans";
  final String keySpanType = "type";
  final String keySpanOffset = "Offset";
  final String keyMetadata = "metadata";
  final String keyAttributedText = "attributedText";
  final String keyAttributionId = "id";
  final String keyAttributionLink = "link";
  final String keyImageAltText = "altText";
  final String keyImageUrl = "url";
  final String keyListType = "listType";
  final String keyTaskComplete = "isComplete";

  //endregion

  ///快速创建id
  get nodeId => DocumentEditor.createNodeId();

  ///反序列化
  @override
  DocumentNode? deserialize(Map<String, dynamic> map) {
    var type = map[keyNodeType];
    if (T.toString() == type) {
      return deserializeNode(map[keyNodeInfo]);
    }
    return null;
  }

  ///序列化
  @override
  Map<String, dynamic>? serialize(DocumentNode node) {
    if (node.runtimeType == T) {
      return {keyNodeType: T.toString(), keyNodeInfo: serializeNode(node as T)};
    }
    return null;
  }

  ///反序列化节点
  T? deserializeNode(Map<String, dynamic> map);

  ///序列化节点数据
  Map<String, dynamic>? serializeNode(T node);

  Map<String, dynamic> serializeAttrText(AttributedText attributedText) {
    final text = attributedText.text;
    final spans = serializeSpans(attributedText.spans);
    return {keyText: text, keySpans: spans};
  }

  AttributedText deserializeAttrText(Map<String, dynamic>? map) {
    if (map == null) {
      return AttributedText(text: '');
    }
    return AttributedText(
      text: map[keyText] ?? '',
      spans: deserializeSpans(map[keySpans] ?? []),
    );
  }

  ///
  ///
  /// AttributedSpans(attributions: [
  ///       SpanMarker(attribution:  LinkAttribution(url: Uri.parse("www.google.com")), offset: 0, markerType: SpanMarkerType.start),
  ///       SpanMarker(attribution:  LinkAttribution(url: Uri.parse("www.google.com")), offset: 7, markerType: SpanMarkerType.end),
  /// ])
  ///
  /// TO:
  ///
  ///{
  /// "spans" : [
  ///  {
  ///       "id":"link",
  ///       "link":"www.google.com",
  ///       "type":"start",
  ///       "offset":0
  ///  },
  ///  {
  ///       "id":"link",
  ///       "link":"www.google.com",
  ///       "type":"end",
  ///       "offset":7
  ///  }
  ///}
  List<dynamic> serializeSpans(AttributedSpans spans) {
    List<dynamic> spansList = [];

    for (var marker in spans.markers) {
      final attribution = marker.attribution;
      final attrMap = <String, dynamic>{};

      ///通过id区分
      final id = attribution.id;
      //Span类型
      final type = marker.markerType;
      //Span偏移量
      final offset = marker.offset;

      attrMap[keyAttributionId] = id;
      attrMap[keySpanType] = type.name;
      attrMap[keySpanOffset] = offset;

      ///特殊Attr属性添加
      switch (attribution.runtimeType) {
        case LinkAttribution:
          final link = (attribution as LinkAttribution).url;
          attrMap[keyAttributionLink] = link.toString();
          break;
        default:
          break;
      }
      spansList.add(attrMap);
    }

    return spansList;
  }

  ///反序列化AttributedSpans的数据
  AttributedSpans deserializeSpans(List<dynamic> spans) {
    List<SpanMarker> markers = [];
    for (var marker in spans) {
      var attrId = marker[keyAttributionId];
      Attribution attribution;
      if (attrId == "link") {
        attribution =
            LinkAttribution(url: Uri.parse(marker[keyAttributionLink]));
      } else {
        attribution = NamedAttribution(attrId);
      }
      SpanMarkerType type;
      if (marker[keySpanType] == SpanMarkerType.start.name) {
        type = SpanMarkerType.start;
      } else {
        type = SpanMarkerType.end;
      }
      markers.add(SpanMarker(
          attribution: attribution,
          offset: marker[keySpanOffset],
          markerType: type));
    }
    return AttributedSpans(attributions: markers);
  }

  ///序列化 Metadata，封装了通用的数据转换，特殊类型还需要通过[covert]转换
  Map<String, dynamic> serializeMetadata(Map<String, dynamic> metadata,
      {dynamic Function(String key, dynamic value)? covert}) {
    return metadata.map((key, value) {
      var covertValue = covert?.call(key, value);
      if (covertValue != null) {
        return MapEntry(key, covertValue);
      }
      if (value is NamedAttribution) {
        return MapEntry(key, value.id);
      }
      if (key == "singleColumnLayout") {
        return MapEntry(key, serializeSingleColumnLayoutMetadata(value));
      }
      return MapEntry(key, value?.toString());
    });
  }

  ///所有NameAttribution
  static const _allNameAttribution = [
    header1Attribution,
    header2Attribution,
    header3Attribution,
    header4Attribution,
    header5Attribution,
    header6Attribution,
    blockquoteAttribution,
    boldAttribution,
    italicsAttribution,
    underlineAttribution,
    strikethroughAttribution,
    codeAttribution,
    NamedAttribution("paragraph"),
    NamedAttribution("horizontalRule"),
    NamedAttribution("brand"),
    NamedAttribution("flutter"),
    NamedAttribution("superlist_brand"),
    NamedAttribution("titleAttribution"),
    NamedAttribution("header"),
    NamedAttribution("image"),
    NamedAttribution("listItem"),
    NamedAttribution("task"),
  ];

  ///反序列化Metadata，封装了通用的类型。特殊类型还需通过[covert]自行转换。
  Map<String, dynamic> deserializeMetadata(Map<String, dynamic>? metadata,
      {dynamic Function(String key, dynamic value)? covert,
      List<NamedAttribution>? customNameAttribution}) {
    return metadata?.map((key, value) {
          var covertValue = covert?.call(key, value);
          if (covertValue != null) {
            return MapEntry(key, covertValue);
          }
          if (key == "singleColumnLayout") {
            return MapEntry(key, deserializeSingleColumnLayoutMetadata(value));
          }
          final nameAttrs = [
            ...?customNameAttribution,
            ..._allNameAttribution,
          ];
          for (var nameAttr in nameAttrs) {
            if (nameAttr.id == value) {
              return MapEntry(key, NamedAttribution(value));
            }
          }
          return MapEntry(key, value);
        }) ??
        {};
  }

  Map<String, dynamic> serializeSingleColumnLayoutMetadata(
      Map<String, dynamic> map) {
    var width = map["width"]?.toString();
    var padding = (map["padding"] ?? EdgeInsets.zero);
    List<dynamic>? paddingInfo;
    if (padding is EdgeInsets) {
      paddingInfo = [
        -1,
        padding.left,
        padding.top,
        padding.right,
        padding.bottom
      ];
    }
    if (padding is EdgeInsetsDirectional) {
      paddingInfo = [
        -2,
        padding.start,
        padding.top,
        padding.end,
        padding.bottom
      ];
    }
    return {"width": width, "padding": paddingInfo};
  }

  Map<String, dynamic> deserializeSingleColumnLayoutMetadata(
      Map<String, dynamic> map) {
    List<dynamic>? paddingInfo = map["padding"];
    EdgeInsetsGeometry padding = EdgeInsets.zero;
    if (paddingInfo != null) {
      if (paddingInfo[0] == -1) {
        padding = EdgeInsets.only(
            left: paddingInfo[1],
            top: paddingInfo[2],
            right: paddingInfo[3],
            bottom: paddingInfo[4]);
      } else {
        padding = EdgeInsetsDirectional.only(
            start: paddingInfo[1],
            top: paddingInfo[2],
            end: paddingInfo[3],
            bottom: paddingInfo[4]);
      }
    }
    return {"width": double.tryParse(map["width"]), "padding": padding};
  }
}

///段落节点序列化处理器
class ParagraphNodeSerializeParser
    extends BaseDocumentJsonSerialize<ParagraphNode> {
  @override
  ParagraphNode? deserializeNode(Map<String, dynamic> map) {
    return ParagraphNode(
      id: map[keyNodeId] ?? nodeId,
      text: deserializeAttrText(map[keyAttributedText]),
      metadata: deserializeMetadata(map[keyMetadata]),
    );
  }

  @override
  Map<String, dynamic>? serializeNode(ParagraphNode node) {
    return {
      keyNodeId: node.id,
      keyAttributedText: serializeAttrText(node.text),
      keyMetadata: serializeMetadata(node.metadata)
    };
  }
}

///图片节点序列化处理器
class ImageNodeSerializeParser extends BaseDocumentJsonSerialize<ImageNode> {
  @override
  ImageNode? deserializeNode(Map<String, dynamic> map) {
    return ImageNode(
      id: map[keyNodeId] ?? nodeId,
      imageUrl: map[keyImageUrl] ?? '',
      altText: map[keyImageAltText] ?? '',
      metadata: deserializeMetadata(map[keyMetadata]),
    );
  }

  @override
  Map<String, dynamic>? serializeNode(ImageNode node) {
    return {
      keyNodeId: node.id,
      keyImageAltText: node.altText,
      keyImageUrl: node.imageUrl,
      keyMetadata: serializeMetadata(node.metadata)
    };
  }
}

///水平线
class HorizontalRuleNodeSerializeParser
    extends BaseDocumentJsonSerialize<HorizontalRuleNode> {
  @override
  HorizontalRuleNode? deserializeNode(Map<String, dynamic> map) {
    return HorizontalRuleNode(id: map[keyNodeId] ?? nodeId)
      ..metadata = deserializeMetadata(map[keyMetadata]);
  }

  @override
  Map<String, dynamic>? serializeNode(HorizontalRuleNode node) {
    return {keyNodeId: node.id, keyMetadata: serializeMetadata(node.metadata)};
  }
}

///列表项
class ListItemNodeSerializeParser
    extends BaseDocumentJsonSerialize<ListItemNode> {
  @override
  ListItemNode? deserializeNode(Map<String, dynamic> map) {
    var type = map[keyListType];
    ListItemType listItemType;
    if (type == ListItemType.ordered.name) {
      listItemType = ListItemType.ordered;
    } else {
      listItemType = ListItemType.unordered;
    }

    return ListItemNode(
      id: map[keyNodeId] ?? nodeId,
      itemType: listItemType,
      text: deserializeAttrText(map[keyAttributedText]),
    );
  }

  @override
  Map<String, dynamic>? serializeNode(ListItemNode node) {
    return {
      keyNodeId: node.id,
      keyListType: node.type.name,
      keyAttributedText: serializeAttrText(node.text)
    };
  }
}

///taskNode
class TaskNodeSerializeParser extends BaseDocumentJsonSerialize<TaskNode> {
  @override
  TaskNode? deserializeNode(Map<String, dynamic> map) {
    return TaskNode(
      id: map[keyNodeId] ?? nodeId,
      text: deserializeAttrText(map[keyAttributedText]),
      isComplete: map[keyTaskComplete] ?? false,
    );
  }

  @override
  Map<String, dynamic>? serializeNode(TaskNode node) {
    return {
      keyNodeId: node.id,
      keyAttributedText: serializeAttrText(node.text),
      keyTaskComplete: node.isComplete,
    };
  }
}
