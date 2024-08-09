import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_project/helpers/database_helper.dart';
import 'package:srv_project/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${auth.user?.username ?? 'User'}!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
                context.go('/');
              },
              child: const Text('Logout'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final dbHelper = DatabaseHelper();
                await dbHelper.populateTestProducts(await dbHelper.database);
              },
              child: const Text('Insert products'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final dbHelper = DatabaseHelper();
                await dbHelper.deleteAllProducts(await dbHelper.database);
              },
              child: const Text('Delete products'),
            ),
          ],
        ),
      ),
    );
  }
}
