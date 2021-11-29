import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:projects/controller/imageService.dart';
import 'package:projects/view/commonsUploadFragment.dart';
import 'package:projects/pages/menuDrawer.dart';
import 'package:provider/provider.dart';

// TODO? tabbed view? for more information (see todos below)
// TODO add a View in Web/App function (requires QTag probably)
// TODO display short description (and maybe more) through QTag -> Wikimedia

class StatefulViewCategoryFragment extends StatefulWidget {
  final Marker marker;
  StatefulViewCategoryFragment(this.marker, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ViewCategoryFragment(marker);
}

class _ViewCategoryFragment extends State<StatefulViewCategoryFragment> {
  final Marker _marker;
  _ViewCategoryFragment(this._marker);
  InformationCollector collector = new InformationCollector();

  @override
  Widget build(BuildContext context) {
    var categoryTitle =
        _marker.key.toString().substring(3, _marker.key.toString().length - 3);
    List<Widget> cards = List.empty(growable: true);

    return new Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder(
              future: ImageService().getCategoryImages(categoryTitle, 400,
                  10), // TODO? at the moment only 10 first pics get shown, maybe someting like "load more" at the end?
              builder: (BuildContext context,
                  AsyncSnapshot<List<ImageURL>> snapshot) {
                // TODO Loading Indicator for Images as they might take quite a long time to load
                if (snapshot.hasData) {
                  List<ImageURL> images = snapshot.data!;
                  cards.clear();
                  for (int i = 0; i < images.length; i++) {
                    cards.add(new Card(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              images[i].url,
                              fit: BoxFit.fitWidth,
                            ), // TODO Implement fullscreen viewer for Images (on image click)
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(images[i].name,
                                  style:
                                      TextStyle(fontStyle: FontStyle.italic)),
                            ),
                          ],
                        ),
                      ),
                    ));
                  }
                  cards.add(Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                  ));
                  return Expanded(
                      child: ListView(
                    padding: EdgeInsets.all(8),
                    children: cards,
                  ));
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          collector.preFillContent = categoryTitle;
          Navigator.pop(context);
          Provider.of<ViewSwitcher>(context, listen: false).viewIndex = 2;
        },
        label: Text("Upload to this Category"),
        icon: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
