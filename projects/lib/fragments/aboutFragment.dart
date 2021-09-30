import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projects/style/textStyles.dart';
import 'package:projects/style/unorderedListWidget.dart';

class AboutFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Wikimedia Commons Uploader App", style: fragmentTitle),
            Padding(padding: EdgeInsets.only(bottom: 8)),
            Text("Developed by:", style: articleDescription),
            Padding(padding: EdgeInsets.only(bottom: 4)),
            Text("• Fabio Zahner"),
            Text("• Remo Steiner"),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 300,
                child: Image.asset(
                    "assets/media/logos/IFS.png"), // TODO Bc the logos are transparent, they are not readable in dark mode
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 220,
                child: Image.asset("assets/media/logos/OST.png"),
              ),
            )
          ],
        ),
      )),
    );
  }
}
