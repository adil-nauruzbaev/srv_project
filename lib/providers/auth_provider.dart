import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());

  void login(String username, String password) {
    state = AuthState(user: User(username: username));
  }

  void logout() {
    state = AuthState();
  }
}

class AuthState {
  final User? user;

  AuthState({this.user});

  bool get isAuthenticated => user != null;
}

class User {
  final String username;

  User({required this.username});
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
