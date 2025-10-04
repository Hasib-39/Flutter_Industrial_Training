import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
class NoteEditPage extends ConsumerStatefulWidget {
  final String? noteId;

  const NoteEditPage({super.key, this.noteId});

  @override
  ConsumerState<NoteEditPage> createState() => _NoteEditPageState();
}

class _NoteEditPageState extends ConsumerState<NoteEditPage> {
  late TextEditingController titleController;
  late TextEditingController contentController;
  bool isNewNote = false;

  @override
  void initState() {
    super.initState();
    final note = ref.read(notesProvider.notifier).getNoteById(widget.noteId ?? '');

    if (note != null) {
      titleController = TextEditingController(text: note.title);
      contentController = TextEditingController(text: note.content);
      isNewNote = false;
    } else {
      titleController = TextEditingController();
      contentController = TextEditingController();
      isNewNote = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void saveNote() {
    if (titleController.text.isEmpty && contentController.text.isEmpty) {
      context.pop();
      return;
    }

    if (isNewNote) {
      ref.read(notesProvider.notifier).addNote(
        Note(
          id: widget.noteId!,
          title: titleController.text.isEmpty
              ? 'Untitled'
              : titleController.text,
          content: contentController.text,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      ref.read(notesProvider.notifier).updateNote(
        widget.noteId!,
        titleController.text.isEmpty
            ? 'Untitled'
            : titleController.text,
        contentController.text,
      );
    }
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isNewNote ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                  border: InputBorder.none,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}