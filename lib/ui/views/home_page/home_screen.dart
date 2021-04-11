import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:lyrics_guru/auth/constants/strings.dart';
import 'package:lyrics_guru/auth/services/auth_service.dart';
import 'package:lyrics_guru/ui/widgets/platform_alert_dialog.dart';
import 'package:lyrics_guru/ui/widgets/platform_exception_alert_dialog.dart';

import '../../../logic/app_state/app_state.dart';
import '../../../logic/models/album.dart';
import '../../../logic/models/artist.dart';
import '../../../logic/models/track.dart';
import '../../../logic/models/word.dart';
import '../../theme/palette.dart';
import '../../widgets/widgets.dart';

class HomePage extends HookWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      await context.read(authService).signOut();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: Strings.logoutFailed,
        exception: e,
      ).show(context);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: Strings.logout,
      content: Strings.logoutAreYouSure,
      cancelActionText: Strings.cancel,
      defaultActionText: Strings.logout,
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(currentUser);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.only(top: 44),
        children: [
          _buildAppBar(context),
          _buildHeader(context, _user),
          _buildWordCarousel(),
          _buildYourProgress(context),
          _buildQuickQuizButton(context),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => print('settings'),
            onLongPress: () => _confirmSignOut(context),
            child: Icon(Icons.settings),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, CurrentUser user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Howdy, ' + user.name + '!',
            style: Theme.of(context).textTheme.headline3,
          ),
          SizedBox(height: 12.0),
          Text(
            'You know 100% of your songs\' lyrics!',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Widget _buildWordCarousel() {
    return WordCarousel(
      items: [
        WordCarouselItem(
          word: Word(
              word: 'Affliction',
              definition: 'A state of pain, suffering, distress or agony.'),
          artistImageUrl:
              'https://i.scdn.co/image/5b722d9ae6f94ef7742f19531d2668866d418043',
        ),
        WordCarouselItem(
          word: Word(
              word: 'Affliction',
              definition: 'A state of pain, suffering, distress or agony.'),
          artistImageUrl:
              'https://i.scdn.co/image/5b722d9ae6f94ef7742f19531d2668866d418043',
        ),
      ],
    );
  }

  Widget _buildYourProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
          child: Text(
            'Your progress',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
          child: Column(
            children: [
              ...tracks,
              SizedBox(height: 5.0),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () => print('View progress'),
                    child: Text(
                      'Veiw all',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(width: 15.0)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickQuizButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Palette.blue),
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(
                  horizontal: 70.0,
                  vertical: 15.0,
                ),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            onPressed: () => print('quick quiz'),
            child: Text(
              'Quick quiz',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

final tracks = [
  TrackProgress(
    track: Track(
      id: '',
      album: Album(
        id: '',
        name: '',
        imgUrl:
            'https://i.scdn.co/image/ab67616d0000b273e23bc7f792a3f102a3b4f5ff',
        releaseDate: null,
        artist: Artist(id: '', name: 'Silent Planet', imgUrl: ''),
      ),
      name: 'Orphan',
      trackNumber: 1,
      lyrics: '',
    ),
    progress: 0.8,
  ),
  TrackProgress(
    track: Track(
      id: '',
      album: Album(
        id: '',
        name: '',
        imgUrl:
            'https://i.scdn.co/image/ab67616d0000b273736145b97bab8fa92cb6113f',
        releaseDate: null,
        artist: Artist(id: '', name: 'Bring Me the Horizon', imgUrl: ''),
      ),
      name: 'Doomed',
      trackNumber: 1,
      lyrics: '',
    ),
    progress: 0.5,
  ),
  TrackProgress(
    track: Track(
      id: '',
      album: Album(
        id: '',
        name: '',
        imgUrl:
            'https://i.scdn.co/image/ab67616d00001e02101232ffd5af0e3c37e2c528',
        releaseDate: null,
        artist: Artist(id: '', name: 'Loathe', imgUrl: ''),
      ),
      name:
          'Heavy Is the Head That Falls with the Weight of a Thousand Thoughts',
      trackNumber: 1,
      lyrics: '',
    ),
    progress: 0.3,
  ),
];
