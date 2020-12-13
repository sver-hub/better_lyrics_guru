import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';

import '../../../logic/app_state/app_state.dart';

class ProfileScreen extends HookWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = useProvider(currentUser);
    final _nameController = useTextEditingController(
      text: _user.name,
    );
    _nameController.addListener(() {
      _user.name = _nameController.text;
    });

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: CachedNetworkImageProvider(
              _user.imgUrl,
            ),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: _nameController,
          ),
        ],
      ),
    );
  }
}
