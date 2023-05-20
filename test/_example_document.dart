import 'package:flutter/rendering.dart';
import 'package:super_editor/super_editor.dart';

Document createInitialDocument() {
  return MutableDocument(
    nodes: [
      ImageNode(
        id: "1",
        imageUrl: 'https://i.ibb.co/5nvRdx1/flutter-horizon.png',
        altText: "图片",
        metadata: const SingleColumnLayoutComponentStyles(
          width: double.infinity,
          padding: EdgeInsets.zero,
        ).toMetadata(),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: 'Welcome to Super Editor 💙 🚀',
        ),
        metadata: {
          'blockType': header1Attribution,
        },
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              "Super Editor is a toolkit to help you build document editors, document layouts, text fields, and more.",
        ),
      ),
      HorizontalRuleNode(id: DocumentEditor.createNodeId()),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: 'Ready-made solutions 📦',
        ),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ListItemNode.unordered(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              'SuperEditor is a ready-made, configurable document editing experience.',
        ),
      ),
      ListItemNode.unordered(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: 'SuperTextField is a ready-made, configurable text field.',
        ),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: 'Quickstart 🚀',
        ),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
            text:
                'To get started with your own editing experience, take the following steps:'),
      ),
      TaskNode(
        id: DocumentEditor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          text:
              'Create and configure your document, for example, by creating a new MutableDocument.',
        ),
      ),
      TaskNode(
        id: DocumentEditor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          text:
              "If you want programmatic control over the user's selection and styles, create a DocumentComposer.",
        ),
      ),
      TaskNode(
        id: DocumentEditor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          text:
              "Build a SuperEditor widget in your widget tree, configured with your Document and (optionally) your DocumentComposer.",
        ),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              "Now, you're off to the races! SuperEditor renders your document, and lets you select, insert, and delete content.",
        ),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: 'Explore the toolkit 🔎',
        ),
        metadata: {
          'blockType': header2Attribution,
        },
      ),
      ListItemNode.unordered(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              "Use MutableDocument as an in-memory representation of a document.",
        ),
      ),
      ListItemNode.unordered(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              "Implement your own document data store by implementing the Document api.",
        ),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text:
              "We hope you enjoy using Super Editor. Let us know what you're building, and please file issues for any bugs that you find.",
        ),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
            text: "加粗文本，斜体文本，删除文本,下划线文本..普通文本",
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
      ),
      ParagraphNode(
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
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(text: "Link Url",
        spans:  AttributedSpans(attributions: [
         SpanMarker(attribution:  LinkAttribution(url: Uri.parse("www.google.com")), offset: 0, markerType: SpanMarkerType.start),
         SpanMarker(attribution:  LinkAttribution(url: Uri.parse("www.google.com")), offset: 7, markerType: SpanMarkerType.end),
        ])),
      )
    ],
  );
}
