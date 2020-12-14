import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/app_state/app_state.dart';
import '../../../logic/models/album.dart';
import '../../../logic/models/artist.dart';
import '../../../logic/models/track.dart';
import '../../../logic/models/word.dart';
import '../../theme/palette.dart';
import '../../widgets/widgets.dart';

class HomePage extends HookWidget {
  // Future<void> _signOut(BuildContext context) async {
  //   try {
  //     await context.read(authService).signOut();
  //   } on PlatformException catch (e) {
  //     await PlatformExceptionAlertDialog(
  //       title: Strings.logoutFailed,
  //       exception: e,
  //     ).show(context);
  //   }
  // }

  // Future<void> _confirmSignOut(BuildContext context) async {
  //   final didRequestSignOut = await PlatformAlertDialog(
  //     title: Strings.logout,
  //     content: Strings.logoutAreYouSure,
  //     cancelActionText: Strings.cancel,
  //     defaultActionText: Strings.logout,
  //   ).show(context);
  //   if (didRequestSignOut == true) {
  //     _signOut(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(currentUser);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          SafeArea(
            minimum: EdgeInsets.only(top: 44.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: _buildAppBar(context),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Howdy, ' + _user.name + '!',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 12.0),
                Text(
                  'You know 100% of your songs\' lyrics!',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ],
            ),
          ),
          WordCarousel(
            items: [
              WordCarouselItem(
                word: Word(
                    word: 'Affliction',
                    definition:
                        'A state of pain, suffering, distress or agony.'),
                artistImageUrl:
                    'https://i.scdn.co/image/5b722d9ae6f94ef7742f19531d2668866d418043',
              ),
              WordCarouselItem(
                word: Word(
                    word: 'Sempiternal',
                    definition:
                        'Everlasting, that is, having infinite temporal duration (as opposed to eternal: outside time and thus lacking temporal duration altogether).'),
                artistImageUrl:
                    'https://i.scdn.co/image/33716e651af1bb27db6945b52e50cb5aef2fa75b',
              ),
              WordCarouselItem(
                word: Word(
                    word: 'Apostate',
                    definition:
                        'One who has abandoned one\'s religious faith, a political party, one\'s principles, or a cause.'),
                artistImageUrl:
                    'https://i.scdn.co/image/2b843ff47a663faefc277ccea2eb0671ba076f66',
              ),
              WordCarouselItem(
                word: Word(
                    word: 'Tremble',
                    definition:
                        'To shake involuntarily, as from excitement or anger; quake.'),
                artistImageUrl:
                    'https://i.scdn.co/image/01f5cbf80e2ad4bf755b7ca4407da62eaf13a88f',
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            child: Text(
              'Your progress',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              children: [
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
                      artist: Artist(
                          id: '', name: 'Bring Me the Horizon', imgUrl: ''),
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
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0),
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
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => print('settings'),
          child: SvgPicture.asset(
            'assets/icons/settings.svg',
            width: 22.0,
            height: 22.0,
          ),
        )
      ],
    );
  }
}
