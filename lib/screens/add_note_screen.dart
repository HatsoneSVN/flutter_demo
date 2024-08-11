import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  final Function(String, int?) addNoteCallback;
  final String? initialNote;
  final int? noteIndex;

  AddNoteScreen(
      {required this.addNoteCallback, this.initialNote, this.noteIndex});

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  void _saveNote() {
    if (_noteController.text.isNotEmpty) {
      widget.addNoteCallback(_noteController.text, widget.noteIndex);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.noteIndex == null ? 'Agregar Nota' : 'Editar Nota'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: 'Escribe tu nota aquí',
                border: OutlineInputBorder(),
              ),
              maxLines: null, // Make it expandable
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Guardar Nota'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                textStyle: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
