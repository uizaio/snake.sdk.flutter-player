import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello_word/lib/common/const/dimen_constants.dart';
import 'package:hello_word/lib/util/uI_utils.dart';

//https://karthikponnam.medium.com/flutter-loadmore-in-listview-23820612907d
class ListViewLoadMoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIUtils.getAppBar(
        "ListViewLoadMoreScreen",
        () {
          Get.back();
        },
        null,
      ),
      body: ListTileWidget(),
    );
  }
}

class ListTileWidget extends StatefulWidget {
  ListTileWidget({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  _ListTileWidgetState createState() => new _ListTileWidgetState();
}

class _ListTileWidgetState extends State<ListTileWidget> {
  int present = 0;
  int perPage = 15;

  final originalItems = List<String>.generate(10000, (i) => "Item $i");
  var items = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      items.addAll(originalItems.getRange(present, present + perPage));
      present = present + perPage;
    });
  }

  void loadMore() {
    print("loadMore present $present, perPage $perPage");
    setState(() {
      if ((present + perPage) > originalItems.length) {
        items.addAll(originalItems.getRange(present, originalItems.length));
      } else {
        items.addAll(originalItems.getRange(present, present + perPage));
      }
      present = present + perPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            // loadMore();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: (present <= originalItems.length)
              ? items.length + 1
              : items.length,
          itemBuilder: (context, index) {
            return (index == items.length)
                ? Container(
                    padding: EdgeInsets.all(DimenConstants.marginPaddingMedium),
                    child: UIUtils.getButton(
                      "Load More",
                      () {
                        loadMore();
                      },
                    ),
                  )
                : ListTile(
                    title: Text('${items[index]}'),
                  );
          },
        ),
      ),
    );
  }
}
