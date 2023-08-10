import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/ext/document_parser_ext.dart';

import '_example_document.dart';

void main() {

  test("图文", () {
    var mutableDocument = MutableDocument(
      nodes: [
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          metadata: {'blockType': blockquoteAttribution},
          text: AttributedText(
              text: "测试文本",
            ),
        ),
        ParagraphNode(
          id: DocumentEditor.createNodeId(),
          metadata: {'blockType': blockquoteAttribution},
          text: AttributedText(
            text: "测试文本",
          ),
        ),
        ImageNode(
          id: "1",
          imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
          altText: "Image",
          metadata: const SingleColumnLayoutComponentStyles(
            width: double.infinity,
            padding: EdgeInsets.zero,
          ).toMetadata(),
        )
      ]
    );
    var json = mutableDocument.toJson();
    assert(json!=null);
  });

  test("自定义颜色属性测试", () {
    var paragraphNode = ParagraphNode(
      id: DocumentEditor.createNodeId(),
      metadata: {'blockType': blockquoteAttribution},
      text: AttributedText(
          text: "测试文本",
          spans: AttributedSpans(attributions: [
            SpanMarker(
                attribution: _ColorAttribution(Colors.red),
                offset: 0,
                markerType: SpanMarkerType.start),
            SpanMarker(
                attribution: _ColorAttribution(Colors.red),
                offset: 3,
                markerType: SpanMarkerType.end),
          ])),
    );

    ///自定义颜色序列化
    serialize(attribution) {
      if (attribution is _ColorAttribution) {
        return {
          "color": attribution.color.value,
        };
      }
    }

    ///自定义颜色反序列化
    deserializeAttr(Map<String, dynamic> map) {
      if (map["color"] != null) {
        return _ColorAttribution(Color(map["color"]));
      }
    }

    var json = paragraphNode.toJson(
      attributionSerializeBuilder: serialize,
    );
    var docNode = DocumentNodeJson.fromJson(
      json!,
      attributionDeserializeBuilder: deserializeAttr,
    );
    var json2 = docNode.toJson(
      attributionSerializeBuilder: serialize,
    );
    expect(json, json2);
  });

  test("文档 测试", () {
    var document = createInitialDocument();
    var json = document.toJson(customSerializeParser: []);
    assert(json != null);
    var document2 = DocumentJson.fromJson(json!, customSerializeParser: []);
    var json2 = document2.toJson();
    assert(json2 != null);
    expect(json, json2);
  });

  test("Task 测试", () {
    var taskNode = TaskNode(
      id: DocumentEditor.createNodeId(),
      isComplete: true,
      text: AttributedText(
        text:
            'Create and configure your document, for example, by creating a new MutableDocument.',
      ),
    );
    var json = taskNode.toJson();
    assert(json != null);
    var node = DocumentNodeJson.fromJson(json!);
    var json2 = node.toJson();
    assert(json2 != null);
    expect(json, json2);
  });

  test("有序列表 序列化测试", () {
    var listItemNode = ListItemNode.ordered(
      id: DocumentEditor.createNodeId(),
      text: AttributedText(
          text: '有序列表1',
          spans: AttributedSpans(attributions: const [
            SpanMarker(
                attribution: boldAttribution,
                offset: 0,
                markerType: SpanMarkerType.start),
            SpanMarker(
                attribution: boldAttribution,
                offset: 3,
                markerType: SpanMarkerType.end),
          ])),
    );
    var json = listItemNode.toJson();
    assert(json != null);
    var node = DocumentNodeJson.fromJson(json!);
    var json2 = node.toJson();
    expect(json, json2);
  });

  test("无序列表 序列化测试", () {
    var listItemNode = ListItemNode.unordered(
      id: DocumentEditor.createNodeId(),
      text: AttributedText(
          text: '无序列表',
          spans: AttributedSpans(attributions: [
            const SpanMarker(
                attribution: boldAttribution,
                offset: 0,
                markerType: SpanMarkerType.start),
            const SpanMarker(
                attribution: boldAttribution,
                offset: 3,
                markerType: SpanMarkerType.end),
            SpanMarker(
                attribution: LinkAttribution(url: Uri.parse("www.baidu.com")),
                offset: 0,
                markerType: SpanMarkerType.start),
            SpanMarker(
                attribution: LinkAttribution(url: Uri.parse("www.baidu.com")),
                offset: 3,
                markerType: SpanMarkerType.end),
          ])),
    );
    var json = listItemNode.toJson();
    assert(json != null);
    var node = DocumentNodeJson.fromJson(json!);
    var json2 = node.toJson();
    expect(json, json2);
  });

  test("HorizontalRuleNodeSerializeParser", () {
    var horizontalRuleNode =
        HorizontalRuleNode(id: DocumentEditor.createNodeId());
    var json = horizontalRuleNode.toJson();
    assert(json != null);
    var node = DocumentNodeJson.fromJson(json!);
    var json2 = node.toJson();
    assert(json2 != null);
    expect(json, json2);
  });

  test("Image Node Convert test", () {
    var imageNode = ImageNode(
      id: "1",
      imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
      altText: "Image",
      metadata: const SingleColumnLayoutComponentStyles(
        width: double.infinity,
        padding: EdgeInsets.zero,
      ).toMetadata(),
    );
    var json = imageNode.toJson();
    var node = DocumentNodeJson.fromJson(json!);
    var json2 = node.toJson();
    expect(json, json2);
  });

  test("超链接属性测试", () {
    var paragraphNode = ParagraphNode(
      id: DocumentEditor.createNodeId(),
      metadata: {'blockType': blockquoteAttribution},
      text: AttributedText(
          text: "加粗超链接文本",
          spans: AttributedSpans(attributions: [
            const SpanMarker(
                attribution: boldAttribution,
                offset: 0,
                markerType: SpanMarkerType.start),
            const SpanMarker(
                attribution: boldAttribution,
                offset: 6,
                markerType: SpanMarkerType.end),
            SpanMarker(
                attribution: LinkAttribution(url: Uri.parse("www.baidu.com")),
                offset: 0,
                markerType: SpanMarkerType.start),
            SpanMarker(
                attribution: LinkAttribution(url: Uri.parse("www.baidu.com")),
                offset: 6,
                markerType: SpanMarkerType.end),
          ])),
    );
    var json = paragraphNode.toJson();
    var docNode = DocumentNodeJson.fromJson(json!);
    var json2 = docNode.toJson();
    expect(json, json2);
  });

  test("ParagraphNode convert test", () {
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

    var json = paragraphNode.toJson();
    var docNode = DocumentNodeJson.fromJson(json!);
    var json2 = docNode.toJson();
    expect(json, json2);
  });

  // expect(json, json2);
  // DocumentNode.fromJson(json);
}

class _ColorAttribution extends Attribution {
  final Color color;

  _ColorAttribution(this.color);

  @override
  bool canMergeWith(Attribution other) {
    return this == other;
  }

  @override
  String toString() {
    return '[ColorAttribution]: ${color.value}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ColorAttribution &&
          runtimeType == other.runtimeType &&
          color == other.color;

  @override
  int get hashCode => color.hashCode;

  @override
  String get id => 'color';
}
