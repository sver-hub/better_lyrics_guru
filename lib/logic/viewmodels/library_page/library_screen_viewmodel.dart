import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../database/db.dart';
import '../../../database/moor_database.dart';
import '../../../services/library/library_service.dart';
import '../../../services/notification/notification.dart';
import '../../app_state/app_state.dart';
import '../../models/artist.dart';

final libraryScreenViewModel =
    ChangeNotifierProvider<LibraryScreenViewModel>((ref) {
  final libServ = ref.read(libraryService);
  final libState = ref.watch(libraryState);
  final notif = ref.read(notification);
  return LibraryScreenViewModel(libServ, libState, notif);
});

class LibraryScreenViewModel extends ChangeNotifier {
  final _artistDao = db<ArtistDao>();
  final LibraryService _libraryService;
  final LibraryState _libraryState;
  final FlutterLocalNotificationsPlugin _notification;

  List<Artist> _artists = [];
  List<Artist> get artists => _artists;

  LibraryScreenViewModel(
      this._libraryService, this._libraryState, this._notification) {
    loadData();
  }

  LibraryState get state => _libraryState;

  void loadData() async {
    _artistDao.watchAllArtists().listen((updatedList) {
      _artists = updatedList;
      notifyListeners();
    });
    if (_libraryState.needsDownload) {
      dowloadLibrary();
    }
  }

  void dowloadLibrary() async {
    _libraryState.setLoading();
    await _libraryService.loadFavouriteTracks();
    _libraryState.setReady();
  }

  void downloadLyrics() async {
    final message = 'Downloading lyrics...';

    _libraryState.setLoading();
    await _showDownloadNotification(message, 0, 100);
    int total = 0;
    _libraryService.loadLyrics().listen((remaining) async {
      if (total == 0) total = remaining;
      final done = total - remaining;
      await _showDownloadNotification(message, done, total);
      if (remaining == 0) {
        _notification.cancel(0);
        _libraryState.setReady();
      }
    });
  }

  Future _showDownloadNotification(
      String message, int progress, int total) async {
    final androidDetails = AndroidNotificationDetails(
        'lib', 'library', 'library',
        playSound: false,
        enableVibration: false,
        vibrationPattern: Int64List(10),
        showProgress: true,
        progress: progress,
        maxProgress: total);
    final iosDetails = IOSNotificationDetails();
    final generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _notification.show(0, message, '', generalNotificationDetails);
  }
}
