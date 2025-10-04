import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/provider.dart';

class NotesListPage extends ConsumerWidget {
  const NotesListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: notesAsync.when(
        data: (notes) {
          if (notes.isEmpty) {
            return const Center(
              child: Text('No notes yet. Create one!'),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListTile(
                  title: Text(
                    note.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize + 2,
                    ),
                  ),
                  subtitle: Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      ref.read(notesProvider.notifier).deleteNote(note.id);
                    },
                  ),
                  onTap: () => context.push('/note/${note.id}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newId = DateTime.now().millisecondsSinceEpoch.toString();
          context.push('/note/$newId');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}