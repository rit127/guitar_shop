import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:guitarfashion/bloc/ProductBloc.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/LocationModel.dart';
import 'package:guitarfashion/model/Product.dart';
import 'package:guitarfashion/res.dart';
import 'package:guitarfashion/state/ProductState.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/AppColor.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/utils/Loading.dart';
import 'package:guitarfashion/widget/ViewProductCard.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  int product;
  List<FavoriteModel> listFavorite;
  Function onSubmit;

  ProductDetail(this.product, this.listFavorite, this.onSubmit);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  SwiperController _controller;
  Product productDetail;
  LocationModel locationModel;
  bool isReady = false;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = new SwiperController();
    getLocation();
  }

  getLocation() async {
    var response = await http.get(Api.location);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      LocationModel myLocation = LocationModel.fromJson(responseData[0]);

      locationModel = myLocation;

      await getProductDetail();
    }
  }

  getProductDetail() async {
    String requestUrl = Api.product + "/${widget.product}";

    print("requestUrl $requestUrl");

    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      Product myPro = Product.fromJson(data);

      productDetail = myPro;

      setState(() {
        isReady = true;
      });
    }
  }

  getFavorite(int id) {
    print(id);

    if (widget.listFavorite != null) {
      FavoriteModel myFavor = widget.listFavorite
          .firstWhere((element) => id == element.id, orElse: () => null);

      print(widget.listFavorite);

      if (myFavor != null) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (BuildContext context, ProductState state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: HexColor("#ECEFF0"),
            title: isReady ? Text(productDetail.category.name) : Container(),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notification');
                },
                icon: Icon(Icons.notifications),
              ),
            ],
          ),
          body: productDetail != null
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        productImage(),
                        _productDetail(),
                        Divider(thickness: 1),
                        contactUs(),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: Loading(),
                ),
        );
      },
    );
  }

  Widget productImage() {
    return Container(
      padding: EdgeInsets.all(15),
      height: 320,
//      width: double.infinity,
//      color: Colors.black,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            child: Swiper(
              curve: Curves.easeInOut,
              controller: _controller,
              itemCount: productDetail.image.length,
              loop: false,
              outer: true,
              index: currentIndex,
              onIndexChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _imageCard(productDetail.image[index].url);
              },
//              autoplay: true,
//              pagination: new SwiperPagination(),
//              control: new SwiperControl(),
//              itemHeight: 350,
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: widget.onSubmit,
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
//                  color: Colors.red,
                  border: Border.all(
                      width: 1, color: Color(getColorHexFromStr('#ECEFF0'))),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Icon(
                  Icons.favorite,
                  color: getFavorite(widget.product)
                      ? HexColor('#E23B51')
                      : Colors.grey,
                  size: 25,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Text(
                "${currentIndex + 1} / ${productDetail.image.length}",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageCard(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: Api.mainUrl + imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewProductCard(
                  maxScale: PhotoViewComputedScale.contained * 2,
                  initialScale: PhotoViewComputedScale.contained * 1,
                  minScale: PhotoViewComputedScale.contained * 0.5,
                  imageProvider: imageProvider,
                  imageList: productDetail.image,
                  backgroundDecoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  initialIndex: currentIndex,
//                        onTabDown: (test) {
//                          Navigator.pop(context);
//                        },
                ),
              ),
            );
          },
//          child: Image.network(Api.mainUrl + productDetail.image[0].url),
        ),
      ),
      placeholder: (context, url) => Container(
        height: 300,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _productDetail() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "លេខកូដ: ${productDetail.code}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          Text(
            "\$${productDetail.price}",
            style: TextStyle(
              fontSize: 28,
              color: HexColor('#E23B51'),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget contactUs() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "សូមទំនាក់ទំនងយើងខ្ញុំតាមពត៌មានខាងក្រោម៖",
            style: TextStyle(
              fontSize: 15,
              color: AppColor.guitarShopColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/details/location.png',
                height: 18,
              ),
              SizedBox(width: 12),
              Expanded(
                child: locationModel != null
                    ? Text(
                        "${locationModel.address}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    : Container(),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Text(
//                  "${locationModel.address}",
//                  style: TextStyle(
//                    fontSize: 15,
//                  ),
//                ),
//                Text(
//                  "- ហ្គីតា​ | ផ្ទះលេខ266-268 Eo",
//                  style: TextStyle(
//                    fontSize: 15,
//                  ),
//                ),
//                Text(
//                  "- ហ្គីតា​ || ផ្ទះលេខ256-268",
//                  style: TextStyle(
//                    fontSize: 15,
//                  ),
//                ),
//                Text(
//                  "ផ្ទះលេខ128 ( ផ្លូវកម្ពុជាក្រោម )",
//                  style: TextStyle(
//                    fontSize: 15,
//                  ),
//                ),
//                Text(
//                  "ខាងកើតស្តុបណានជីង150 m ( ខាងស្តាំដៃ )",
//                  style: TextStyle(
//                    fontSize: 15,
//                  ),
//                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/details/contact.png',
                height: 22,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${locationModel.phone}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                'images/details/car.png',
                height: 18,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  "${locationModel.delivery}​",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OneTapWrapper extends StatelessWidget {
  const OneTapWrapper({
    this.imageProvider,
  });

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: GestureDetector(
          onTapDown: (_) {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: imageProvider,
          ),
        ),
      ),
    );
  }
}
