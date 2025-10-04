import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/provider.dart';


class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final fontSize = ref.watch(fontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Appearance',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Light Mode'),
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeProvider.notifier).setTheme(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('Dark Mode'),
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeProvider.notifier).setTheme(value);
              }
            },
          ),
          RadioListTile<ThemeMode>(
            title: const Text('System Default'),
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (value) {
              if (value != null) {
                ref.read(themeProvider.notifier).setTheme(value);
              }
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Font Size',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Preview:'),
                    Text(
                      'Sample Text',
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('A', style: TextStyle(fontSize: 12)),
                    Expanded(
                      child: Slider(
                        value: fontSize,
                        min: 12.0,
                        max: 24.0,
                        divisions: 12,
                        label: fontSize.toStringAsFixed(0),
                        onChanged: (value) {
                          ref.read(fontSizeProvider.notifier).setFontSize(value);
                        },
                      ),
                    ),
                    const Text('A', style: TextStyle(fontSize: 24)),
                  ],
                ),
                Center(
                  child: Text(
                    '${fontSize.toStringAsFixed(0)} pt',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            subtitle: const Text('Notes App v1.0'),
          ),
        ],
      ),
    );
  }
}