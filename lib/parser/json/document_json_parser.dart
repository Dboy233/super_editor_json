import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/parser/document_parser.dart';

import 'document_json_parser_default.dart';

///文档序列化 , Document serialization
///[customNodeSerializeParser] 自定义序列化处理器
///[customAttributionSerializeBuilder] 自定义属性序列化构建器 - [Attribution]
List<dynamic> documentSerialize(
  Document document, {
  List<AbsDocumentSerialize> customNodeSerializeParser = const [],
  AttributionSerializeBuilder? customAttributionSerializeBuilder,
}) {
  var nodes = document.nodes;
  List<dynamic> allNodes = [];

  for (var node in nodes) {
    allNodes.add(documentNodeSerialize(
      node,
      customNodeSerializeParser: customNodeSerializeParser,
      customAttributionSerializeBuilder: customAttributionSerializeBuilder,
    ));
  }
  return allNodes;
}

///节点序列化 Node serialization
///[customNodeSerializeParser] 自定义序列化处理器
///[customAttributionSerializeBuilder] 属性序列化构建器 - [Attribution]
Map<String, dynamic> documentNodeSerialize(
  DocumentNode node, {
  List<AbsDocumentSerialize> customNodeSerializeParser = const [],
  AttributionSerializeBuilder? customAttributionSerializeBuilder,
}) {
  final parsers = [...customNodeSerializeParser, ...defaultNodeSerializeParser];

  for (var parser in parsers) {
    if (parser is BaseDocumentJsonSerialize) {
      parser.customAttributionSerializeBuilder = customAttributionSerializeBuilder;
    }
    var data = parser.serialize(node);
    if (data != null) {
      return data;
    }
  }
  throw "the node ${node.runtimeType} cannot be serialized,Please check if there is a corresponding parser";
}

///文档反序列化，Document deserialization
///[customNodeSerializeParser] 自定义Node序列化处理器
///[customAttributionDeserializeBuilder] 属性反序列化构建器 - [Attribution]
Document documentDeserialize(
  List<dynamic> map, {
  List<AbsDocumentSerialize> customNodeSerializeParser = const [],
  AttributionDeserializeBuilder? customAttributionDeserializeBuilder,
}) {
  List<DocumentNode> nodes = [];
  List<dynamic> jsonNodes = map;

  for (var jsonNode in jsonNodes) {
    nodes.add(documentNodeDeserialize(
      jsonNode,
      customNodeSerializeParser: customNodeSerializeParser,
      customAttributionDeserializeBuilder: customAttributionDeserializeBuilder,
    ));
  }

  return MutableDocument(nodes: nodes);
}

///节点反序列化，Node deserialization
///[customNodeSerializeParser] 自定义Node序列化处理器
///[customAttributionDeserializeBuilder] 属性反序列化构建器 - [Attribution]
DocumentNode documentNodeDeserialize(
  Map<String, dynamic> map, {
  List<AbsDocumentSerialize> customNodeSerializeParser = const [],
  AttributionDeserializeBuilder? customAttributionDeserializeBuilder,
}) {
  final parsers = [...customNodeSerializeParser, ...defaultNodeSerializeParser];
  for (var parser in parsers) {
    if (parser is BaseDocumentJsonSerialize) {
      parser.customAttributionDeserializeBuilder = customAttributionDeserializeBuilder;
    }
    var data = parser.deserialize(map);
    if (data != null) {
      return data;
    }
  }
  throw "If it cannot be resolved, check whether there is a resolver for the corresponding node type。$map ";
}

///[AttributedText] 将文本内容的自定义[Attribution]进行反序列化
typedef AttributionDeserializeBuilder = Attribution? Function(Map<String, dynamic> map);

///[AttributedText] 进行序列化的时候处理它自定义的[Attribution]属性
typedef AttributionSerializeBuilder = Map<String, dynamic>? Function(Attribution attribution);

///封装序列化基类，内部方法都是成对出现的，一个序列化后一个反序列化
///Encapsulates the serialization base class,Internal methods all come in pairs，One serialized and then one deserialized
///- 子类不用进行'节点'类型判断。
///- 封装通用的序列化和反序列化属性方法.
///- Subclasses do not need to make 'node' type judgments.
///- Encapsulates generic serialization and deserialization property methods
abstract class BaseDocumentJsonSerialize<T extends DocumentNode> implements AbsDocumentSerialize {
  //region   保存node属性用到的Key，Save the key used for the node property
  final String keyNodeType = "nodeType";
  final String keyNodeInfo = "nodeInfo";
  final String keyNodeId = "nodeId";
  final String keyText = "text";
  final String keySpans = "spans";
  final String keySpanType = "type";
  final String keySpanOffset = "Offset";
  final String keyMetadata = "metadata";
  final String keyAttributedText = "attributedText";
  final String keyAttribution = "attribution";
  final String keyAttributionId = "id";
  final String keyAttributionName = "name";
  final String keyAttributionLink = "link";
  final String keyImageAltText = "altText";
  final String keyImageUrl = "url";
  final String keyListType = "listType";
  final String keyTaskComplete = "isComplete";

  //endregion

  ///快速创建id,Quickly create IDs
  get nodeId => DocumentEditor.createNodeId();

  ///设置全局自定义[Attribution]属性序列化构建器
  ///如果你为节点自定义了 [Attribution] , 那么就需要自己配置序列化
  AttributionSerializeBuilder? _customAttributionSerializeBuilder;

  ///自定义[Attribution]反序列化构建器
  AttributionDeserializeBuilder? _customAttributionDeserializeBuilder;

  set customAttributionSerializeBuilder(AttributionSerializeBuilder? value) {
    _customAttributionSerializeBuilder = value;
  }

  set customAttributionDeserializeBuilder(AttributionDeserializeBuilder? value) {
    _customAttributionDeserializeBuilder = value;
  }

  ///Deserialization
  ///
  ///- [map] For data formats, see [serialize] note description.
  ///       有关数据格式，请参阅 [serialize] 注释说明。
  /// @return Document node of type [T] currently.
  ///         当前类型为 [T] 的文档节点。
  ///
  @override
  DocumentNode? deserialize(Map<String, dynamic> map) {
    var type = map[keyNodeType];
    if (T.toString() == type) {
      return deserializeNode(map[keyNodeInfo]);
    }
    return null;
  }

  ///Serialization
  ///
  /// return:
  ///
  /// {
  ///   "[keyNodeType]":"ImageNode",
  ///   "[keyNodeInfo]":{
  ///           The current node serializes the information.
  ///   }
  /// }
  ///
  ///
  @override
  Map<String, dynamic>? serialize(DocumentNode node) {
    if (node.runtimeType == T) {
      return {keyNodeType: T.toString(), keyNodeInfo: serializeNode(node as T)};
    }
    return null;
  }

  ///Deserialize the node
  ///When creating a node, what data the node needs, [serializeNode] needs save what data.
  ///Review the methods exposed in [BaseDocumentJsonSerialize] to simplify the difficulty of deserializing data.
  ///创建节点的时候，节点需要什么数据，[serializeNode]就要保存什么数据。
  ///查看[BaseDocumentJsonSerialize]中公开的方法，以简化对数据反序列化的难度。
  T? deserializeNode(Map<String, dynamic> map);

  ///Serialize node data
  ///Review the methods exposed in [BaseDocumentJsonSerialize] to simplify the difficulty of serializing data.
  ///查看[BaseDocumentJsonSerialize]中公开的方法，以简化对数据序列化的难度。
  Map<String, dynamic>? serializeNode(T node);

  ///Serialize the [AttributedText]
  ///
  /// [serializeAttributionBuilder] 自定义Attribution进行处理
  ///
  /// example：
  ///
  /// serializeAttributionBuilder: (attribution) {
  //         if(attribution as ColorAttribution){
  //            return {
  //              "color":attribution.color
  //            }
  //         }
  //  }
  ///
  ///
  ///@return
  ///{
  ///   "[keyText]":"Attributed text - I am text",
  ///   "[keySpans]":[]
  ///}
  Map<String, dynamic> serializeAttrText(AttributedText attributedText,
      {AttributionSerializeBuilder? serializeAttributionBuilder}) {
    final text = attributedText.text;
    final spans = serializeSpans(
      attributedText.spans,
      serializeAttributionBuilder: serializeAttributionBuilder,
    );
    return {keyText: text, keySpans: spans};
  }

  ///Deserialization [AttributedText]
  AttributedText deserializeAttrText(Map<String, dynamic>? map,
      {AttributionDeserializeBuilder? deserializeAttributionBuilder}) {
    if (map == null) {
      return AttributedText(text: '');
    }
    return AttributedText(
      text: map[keyText] ?? '',
      spans: deserializeSpans(
        map[keySpans] ?? [],
        deserializeAttributionBuilder: deserializeAttributionBuilder,
      ),
    );
  }

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
  ///       "type":"start",
  ///       "offset":0
  ///       "[keyAttribution]": {
  ///         "[keyAttributionId]":"link",
  ///         "[keyAttributionLink]":"www.google.com"
  ///       }
  ///  },
  ///  {
  ///       "type":"end",
  ///       "offset":7
  ///       "[keyAttribution]": {
  ///         "[keyAttributionId]":"link",
  ///         "[keyAttributionLink]":"www.google.com"
  ///       }
  ///  }
  ///}
  /// see  [deserializeSpans]
  List<dynamic> serializeSpans(
    AttributedSpans spans, {
    AttributionSerializeBuilder? serializeAttributionBuilder,
  }) {
    List<dynamic> spansList = [];

    List<AttributionSerializeBuilder?> builders = [
      serializeAttributionBuilder,
      _customAttributionSerializeBuilder,
      defaultAttributionSerializeBuilder
    ];

    for (var marker in spans.markers) {
      final attrMap = <String, dynamic>{};
      final attribution = marker.attribution;

      var attributionMap = _handleAttributionSerialize(builders, attribution);
      if (attributionMap == null) {
        throw '无法序列化 $attribution';
      }
      //Span类型
      final type = marker.markerType;
      //Span偏移量
      final offset = marker.offset;

      attrMap[keyAttribution] = attributionMap;
      attrMap[keySpanType] = type.name;
      attrMap[keySpanOffset] = offset;

      spansList.add(attrMap);
    }

    return spansList;
  }

  ///反序列化AttributedSpans的数据
  ///see [serializeSpans]
  AttributedSpans deserializeSpans(
    List<dynamic> spans, {
    AttributionDeserializeBuilder? deserializeAttributionBuilder,
  }) {
    List<AttributionDeserializeBuilder?> builders = [
      deserializeAttributionBuilder,
      _customAttributionDeserializeBuilder,
      defaultAttributionDeserializeBuilder
    ];
    List<SpanMarker> markers = [];
    for (var marker in spans) {
      Attribution? attribution = _handleAttributionDeserialize(builders, marker);
      if (attribution == null) {
        throw '无法进行序列化 $marker';
      }
      SpanMarkerType type;
      if (marker[keySpanType] == SpanMarkerType.start.name) {
        type = SpanMarkerType.start;
      } else {
        type = SpanMarkerType.end;
      }
      markers.add(SpanMarker(attribution: attribution, offset: marker[keySpanOffset], markerType: type));
    }
    return AttributedSpans(attributions: markers);
  }

  ///处理[Attribution]序列化的数据
  ///see [_handleAttributionDeserialize]
  Map<String, dynamic>? _handleAttributionSerialize(
    List<AttributionSerializeBuilder?> builders,
    Attribution attribution,
  ) {
    for (var builder in builders) {
      final value = builder?.call(attribution);
      if (value != null) {
        return value;
      }
    }
    return null;
  }

  ///处理[Attribution]的反序列化
  ///see [_handleAttributionSerialize]
  Attribution? _handleAttributionDeserialize(
    List<AttributionDeserializeBuilder?> builders,
    marker,
  ) {
    Attribution? attribution;
    for (var builder in builders) {
      ///FIXME: keyAttribution 在下个版本将不能为NULL,因为旧版本中不存在这个属性。
      ///在旧的版本中数据结构是
      ///{
      /// id:link,
      /// url:www.google.com,
      /// type:start,
      /// offset:0,
      ///}
      ///在新版本中
      ///{
      ///   attribution:{
      ///     id:link,
      ///     url:www.google.com
      ///   },
      ///   type:start,
      ///   offset:0
      ///}
      ///所以新版本中 attribution 不可能为 NULL，
      ///所有 SuperEditor 内置的 Attribution 都有进行了处理，内置类型只有 LinkAttribution 和 NameAttribution,
      ///可以查看 test 文件中对于 _ColorAttribution 的处理。
      attribution = builder?.call(marker[keyAttribution] ?? marker);
      if (attribution != null) break;
    }
    return attribution;
  }

  ///默认属性序列化构建器
  ///see [defaultAttributionDeserializeBuilder]
  Map<String, dynamic>? defaultAttributionSerializeBuilder(Attribution attribution) {
    ///特殊Attr属性添加
    if (attribution is LinkAttribution) {
      return {
        keyAttributionId: attribution.id,
        keyAttributionLink: attribution.url.toString(),
      };
    } else if (attribution is NamedAttribution) {
      return {
        keyAttributionId: attribution.id,
        keyAttributionName: attribution.name,
      };
    }
    return null;
  }

  ///默认属性反序列化构建器
  ///see [defaultAttributionSerializeBuilder]
  Attribution? defaultAttributionDeserializeBuilder(Map<String, dynamic> map) {
    var attrId = map[keyAttributionId];
    if (attrId == "link") {
      return LinkAttribution(url: Uri.parse(map[keyAttributionLink]));
    } else {
      ///为什么这么做呢，为了防止自定义的Attribution
      for (var value in _allNameAttribution) {
        if (attrId == value.id) {
          return value;
        }
      }
    }
    return null;
  }

  ///All known NamedAttribution
  ///已知 SuperEditor 所有内置的 [NamedAttribution]
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

  ///Serializing metadata, which encapsulates generic data transformations.
  ///Custom metadata needs to be converted via the [covert] callback method.
  ///see [deserializeMetadata]
  Map<String, dynamic> serializeMetadata(
    Map<String, dynamic>? metadata, {
    dynamic Function(String key, dynamic value)? covert,
  }) {
    return metadata?.map((key, value) {
          var covertValue = covert?.call(key, value);
          if (covertValue != null) {
            return MapEntry(key, covertValue);
          }
          if (value is NamedAttribution) {
            return MapEntry(key, value.id);
          }
          if (key == "singleColumnLayout" && value != null) {
            return MapEntry(key, serializeSingleColumnLayoutMetadata(value));
          }
          return MapEntry(key, value?.toString());
        }) ??
        {};
  }

  ///Deserialized Metadata, which encapsulates common types.
  ///Custom metadata needs to be converted by [covert].
  ///
  /// use:
  /// deserializeMetadata(
  ///  map[keyMetadata],
  ///  covert: (key, value) {
  //         if(key == "***"){
  //            return ***()
  //         }
  //    }
  /// )
  ///
  ///see [serializeMetadata]
  Map<String, dynamic> deserializeMetadata(
    Map<String, dynamic>? metadata, {
    dynamic Function(String key, dynamic value)? covert,
    List<NamedAttribution>? customNameAttribution,
  }) {
    return metadata?.map((key, value) {
          var covertValue = covert?.call(key, value);
          if (covertValue != null) {
            return MapEntry(key, covertValue);
          }
          if (key == "singleColumnLayout" && value != null) {
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

  /// {
  ///   "width":213,
  ///   "padding":[-1,0,0,0,0] //first -1 is EdgeInsets type ，first -2 is EdgeInsetsDirectional type.
  /// }
  /// see [deserializeSingleColumnLayoutMetadata],[SingleColumnLayoutComponentStyles]
  Map<String, dynamic> serializeSingleColumnLayoutMetadata(Map<String, dynamic> map) {
    var width = map["width"]?.toString();
    var padding = (map["padding"] ?? EdgeInsets.zero);
    List<dynamic>? paddingInfo;
    if (padding is EdgeInsets) {
      paddingInfo = [-1, padding.left, padding.top, padding.right, padding.bottom];
    }
    if (padding is EdgeInsetsDirectional) {
      paddingInfo = [-2, padding.start, padding.top, padding.end, padding.bottom];
    }
    return {"width": width, "padding": paddingInfo};
  }

  /// see [serializeSingleColumnLayoutMetadata],[SingleColumnLayoutComponentStyles]
  Map<String, dynamic> deserializeSingleColumnLayoutMetadata(Map<String, dynamic> map) {
    List<dynamic>? paddingInfo = map["padding"];
    EdgeInsetsGeometry padding = EdgeInsets.zero;
    if (paddingInfo != null) {
      if (paddingInfo[0] == -1) {
        padding = EdgeInsets.only(
            left: double.tryParse(paddingInfo[1].toString()) ?? 0,
            top: double.tryParse(paddingInfo[2].toString()) ?? 0,
            right: double.tryParse(paddingInfo[3].toString()) ?? 0,
            bottom: double.tryParse(paddingInfo[4].toString()) ?? 0);
      } else {
        padding = EdgeInsetsDirectional.only(
            start: double.tryParse(paddingInfo[1].toString()) ?? 0,
            top: double.tryParse(paddingInfo[2].toString()) ?? 0,
            end: double.tryParse(paddingInfo[3].toString()) ?? 0,
            bottom: double.tryParse(paddingInfo[4].toString()) ?? 0);
      }
    }
    return {"width": double.tryParse(map["width"]), "padding": padding};
  }
}
