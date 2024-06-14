// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:notepad/main.dart';

void main() {
  testWidgets('Add new note test', (WidgetTester tester) async {
    // Bangun aplikasi dan picu frame.
    await tester.pumpWidget(MyApp());

    // Ketuk tombol tambah catatan.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Masukkan judul dan isi catatan.
    await tester.enterText(find.byType(TextField).at(0), 'Judul Catatan');
    await tester.enterText(find.byType(TextField).at(1), 'Isi Catatan');
    await tester.tap(find.text('Simpan'));
    await tester.pump();

    // Verifikasi bahwa catatan baru ditambahkan.
    expect(find.text('Judul Catatan'), findsOneWidget);
    expect(find.text('Isi Catatan'), findsOneWidget);
  });
}

