import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../logic/models/word.dart';

class WordCarousel extends StatelessWidget {
  final List<WordCarouselItem> _items;

  const WordCarousel({@required List<WordCarouselItem> items}) : _items = items;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 7),
        viewportFraction: 1.0,
        height: 202.0 + 32,
      ),
      items: [
        for (final item in _items)
          Container(
            padding: const EdgeInsets.all(22.0),
            margin:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 16.0),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    item.artistImageUrl,
                  ),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.40), BlendMode.srcOver),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4.0,
                  offset: Offset(0, 1.0),
                  color: Colors.black.withOpacity(0.15),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.word.word,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Text(
                    item.word.definition,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.white,
                        ),
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }
}

class WordCarouselItem {
  final Word word;
  final String artistImageUrl;

  const WordCarouselItem({@required this.word, @required this.artistImageUrl});
}
