import 'dart:core';

import 'package:flutter/material.dart';
import 'package:projects/style/textStyles.dart' as customStyles;

final titleFont = new TextStyle(height: 30);

class HomeFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var articleList = new ArticleList();
    articleList.clear();

    // ----- Add Articles below -----

    articleList.add(new Article(
        title: "Title 1",
        description: "sdf sdaf sdafkjklsdaf sadlökfjsaöldf sdasafsfad"
    ));
    articleList.add(new Article(
        title: "Title 3",
        description: "sdf sdaf sdafkjklsdaf sadlökfjssda fsad fsafsda fsa fsdfa dfsa fsadf sad faöldf sdasafsfad"
    ));
    articleList.add(new Article(
      title: "title 3",
      description: "desciription sadjf sadf",
      image: Image.network("https://www.brownweinraub.com/wp-content/uploads/2017/09/placeholder.jpg")
    ));
    articleList.add(new Article(
        title: "title 4",
        description: "desciription sadjf sadf"
    ));

    // ------------------------------


    return new Center(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Row(
                children: articleList.generateLists(context, articleList.generateCards(context)),
              ),
            )
          ),
        ],
      )
    );
  }
}

class ArticleList {
  static List<Article> articles = new List.empty(growable: true);

  add(Article article) {
    articles.add(article);
  }

  clear () {
    articles.clear();
  }

  List<Card> generateCards (BuildContext context) {
    List<Card> cards = new List.empty(growable: true);
    List<Article> articles = ArticleList.articles;

    if(articles.length == 0){
      print("No articles to be displayed");
      articles.add(Article(title: "No articles", description: "add a article to be displayed"));
    }

    for(Article article in articles) {
      cards.add(
          new Card(
              child: GestureDetector(
                  onTap: () {
                    if (article.onTap != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => article.onTap!),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.fromLTRB(02, 2, 0, 12),
                            child: Text(
                              article.title,
                              style: customStyles.articleTitle,
                            )
                        ),
                        if(article.image != null) article.image as Widget,
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            article.description,
                            style: customStyles.articleDescription,
                          ),
                        )
                      ],
                    ),
                  )
              )
          )
      );
    }
    return cards;
  }

  List<Expanded> generateLists (BuildContext context, List<Card> cards) { // This is ugly, but at least it isn't redundant
    List<Expanded> returnList = new List.empty(growable: true);
    List<Card> cardList1 = new List.empty(growable: true);
    List<Card> cardList2 = new List.empty(growable: true);
    for(int i = 0; i < cards.length; i = i+2) {
      cardList1.add(cards[i]);
      if (i+1 < cards.length) {
        cardList2.add(cards[i+1]);
      }
    }
    List<List<Card>> listception = new List.empty(growable: true);
    listception.add(cardList1);
    listception.add(cardList2);

    for(List list in listception) {
      returnList.add(
          Expanded(
              child: ListView(
                padding: EdgeInsets.all(2),
                children: list as List<Widget>,
              )
          )
      );
    }
    return returnList;
  }
}

class Article {
  String title;
  String description;
  Image? image;
  Widget? onTap;

  Article({required this.title, required this.description, this.image, this.onTap});
}
