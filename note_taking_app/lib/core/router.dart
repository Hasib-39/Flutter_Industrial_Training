import 'package:go_router/go_router.dart';

import '../screens/note_edit_screen.dart';
import '../screens/note_list_screen.dart';
import '../screens/settings_screen.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NotesListPage(),
    ),
    GoRoute(
      path: '/note/:id',
      builder: (context, state) {
        final id = state.pathParameters['id'];
        return NoteEditPage(noteId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);