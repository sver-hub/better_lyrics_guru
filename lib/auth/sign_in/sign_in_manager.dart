import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:meta/meta.dart';

import '../services/auth_service.dart';

final signInManager =
    Provider.family<SignInManager, ValueNotifier<bool>>((ref, isLoading) {
  final auth = ref.read(authService);
  return SignInManager(auth: auth, isLoading: isLoading);
});

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }
}
