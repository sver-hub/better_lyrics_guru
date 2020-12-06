import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:lyrics_guru/auth/services/firebase_auth_service.dart';
import 'package:lyrics_guru/services/spotify/spotify_service.dart';

final authService = Provider<AuthService>(
  (ref) => FirebaseAuthService(ref.read(spotifyService)),
);

abstract class AuthService {
  Future<User> currentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<User> signInWithGoogle();
  Future<void> signOut();
  Stream<User> get authStateChanges;
  void dispose();
}
