import 'dart:convert';

import 'package:example/_example_document.dart';
import 'package:flutter/material.dart';
import 'package:super_editor/super_editor.dart';
import 'package:super_editor_json/ext/document_parser_ext.dart';
import 'package:super_editor_json/parser/json/document_json_parser.dart';

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
    document = DocumentJson.fromJson(jsonDocument);
    editor = DocumentEditor(document: document as MutableDocument);
    super.initState();
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // var json = document.toJson(); //save json

          //Use formatted JSON data
          var json = documentSerialize(document);
          var encoder  = const JsonEncoder.withIndent('  ');
          _showJsonDialog(encoder.convert(json));
        },
        child: const Icon(Icons.text_snippet_outlined),
      ),
    );
  }
}
