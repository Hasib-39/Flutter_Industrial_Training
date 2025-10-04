import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sembast/sembast.dart';

import '../model/note_model.dart';

final databaseProvider = Provider<Database>((ref) {
  throw UnimplementedError();
});

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.light);

  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }

  void setTheme(ThemeMode mode) {
    state = mode;
  }
}

final fontSizeProvider = StateNotifierProvider<FontSizeNotifier, double>((ref) {
  return FontSizeNotifier();
});

class FontSizeNotifier extends StateNotifier<double> {
  FontSizeNotifier() : super(16.0);

  void setFontSize(double size) {
    state = size;
  }
}

final notesProvider = StateNotifierProvider<NotesNotifier, AsyncValue<List<Note>>>((ref) {
  final database = ref.watch(databaseProvider);
  return NotesNotifier(database);
});

class NotesNotifier extends StateNotifier<AsyncValue<List<Note>>> {
  final Database _database;
  final _store = StoreRef<String, Map<String, dynamic>>.main();

  NotesNotifier(this._database) : super(const AsyncValue.loading()) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    state = const AsyncValue.loading();
    try {
      final records = await _store.find(_database);
      final notes = records.map((record) => Note.fromJson(record.value)).toList();
      notes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = AsyncValue.data(notes);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addNote(Note note) async {
    await _store.record(note.id).put(_database, note.toJson());
    await _loadNotes();
  }

  Future<void> updateNote(String id, String title, String content) async {
    final record = await _store.record(id).get(_database);
    if (record != null) {
      final note = Note.fromJson(record);
      final updatedNote = note.copyWith(title: title, content: content);
      await _store.record(id).put(_database, updatedNote.toJson());
      await _loadNotes();
    }
  }

  Future<void> deleteNote(String id) async {
    await _store.record(id).delete(_database);
    await _loadNotes();
  }

  Note? getNoteById(String id) {
    return state.when(
      data: (notes) {
        try {
          return notes.firstWhere((note) => note.id == id);
        } catch (e) {
          return null;
        }
      },
      loading: () => null,
      error: (_, __) => null,
    );
  }
}