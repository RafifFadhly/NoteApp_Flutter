import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notepad/notepad_screen.dart';
import 'notepad/note_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) {
        return MaterialApp(
          title: 'Notepaed',
          theme: ThemeData(
            brightness: noteProvider.isDarkMode ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.blue,
          ),
          debugShowCheckedModeBanner: false,
          home: NotepadScreen(),
        );
      },
    );
  }
}
