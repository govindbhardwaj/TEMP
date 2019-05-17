import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class AllQuotes {
  final List<Quote> inspirationalQuotes; //Inspirational Quotes
  final List<Quote> motivationalQuotes; //Motivational Quotes
  final List<Quote> positiveQuotes; //Positive Quotes
  final List<Quote> successQuotes; //Success Quotes
  final List<Quote>
      inspirationalQuotesAboutLife; //Inspirational Quotes About Life
  final List<Quote> shortInspirationalQuotes; //Short Inspirational Quotes
  final List<Quote> wordsOfEncouragement;
  final List<Quote>
      inspirationalQuotesForEncouragement; //Inspirational Quotes For Encouragement
  final List<Quote> shortEncouragingQuotes; //Short Encouraging Quotes
  final List<Quote> positiveEncouragingQuotes; //Positive Encouraging Quotes

  AllQuotes(
      {this.inspirationalQuotes,
      this.motivationalQuotes,
      this.positiveQuotes,
      this.successQuotes,
      this.inspirationalQuotesAboutLife,
      this.shortInspirationalQuotes,
      this.wordsOfEncouragement,
      this.inspirationalQuotesForEncouragement,
      this.shortEncouragingQuotes,
      this.positiveEncouragingQuotes});

  factory AllQuotes.fromJson(Map<String, dynamic> parsedJson) {
    List<Quote> var1 = (parsedJson['Inspirational Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var2 = (parsedJson['Motivational Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var3 = (parsedJson['Positive Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var4 = (parsedJson['Success Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var5 = (parsedJson['Inspirational Quotes About Life'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var6 = (parsedJson['Short Inspirational Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var7 = (parsedJson['Words Of Encouragement'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var8 =
        (parsedJson['Inspirational Quotes For Encouragement'] as List)
            .map((i) => Quote.fromJson(i))
            .toList();
    List<Quote> var9 = (parsedJson['Short Encouraging Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();
    List<Quote> var10 = (parsedJson['Positive Encouraging Quotes'] as List)
        .map((i) => Quote.fromJson(i))
        .toList();

    return AllQuotes(
        inspirationalQuotes: var1,
        motivationalQuotes: var2,
        positiveQuotes: var3,
        successQuotes: var4,
        inspirationalQuotesAboutLife: var5,
        shortInspirationalQuotes: var6,
        wordsOfEncouragement: var7,
        inspirationalQuotesForEncouragement: var8,
        shortEncouragingQuotes: var9,
        positiveEncouragingQuotes: var10);
  }
}

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<AllQuotes> loadQuotes() async {
  //await wait(5);
  String jsonString = await _loadAStudentAsset();
  final jsonResponse = json.decode(jsonString);
  return new AllQuotes.fromJson(jsonResponse);
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class Quote {
  String quote;
  String author;

  Quote({this.quote, this.author});

  factory Quote.fromJson(Map<String, dynamic> quoteJson) {
    return Quote(quote: quoteJson['quote'], author: quoteJson['author']);
  }
}
