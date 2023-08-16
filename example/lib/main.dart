import 'dart:convert';

import 'package:example/_example_document.dart';
import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/parser/json/document_json_parser.dart';

import '_color_attribution.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: EditorPage(),
    );
  }
}

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  late Document document;
  late DocumentEditor editor;

  @override
  void initState() {
    //Create a document using json.
    document = createInitialDocument();
    // document = DocumentJson.fromJson(jsonDocument, attributionDeserializeBuilder: deserializeAttr);
    editor = DocumentEditor(document: document as MutableDocument);
    super.initState();
  }

  ///自定义 ColorAttribution 序列化
  ///Custom ColorAttribution serialization
  Map<String, dynamic>? serializeAttr(attribution) {
    if (attribution is ColorAttribution) {
      return {
        "color": attribution.color.value,
      };
    }
    return null;
  }

  ///反序列化自定义的 ColorAttribution
  ///Deserialize the custom ColorAttribution
  Attribution? deserializeAttr(Map<String, dynamic> map) {
    if (map["color"] != null) {
      return ColorAttribution(Color(map["color"]));
    }
    return null;
  }

  _showJsonDialog(String json) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          builder: (context, scrollController) {
            return Container(
              color: Colors.white,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Text(json.trim()),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('super editor json'),
      ),
      body: SuperEditor(
        editor: editor,
        componentBuilders: [
          TaskComponentBuilder(editor),
          ...defaultComponentBuilders,
        ],

        ///要使用自定义的 Attribution ,首先我们要将自定义 ColorAttribution 应用到我们的 Node 上。
        ///查看[_ColorAttribution]的注释
        stylesheet: defaultStylesheet.copyWith(
          inlineTextStyler: (attributions, existingStyle) {

            TextStyle newStyle = defaultInlineTextStyler(attributions, existingStyle);

            for (final attribution in attributions) {
              newStyle = newStyle.mergeColorAttribution(attribution);
            }

            return newStyle;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var json = document.toJson(); //save json
          //Use formatted JSON data
          var json = documentSerialize(
            document,
            customAttributionSerializeBuilder: serializeAttr,
          );
          var encoder = const JsonEncoder.withIndent('  ');
          var convert = encoder.convert(json);
          print(convert);
          _showJsonDialog(convert);
        },
        child: const Icon(Icons.text_snippet_outlined),
      ),
    );
  }
}
