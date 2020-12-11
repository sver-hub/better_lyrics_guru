import 'package:flutter/material.dart';
import '../../../logic/models/track.dart';

class TrackScreen extends StatelessWidget {
  final Track track;

  const TrackScreen({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 20),
            child: _buildReturn(context),
          ),
          _buildName(),
          Divider(color: Colors.white70, thickness: 1),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: _buildLyrics(),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildReturn(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 80,
          child: Text(
            'Back to ' + track.album.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              track.name,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'By ' + track.album.artist.name,
              style: TextStyle(
                color: Colors.white60,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLyrics() {
    return Column(
      children: [
        ..._getLines(track.lyrics).map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                e,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<String> _getLines(String text) {
    if (text == null)
      return [
        'Either This Track Is Instrumental',
        'Or Lyrics Are Not Accessible'
      ];
    return text.split('\n');
  }
}
