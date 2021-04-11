import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageCoverWidget extends StatelessWidget {
  const CustomImageCoverWidget(
      {Key key, this.width, this.height, @required this.imgUrl, this.caption})
      : super(key: key);

  final double width;
  final double height;
  final String imgUrl;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          width: width ?? screenWidth,
          height: height ?? screenWidth,
          child: Image(
            image: CachedNetworkImageProvider(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: height ?? screenWidth,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset(0.5, 0.7),
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.0),
                Colors.black.withOpacity(0.4),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 10.0,
          child: Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () => Navigator.of(context).pop(),
              ),
              SizedBox(width: 20.0),
              SizedBox(
                width: (width ?? screenWidth) - 100,
                child: Text(
                  caption ?? '',
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
