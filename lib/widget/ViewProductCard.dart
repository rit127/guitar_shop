import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ViewProductCard extends StatelessWidget {
  const ViewProductCard({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.basePosition = Alignment.center,
    this.filterQuality = FilterQuality.none,
    this.onTabDown,
  });

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;
  final FilterQuality filterQuality;
  final Function onTabDown;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height,
            ),
            child: PhotoView(
              imageProvider: imageProvider,
              loadingBuilder: loadingBuilder,
              backgroundDecoration: backgroundDecoration,
              minScale: minScale,
              maxScale: maxScale,
              initialScale: initialScale,
              basePosition: basePosition,
              filterQuality: filterQuality,
              onTapDown: onTabDown,
            ),
          ),
          Positioned(
            left: 12,
            top: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
