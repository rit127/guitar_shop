import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guitarfashion/model/FavoriteModel.dart';
import 'package:guitarfashion/model/RewardModel.dart';
import 'package:guitarfashion/utils/Api.dart';
import 'package:guitarfashion/utils/HexColor.dart';
import 'package:guitarfashion/view/home/ProductDetail.dart';

class GiftCard extends StatefulWidget {
  final RewardModel data;
  List<FavoriteModel> listFavorite;
  Function onSubmit;

  GiftCard(this.data, this.listFavorite, this.onSubmit);

  @override
  _GiftCardState createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  @override
  Widget build(BuildContext context) {


    if (widget.data.product == null) {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => ProductDetail(
              widget.data.product.id,
              widget.listFavorite,
              widget.onSubmit,
            ),
          ),
        );
      },
      child: Container(
        height: 150,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border.symmetric(
              vertical: BorderSide(width: 0.5, color: HexColor('#ECEFF0'))),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: 150,
              padding: EdgeInsets.all(8),
              child: CachedNetworkImage(
                imageUrl: Api.mainUrl +
                    widget.data.product.images[0].formats.medium.url,
                imageBuilder: (context, imageProvider) => Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
//                child: Image.network(Api.mainUrl + widget.data.image[0].formats.medium.url),
                ),
                placeholder: (context, url) => Container(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "លេខកូដ: ${widget.data.product.code}",
                  ),
                  Text(
                    '\$${widget.data.product.price}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
//                  height: 35,
//                  width: 35,
                    alignment: Alignment.bottomLeft,
                    child: Row(children: <Widget>[
                      Text(
                        "ពិន្ទុ: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        widget.data.point != null
                            ? widget.data.point.toString()
                            : "0",
                        style: TextStyle(
                          color: HexColor('#FF9D00'),
                          fontSize: 15,
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
