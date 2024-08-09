import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:srv_project/providers/auth_provider.dart';
import 'package:srv_project/screens/home_screen.dart';
import 'package:srv_project/screens/login_screen.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: auth.isAuthenticated ? '/home' : '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => LoginScreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => HomeScreen(),
          ),
        ],
      ),
    );
  }
}
