import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guitarfashion/bloc/CategoryBloc.dart';
import 'package:guitarfashion/event/CategoryEvent.dart';
import 'package:guitarfashion/model/CategoryMenu.dart';
import 'package:guitarfashion/state/CategoryState.dart';
import 'package:guitarfashion/utils/AppColor.dart';
import 'package:guitarfashion/utils/HexColor.dart';

class FilterBrand extends StatefulWidget {
  final int categoryId;
  final List<CategoryMenu> myBrands;

  FilterBrand(this.categoryId, this.myBrands);

  @override
  _FilterBrandState createState() => _FilterBrandState();
}

class _FilterBrandState extends State<FilterBrand> {
  Map<int, int> checkItem = new Map();
  bool isCheckAll = false;
  bool isFilter = false;
  String categoryName = "";

  @override
  void initState() {
    super.initState();
  }

  onCheckAll() async {
    setState(() {
      if (isCheckAll == false) {
        checkItem = new Map();
      }

      isCheckAll = !isCheckAll;
    });
  }

  onChecked(int brandId) {
    if(!isCheckAll) {
      setState(() {
        if (checkItem[brandId] != null) {
          checkItem.removeWhere((key, value) => brandId == key);
        } else {
          checkItem = new Map();
          checkItem[brandId] = brandId;
        }

        categoryName = widget.myBrands.firstWhere((element) => element.id == brandId, orElse: null).name;
      });
    }else {
      setState(() {
        isCheckAll = !isCheckAll;

        if (checkItem[brandId] != null) {
          checkItem.removeWhere((key, value) => brandId == key);
        } else {
          checkItem = new Map();
          checkItem[brandId] = brandId;
        }

        categoryName = widget.myBrands.firstWhere((element) => element.id == brandId, orElse: null).name;
      });
    }
    print("checked ${checkItem.values}");
  }

  onFilter() async {

    if (isCheckAll) {
      context.bloc<CategoryBloc>().add(LoadCategory(widget.categoryId));
    } else {
      context
          .bloc<CategoryBloc>()
          .add(LoadCategoryByBrands(widget.categoryId, checkItem, categoryName));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (BuildContext context, CategoryState state) {
//        print("isFilter ${state.isFilter}");
        print("isFilter Name ${state.categoryName}");

        return Drawer(
          child: ListView(
            children: <Widget>[
              endDrawerHeader(),
//          filterResultHeader(),
              ListView.separated(
                itemCount: widget.myBrands.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      index == 0 ? ListTile(
                        onTap: () {
                          if (isCheckAll == false) {
                            checkItem = new Map();
                          }
                          isCheckAll = !isCheckAll;

                          state.listProduct = null;

                          onFilter();
                        },
                        title: Text("មើលទាំងអស់"),
                        trailing: isCheckAll ? Icon(Icons.check) : null,
                      ) : Container(),
                      ListTile(
                        onTap: () => onChecked(widget.myBrands[index].id),
                        title: Text(widget.myBrands[index].name),
                        trailing: !isCheckAll
                            ? checkItem[widget.myBrands[index].id] != null
                                ? Icon(Icons.check)
                                : null
                            : Icon(Icons.check),
                      ),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Divider(
                      height: 2,
                      thickness: 1,
                    ),
                  );
                },
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                margin: EdgeInsets.only(
                    top: 30),
                child: FlatButton(
                  color: AppColor.guitarShopColor,
                  onPressed: onFilter,
                  child: Text(
                    "យល់ព្រម",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget endDrawerHeader() {
    return Container(
//      height: 50,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/filter.png',
            height: 25,
          ),
          SizedBox(width: 12),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              "កំណត់ការមើលតាម Brand",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget filterResultHeader() {
    return Container(
      color: Colors.red,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("JOHN BROWN"),
          Divider(),
          Text("JOHN BROWN"),
          Text(""),
          Divider(
            height: 20,
            thickness: 3,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
