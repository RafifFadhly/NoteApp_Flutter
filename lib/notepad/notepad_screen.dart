import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';
import 'edit_note_screen.dart';

class NotepadScreen extends StatefulWidget {
  const NotepadScreen({super.key});

  @override
  State<NotepadScreen> createState() => _NotepadScreenState();
}

class _NotepadScreenState extends State<NotepadScreen> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final isDarkMode = noteProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '📒 Your Note',
          style: TextStyle(
            color: isDarkMode
                ? Colors.white
                : Colors.black,
          ),
        ),
        backgroundColor: isDarkMode
            ? Colors.black
            : Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), 
          child: Divider(
            color: isDarkMode
                ? Colors.grey
                : Colors.black54, 
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).focusColor),
              child: Text('Ligth Mode'),
            ),
            ListTile(
              title: Text('Toggle Mode'),
              onTap: () {
                noteProvider.toggleMode();
                Navigator.pop(context);
              },
              leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            ),
            Divider(
              color: Colors.white,
            ), // Divider di sini
          ],
        ),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              final note = noteProvider.notes[index];
              return Padding(
                padding: EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    title: Text(
                      note.title,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditNoteScreen(note: note, noteIndex: index),
                        ),
                      );
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        noteProvider.removeNoteAt(index);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditNoteScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
