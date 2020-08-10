import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewProductCard extends StatefulWidget {
  ViewProductCard({
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.basePosition = Alignment.center,
    this.filterQuality = FilterQuality.none,
    this.onTabDown,
    this.imageList,
    this.initialIndex,
    this.scrollDirection = Axis.horizontal,
  }): pageController = PageController(initialPage: initialIndex);


  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final Alignment basePosition;
  final FilterQuality filterQuality;
  final Function onTabDown;
  final List<ProductImage> imageList;
  final int initialIndex;
  final PageController pageController;
  final Axis scrollDirection;

  @override
  _ViewProductCardState createState() => _ViewProductCardState();
}

class _ViewProductCardState extends State<ViewProductCard> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

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
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  loadingChild: loadingImage() ,
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: CachedNetworkImageProvider(Api.mainUrl + widget.imageList[index].url),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
                      maxScale: PhotoViewComputedScale.covered * 1.1,
                      heroAttributes: PhotoViewHeroAttributes(tag: widget.imageList[index].id),
                    );
                  },
                  itemCount: widget.imageList.length,
                  loadingBuilder: widget.loadingBuilder,
                  backgroundDecoration: widget.backgroundDecoration,
                  pageController: widget.pageController,
                  onPageChanged: onPageChanged,
                  scrollDirection: widget.scrollDirection,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "${currentIndex + 1} / ${widget.imageList.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                )
              ],
            ),
//            child: PhotoView(
//              imageProvider: imageProvider,
//              loadingBuilder: loadingBuilder,
//              backgroundDecoration: backgroundDecoration,
//              minScale: minScale,
//              maxScale: maxScale,
//              initialScale: initialScale,
//              basePosition: basePosition,
//              filterQuality: filterQuality,
//              onTapDown: onTabDown,
//            ),
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

  Widget loadingImage () {
    return Center(
      child: Loading(),
    );
  }
}
