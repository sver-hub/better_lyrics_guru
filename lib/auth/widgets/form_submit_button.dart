import 'package:flutter/material.dart';

import '../../ui/widgets/custom_flat_button.dart';

class FormSubmitButton extends CustomFlatButton {
  FormSubmitButton({
    Key key,
    String text,
    bool loading = false,
    VoidCallback onTap,
  }) : super(
          key: key,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          height: 44.0,
          color: Colors.indigo,
          loading: loading,
          onTap: onTap,
        );
}
