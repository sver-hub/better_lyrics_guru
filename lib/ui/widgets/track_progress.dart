import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../logic/models/track.dart';
import 'progress_widget.dart';

class TrackProgress extends StatelessWidget {
  final Track track;
  final double progress;

  const TrackProgress({@required this.track, @required this.progress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.0, 9.0, 15.0, 9.0),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                  color: Colors.black.withOpacity(0.1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: CachedNetworkImage(
                imageUrl: track.album.imgUrl,
                height: 50.0,
                width: 50.0,
                useOldImageOnUrlChange: true,
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  track.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  track.album.artist.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 6.0),
                ProgressWidget(
                  progress: progress,
                  width: double.infinity,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
