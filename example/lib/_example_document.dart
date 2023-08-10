import 'package:flutter/rendering.dart';
import 'package:super_editor/super_editor.dart';

get jsonDocument => r"""
[
    {
        "nodeType": "ImageNode",
        "nodeInfo": {
            "nodeId": "1",
            "altText": "图片",
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
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "f9b38627-55a6-4c9a-8dfe-4df8d3aeb75b",
            "attributedText": {
                "text": "Welcome to Super Editor 💙 🚀",
                "spans": [
                    {
                      "id": "color",
                      "type": "start",
                      "Offset": 0,
                      "color": 4294198070
                    },
                    {
                      "id": "color",
                      "type": "end",
                      "Offset": 6,
                      "color": 4294198070
                    }
                ]
            },
            "metadata": {
                "blockType": "header1"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "9f6fda0a-8176-4842-968f-c72081bef6a5",
            "attributedText": {
                "text": "Super Editor is a toolkit to help you build document editors, document layouts, text fields, and more.",
                "spans": []
            },
            "metadata": {
                "blockType": "paragraph"
            }
        }
    },
    {
        "nodeType": "HorizontalRuleNode",
        "nodeInfo": {
            "nodeId": "86c4db3c-e9d5-4f0a-ae4d-69363215b0ba",
            "metadata": {
                "blockType": "horizontalRule"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "746d6c24-38be-4716-9847-b50d81708f32",
            "attributedText": {
                "text": "Ready-made solutions 📦",
                "spans": []
            },
            "metadata": {
                "blockType": "header2"
            }
        }
    },
    {
        "nodeType": "ListItemNode",
        "nodeInfo": {
            "nodeId": "d92cbd15-5fe8-4804-b3a3-dbc4198ad8d6",
            "listType": "unordered",
            "attributedText": {
                "text": "SuperEditor is a ready-made, configurable document editing experience.",
                "spans": []
            }
        }
    },
    {
        "nodeType": "ListItemNode",
        "nodeInfo": {
            "nodeId": "2a849873-96d8-46b4-9db7-c99225247bd5",
            "listType": "unordered",
            "attributedText": {
                "text": "SuperTextField is a ready-made, configurable text field.",
                "spans": []
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "a898e216-9807-4fdd-af50-abfc187e9c42",
            "attributedText": {
                "text": "Quickstart 🚀",
                "spans": []
            },
            "metadata": {
                "blockType": "header2"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "41c84c67-c5e9-44a6-8977-f2e97cdb1e63",
            "attributedText": {
                "text": "To get started with your own editing experience, take the following steps:",
                "spans": []
            },
            "metadata": {
                "blockType": "paragraph"
            }
        }
    },
    {
        "nodeType": "TaskNode",
        "nodeInfo": {
            "nodeId": "feadcc85-9669-4513-9abc-fb3dc48e0adf",
            "attributedText": {
                "text": "Create and configure your document, for example, by creating a new MutableDocument.",
                "spans": []
            },
            "isComplete": false
        }
    },
    {
        "nodeType": "TaskNode",
        "nodeInfo": {
            "nodeId": "38eb6da8-bb81-4e42-8882-2c6b2fc438d8",
            "attributedText": {
                "text": "If you want programmatic control over the user's selection and styles, create a DocumentComposer.",
                "spans": []
            },
            "isComplete": false
        }
    },
    {
        "nodeType": "TaskNode",
        "nodeInfo": {
            "nodeId": "03c8605f-ab85-4af9-9eda-0cfa470cd9c9",
            "attributedText": {
                "text": "Build a SuperEditor widget in your widget tree, configured with your Document and (optionally) your DocumentComposer.",
                "spans": []
            },
            "isComplete": false
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "890be701-65c7-4f86-8e2e-cf0fae66fc99",
            "attributedText": {
                "text": "Now, you're off to the races! SuperEditor renders your document, and lets you select, insert, and delete content.",
                "spans": []
            },
            "metadata": {
                "blockType": "paragraph"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "b4d3286e-0d22-4be8-b90c-f248318f3bc3",
            "attributedText": {
                "text": "Explore the toolkit 🔎",
                "spans": []
            },
            "metadata": {
                "blockType": "header2"
            }
        }
    },
    {
        "nodeType": "ListItemNode",
        "nodeInfo": {
            "nodeId": "6fb3e996-c3ac-4eea-be8e-b3e7f498af13",
            "listType": "unordered",
            "attributedText": {
                "text": "Use MutableDocument as an in-memory representation of a document.",
                "spans": []
            }
        }
    },
    {
        "nodeType": "ListItemNode",
        "nodeInfo": {
            "nodeId": "80bad7e6-1376-4990-b8b2-0ef627c053c5",
            "listType": "unordered",
            "attributedText": {
                "text": "Implement your own document data store by implementing the Document api.",
                "spans": []
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "8ebebad1-0f02-4104-b390-315932aa0e7d",
            "attributedText": {
                "text": "We hope you enjoy using Super Editor. Let us know what you're building, and please file issues for any bugs that you find.",
                "spans": []
            },
            "metadata": {
                "blockType": "paragraph"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "223766a5-3732-4b58-a19d-f5a30bfc36c7",
            "attributedText": {
                "text": "加粗文本，斜体文本，删除文本,下划线文本..普通文本",
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
                "blockType": "paragraph"
            }
        }
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "3556889d-b2bd-4fd6-bf0d-174a3186b087",
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
    },
    {
        "nodeType": "ParagraphNode",
        "nodeInfo": {
            "nodeId": "23043a04-669f-44b8-bc42-de6a57fefc28",
            "attributedText": {
                "text": "Link Url",
                "spans": [
                    {
                        "id": "link",
                        "type": "start",
                        "Offset": 0,
                        "link": "www.google.com"
                    },
                    {
                        "id": "link",
                        "type": "end",
                        "Offset": 7,
                        "link": "www.google.com"
                    }
                ]
            },
            "metadata": {
                "blockType": "paragraph"
            }
        }
    }
]
""";

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
          text: 'SuperEditor is a ready-made, configurable document editing experience.',
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
        text: AttributedText(text: 'To get started with your own editing experience, take the following steps:'),
      ),
      TaskNode(
        id: DocumentEditor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          text: 'Create and configure your document, for example, by creating a new MutableDocument.',
        ),
      ),
      TaskNode(
        id: DocumentEditor.createNodeId(),
        isComplete: false,
        text: AttributedText(
          text: "If you want programmatic control over the user's selection and styles, create a DocumentComposer.",
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
          text: "Use MutableDocument as an in-memory representation of a document.",
        ),
      ),
      ListItemNode.unordered(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
          text: "Implement your own document data store by implementing the Document api.",
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
            spans: AttributedSpans(attributions: const [
              SpanMarker(attribution: boldAttribution, offset: 0, markerType: SpanMarkerType.start),
              SpanMarker(attribution: boldAttribution, offset: 3, markerType: SpanMarkerType.end),
              SpanMarker(attribution: italicsAttribution, offset: 5, markerType: SpanMarkerType.start),
              SpanMarker(attribution: italicsAttribution, offset: 8, markerType: SpanMarkerType.end),
              SpanMarker(attribution: strikethroughAttribution, offset: 10, markerType: SpanMarkerType.start),
              SpanMarker(attribution: strikethroughAttribution, offset: 13, markerType: SpanMarkerType.end),
              SpanMarker(attribution: underlineAttribution, offset: 14, markerType: SpanMarkerType.start),
              SpanMarker(attribution: underlineAttribution, offset: 19, markerType: SpanMarkerType.end),
            ])),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        metadata: {'blockType': blockquoteAttribution},
        text: AttributedText(
            text: "加粗文本，斜体文本，删除文本,下划线文本.注释块类型",
            spans: AttributedSpans(attributions: const [
              SpanMarker(attribution: boldAttribution, offset: 0, markerType: SpanMarkerType.start),
              SpanMarker(attribution: boldAttribution, offset: 3, markerType: SpanMarkerType.end),
              SpanMarker(attribution: italicsAttribution, offset: 5, markerType: SpanMarkerType.start),
              SpanMarker(attribution: italicsAttribution, offset: 8, markerType: SpanMarkerType.end),
              SpanMarker(attribution: strikethroughAttribution, offset: 10, markerType: SpanMarkerType.start),
              SpanMarker(attribution: strikethroughAttribution, offset: 13, markerType: SpanMarkerType.end),
              SpanMarker(attribution: underlineAttribution, offset: 14, markerType: SpanMarkerType.start),
              SpanMarker(attribution: underlineAttribution, offset: 19, markerType: SpanMarkerType.end),
            ])),
      ),
      ParagraphNode(
        id: DocumentEditor.createNodeId(),
        text: AttributedText(
            text: "Link Url",
            spans: AttributedSpans(attributions: [
              SpanMarker(
                  attribution: LinkAttribution(url: Uri.parse("www.google.com")),
                  offset: 0,
                  markerType: SpanMarkerType.start),
              SpanMarker(
                  attribution: LinkAttribution(url: Uri.parse("www.google.com")),
                  offset: 7,
                  markerType: SpanMarkerType.end),
            ])),
      )
    ],
  );
}
