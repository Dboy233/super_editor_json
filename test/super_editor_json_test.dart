import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/ext/document_parser_ext.dart';

import '_example_document.dart';

void main() {
  test("文档 测试", () {
    var document = createInitialDocument();
    var json = document.toJson();
    assert(json != null);
    var document2 = DocumentJson.fromJson(json!);
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
          spans: AttributedSpans(attributions: [
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
      altText: "图片",
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

  test("ParagraphNode convert test", () {
    var paragraphNode = ParagraphNode(
      id: DocumentEditor.createNodeId(),
      metadata: {'blockType': blockquoteAttribution},
      text: AttributedText(
          text: "加粗文本，斜体文本，删除文本,下划线文本.注释块类型",
          spans: AttributedSpans(attributions: [
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
