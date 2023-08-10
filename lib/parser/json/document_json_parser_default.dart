import 'package:super_editor/super_editor.dart';

import 'document_json_parser.dart';

///默认序列化解析器
final defaultNodeSerializeParser = [
  TaskNodeSerializeParser(),
  ImageNodeSerializeParser(),
  ParagraphNodeSerializeParser(),
  HorizontalRuleNodeSerializeParser(),
  ListItemNodeSerializeParser(),
];

///段落节点序列化处理器
class ParagraphNodeSerializeParser extends BaseDocumentJsonSerialize<ParagraphNode> {
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
class HorizontalRuleNodeSerializeParser extends BaseDocumentJsonSerialize<HorizontalRuleNode> {
  @override
  HorizontalRuleNode? deserializeNode(Map<String, dynamic> map) {
    return HorizontalRuleNode(id: map[keyNodeId] ?? nodeId)..metadata = deserializeMetadata(map[keyMetadata]);
  }

  @override
  Map<String, dynamic>? serializeNode(HorizontalRuleNode node) {
    return {keyNodeId: node.id, keyMetadata: serializeMetadata(node.metadata)};
  }
}

///列表项
class ListItemNodeSerializeParser extends BaseDocumentJsonSerialize<ListItemNode> {
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
    return {keyNodeId: node.id, keyListType: node.type.name, keyAttributedText: serializeAttrText(node.text)};
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
