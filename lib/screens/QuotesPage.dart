import 'package:daily_quotes/bloc/text_bloc.dart';
import 'package:daily_quotes/dto/QuotesDTO.dart';
import 'package:daily_quotes/screens/CardPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:provider/provider.dart';

class QuotesPage extends StatefulWidget {
  String category;
  QuotesPage(this.category);

  @override
  QuotePageState createState() => QuotePageState(category);
}

class QuotePageState extends State<QuotesPage> {
  String category;
  QuotePageState(category) {
    this.category = category.replaceAll('.', ".\n").replaceAll(",", ",\n");
    if (this.category.contains(",\n and")) {
      this.category = this.category.replaceAll("and", "and\n");
    }
  }

  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['quotes', 'inspiration', 'motivation'],
    birthday: new DateTime.now(),
    childDirected: true,
  );

//  BannerAd _bannerAd;
 InterstitialAd _interstitialAd;
//
//  BannerAd createBannerAd() {
//    return new BannerAd(
//        adUnitId: "ca-app-pub-1790548623336527/3137505597",
//        size: AdSize.smartBanner,
//        targetingInfo: targetInfo,
//        listener: (MobileAdEvent event) {
//          print("Banner event : $event");
//        });
//  }

  InterstitialAd createInterstitialAd() {
    return new InterstitialAd(
        adUnitId: "ca-app-pub-1790548623336527/9387843898",
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Interstitial event : $event");
        });
  }

//  @override
//  void initState() {
//    super.initState();
//    _bannerAd = createBannerAd()
//      ..load()
//      ..show();
//  }
//
//  @override
//  void dispose() {
//    _bannerAd.dispose();
//    _interstitialAd.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    final TextBloc textBloc = Provider.of<TextBloc>(context);

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(category, style: TextStyle(fontFamily: "Quicksand"),),
        ),
        body: new FutureBuilder<QuotesDTO>(
          future: loadQuotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new ListView.builder(
                    itemBuilder: (context, position) {
                      const textStyle =
                          const TextStyle(color: Colors.pink, fontSize: 12);
                      const textStyle2 = const TextStyle(fontSize: 14, fontFamily: "Quicksand");

                      return Card(
                        margin: new EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                              snapshot.data.map[category][position].quote,
                              style: textStyle2),
                          subtitle: Text(
                            snapshot.data.map[category][position].author + " -",
                            style: textStyle,
                            textDirection: TextDirection.rtl,
                          ),
                          trailing: new Icon(
                            Icons.format_quote,
                            color: Colors.pink.shade900,
                          ),
                          onTap: () {
                            _interstitialAd = createInterstitialAd()
                              ..load()
                              ..show();
                            textBloc.setStatusText(
                                snapshot.data.map[category][position].quote);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CardPage()));
                          },
                        ),
                      );
                    },
                    itemCount: snapshot.data.map[category].length,
                  ));
            } else if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }
}
