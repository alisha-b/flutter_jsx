import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jsx/flutter_jsx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FullscreenImageView extends StatelessWidget {

  final ImageProvider imageProvider;

  const FullscreenImageView(this.imageProvider);

  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Stack(
      children: <Widget>[
        ExtendedImage(
            image: imageProvider,
            width: mediaQuery.size.width,
            height: mediaQuery.size.height,
            fit: BoxFit.fitWidth,
            mode: ExtendedImageMode.gesture
          //cancelToken: cancellationToken,
        ),
        Positioned(
          top: 5 + mediaQuery.padding.top,
          right: 5,
          child: Container(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.all(10),
              color: Colors.black54,
              onPressed: () => Navigator.of(context).pop(),
              child: JSX(
                '<Close/>',
                display: DisplayStyle.inline,
                stylesheet: {
                  'Close': JSXStylesheet(
                      padding: EdgeInsets.only(bottom: 5)
                  )
                },
                widgets: {
                  'Close': Icon(FontAwesomeIcons.times, color: Colors.white, size: 26)
                },
              )
            )
          ),
        ),
      ]
    );
  }
}
