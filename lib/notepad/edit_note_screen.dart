import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';
import 'note.dart';

class EditNoteScreen extends StatefulWidget {
  final Note? note;
  final int? noteIndex;

  const EditNoteScreen({Key? key, this.note, this.noteIndex}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController =
        TextEditingController(text: widget.note?.content ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<NoteProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Catatan Baru' : 'Edit Catatan'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final note = Note(
                title: _titleController.text,
                content: _contentController.text,
              );
              if (widget.noteIndex == null) {
                context.read<NoteProvider>().addNote(note);
              } else {
                context
                    .read<NoteProvider>()
                    .updateNoteAt(widget.noteIndex!, note);
              }
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder()
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                textAlignVertical: TextAlignVertical
                    .top, // Mengatur teks terisi dari samping kiri atas
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
    );
  }
}
