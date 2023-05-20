# super_editor_json

SuperEditor converts the document data to Json format.
超级编辑器将文档数据转换为 JSON 格式。


# How to use it 使用方式

```text
    flutter pub add super_editor_json
```

序列化数据 Serialize node/document data 
```dart
import 'package:super_editor_json/super_editor_json.dart';

final doc = MutableDocument();
final node = HorizontalRuleNode(id: DocumentEditor.createNodeId());

//1. 使用扩展函数 Use extension functions
final json = doc.toJson();
final jsonNode = node.toJson();

//2. 使用顶级函数 Use top-level functions
Map<String,dynamic> data = documentSerialize(doc);
final json = jsonEncode(data);

Map<String,dynamic> dataNode = documentNodeSerialize(node);
final jsonNode = jsonEncode(dataNode);

```

反序列化数据 Deserialize node/document data 

```dart
import 'package:super_editor_json/super_editor_json.dart';

final docJson = "...";
findl nodeJson = "...";

Document doc = DocumentJson.fromJson(docJson);
DocumentNode node = DocumentNodeJson.fromJson(nodeJson);

```

# Serialize custom components

序列化和反序列化都支持扩展自定义组件。 Support for custom components.

Extends `BaseDocumentJsonSerialize<T>`.

```dart
///ImageNode Example 
class ImageNodeSerializeParser extends BaseDocumentJsonSerialize<ImageNode> {
  
  @override
  ImageNode? deserializeNode(Map<String, dynamic> map) {
    return ImageNode(
      id: map[keyNodeId] ?? nodeId,
      metadata: deserializeMetadata(map[keyMetadata]),
      imageUrl: map["imageUrl"] ?? '',
      altText: map["altText"] ?? '',
    );
  }
  
  ///因为ImageNode需要`imageUrl`和`altText`属性，所以在序列化的时候定义两个对应的数据就可以了。
  ///This is because the Image Node requires the 'imageURL' and 'altText' attributes，
  ///So it is enough to define two corresponding data when serializing.
  @override
  Map<String, dynamic>? serializeNode(ImageNode node) {
    return {
      keyNodeId: node.id,
      keyMetadata: serializeMetadata(node.metadata)
      "altText": node.altText,
      "imageUrl": node.imageUrl,
    };
  }
}
```
然后在进行序列化和反序列化操作的时候添加`ImageNodeSerializeParser`。
Then add 'ImageNodeSerializeParser' for serialization and deserialization operations.

```dart
  document.toJson(customSerializeParser: [
      ImageNodeSerializeParser(),
  ]);

  DocumentJson.fromJson(json,customSerializeParser: [
      ImageNodeSerializeParser(),
  ])
```



# The converted data format

> Document

文档的根结构是一个列表。里面是每一个节点信息。
The root structure of a document is a list. Inside is each node information.

```json
[
  {},
  {},
  {}
]
```

> ParagraphNode

```dart
var paragraphNode = ParagraphNode(
  id: DocumentEditor.createNodeId(),
  metadata: {'blockType': blockquoteAttribution},
  text: AttributedText(
      text: "加粗文本，斜体文本，删除文本,下划线文本.注释块类型",
      spans: AttributedSpans(attributions: const [
        SpanMarker(
            attribution: boldAttribution,
            offset: 0,
            markerType: SpanMarkerType.start),
        SpanMarker(
            attribution: boldAttribution,
            offset: 3,
            markerType: SpanMarkerType.end),
        SpanMarker(
            attribution: italicsAttribution,
            offset: 5,
            markerType: SpanMarkerType.start),
        SpanMarker(
            attribution: italicsAttribution,
            offset: 8,
            markerType: SpanMarkerType.end),
        SpanMarker(
            attribution: strikethroughAttribution,
            offset: 10,
            markerType: SpanMarkerType.start),
        SpanMarker(
            attribution: strikethroughAttribution,
            offset: 13,
            markerType: SpanMarkerType.end),
        SpanMarker(
            attribution: underlineAttribution,
            offset: 14,
            markerType: SpanMarkerType.start),
        SpanMarker(
            attribution: underlineAttribution,
            offset: 19,
            markerType: SpanMarkerType.end),
      ])),
);
```

```json
{
    "nodeType": "ParagraphNode",
    "nodeInfo": {
        "nodeId": "0bb30b71-e1cf-4f63-a5dd-fd2062a4a797",
        "attributedText": {
            "text": "加粗文本，斜体文本，删除文本,下划线文本.注释块类型",
            "spans": [
                {
                    "id": "bold",
                    "type": "start",
                    "Offset": 0
                },
                {
                    "id": "bold",
                    "type": "end",
                    "Offset": 3
                },
                {
                    "id": "italics",
                    "type": "start",
                    "Offset": 5
                },
                {
                    "id": "italics",
                    "type": "end",
                    "Offset": 8
                },
                {
                    "id": "strikethrough",
                    "type": "start",
                    "Offset": 10
                },
                {
                    "id": "strikethrough",
                    "type": "end",
                    "Offset": 13
                },
                {
                    "id": "underline",
                    "type": "start",
                    "Offset": 14
                },
                {
                    "id": "underline",
                    "type": "end",
                    "Offset": 19
                }
            ]
        },
        "metadata": {
            "blockType": "blockquote"
        }
    }
}

```

> ImageNode

```dart
    var imageNode = ImageNode(
      id: "1",
      imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
      altText: "Image",
      metadata: const SingleColumnLayoutComponentStyles(
        width: double.infinity,
        padding: EdgeInsets.zero,
      ).toMetadata(),
    );
```

```json
{
    "nodeType": "ImageNode",
    "nodeInfo": {
        "nodeId": "1",
        "altText": "Image",
        "url": "https://i.ibb.co/5nvRdx1/flutter-horizon.png",
        "metadata": {
            "singleColumnLayout": {
                "width": "Infinity",
                "padding": [
                    -1,
                    0,
                    0,
                    0,
                    0
                ]
            },
            "blockType": "image"
        }
    }
}
```

> HorizontalRuleNode

```dart
    var horizontalRuleNode = HorizontalRuleNode(id: DocumentEditor.createNodeId());
```
```json
{
    "nodeType": "HorizontalRuleNode",
    "nodeInfo": {
        "nodeId": "f400930f-663b-4fd1-9d14-d3562d984536",
        "metadata": {
            "blockType": "horizontalRule"
        }
    }
}
```

> ListItemNode

```dart
    var listItemNode = ListItemNode.unordered(
      id: DocumentEditor.createNodeId(),
      text: AttributedText(
          text: 'There was an important meeting in the afternoon',
          spans: AttributedSpans(attributions: const [
            SpanMarker(
                attribution: boldAttribution,
                offset: 38,
                markerType: SpanMarkerType.start),
            SpanMarker(
                attribution: boldAttribution,
                offset: 46,
                markerType: SpanMarkerType.end),
          ])),
    );
```
```json
{
    "nodeType": "ListItemNode",
    "nodeInfo": {
        "nodeId": "b83d836d-2c38-4ec2-b86e-d7318d13f54d",
        "listType": "unordered",
        "attributedText": {
            "text": "There was an important meeting in the afternoon",
            "spans": [
                {
                    "id": "bold",
                    "type": "start",
                    "Offset": 38
                },
                {
                    "id": "bold",
                    "type": "end",
                    "Offset": 46
                }
            ]
        }
    }
}
```

> TaskNode

```dart
    var taskNode = TaskNode(
      id: DocumentEditor.createNodeId(),
      isComplete: true,
      text: AttributedText(
        text:
            'Create and configure your document, for example, by creating a new MutableDocument.',
      ),
    );
```

```json
{
    "nodeType": "TaskNode",
    "nodeInfo": {
        "nodeId": "8099b3b9-155a-4f0d-9ee1-518fc9941332",
        "attributedText": {
            "text": "Create and configure your document, for example, by creating a new MutableDocument.",
            "spans": []
        },
        "isComplete": true
    }
}
```