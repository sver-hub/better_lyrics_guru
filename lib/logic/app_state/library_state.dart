part of 'app_state.dart';

enum _LibraryStateValue { NEEDS_DOWLOAD, LOADING, READY }

class LibraryState extends StateNotifier<_LibraryStateValue> {
  LibraryState() : super(_LibraryStateValue.READY);

  bool get needsDownload => state == _LibraryStateValue.NEEDS_DOWLOAD;
  bool get isReady => state == _LibraryStateValue.READY;
  bool get isLoading => state == _LibraryStateValue.LOADING;

  void setNeedsDownload() => state = _LibraryStateValue.NEEDS_DOWLOAD;
  void setReady() => state = _LibraryStateValue.READY;
  void setLoading() => state = _LibraryStateValue.LOADING;
}
