import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Constants.dart';

var getBusinessValue;

class ActionSheet {
  Widget actionSheet(
      BuildContext context, {
        Function onCamera,
        Function onGallery,
        String text
      }) {
    return CupertinoActionSheet(
      title: Text(
        text,

      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            onCamera();
           // finish(context);
          },
          child: Text('Camera', ),
          isDefaultAction: true,
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            onGallery();
           /// finish(context);
          },
          child: Text('Gallery', ),
          isDefaultAction: true,
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
          onPressed: () {
          //  finish(context);
          },
          child: Text(
            'Cancel',

          )),
    );
  }
}

