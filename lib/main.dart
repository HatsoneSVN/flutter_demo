import 'package:flutter/material.dart';
import '../screens/add_note_screen.dart';
import 'package:demo_flutter/items/calendar_widget.dart';

void main() => runApp(NotasApp());

class NotasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Notas con Calendario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListaNotasScreen(),
    );
  }
}

class ListaNotasScreen extends StatefulWidget {
  @override
  _ListaNotasScreenState createState() => _ListaNotasScreenState();
}

class _ListaNotasScreenState extends State<ListaNotasScreen> {
  List<String> notas = ['Nota 1', 'Nota 2'];

  void _addNota(String noteText) {
    setState(() {
      notas.add(noteText);
    });
  }

  void _deleteNota(int index) {
    setState(() {
      notas.removeAt(index);
    });
  }

  void _editNota(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNoteScreen(
          addNoteCallback: (noteText, idx) {
            setState(() {
              notas[idx!] = noteText;
            });
          },
          initialNote: notas[index],
          noteIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Notas'),
      ),
      body: Column(
        children: [
          CalendarWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: notas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    title: Text(
                      notas[index],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Toca para editar o eliminar'),
                    onTap: () => _editNota(index),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteNota(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(
                addNoteCallback: (noteText, idx) {
                  if (idx == null) _addNota(noteText);
                },
              ),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
