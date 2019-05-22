import 'dart:convert';
import 'dart:async' show Future;
import 'dart:core';
import 'package:flutter/services.dart' show rootBundle;

class QuotesDTO {
  Map<String, List<Quote>> map;

  QuotesDTO(Map<String, List<Quote>> map) {
    this.map = map;
  }

  factory QuotesDTO.fromJson(Map<String, dynamic> parsedJson) {
    Map<String, List<Quote>> map = new Map();

    List<String> quotesCategory = [
      "Inspirational Quotes",
      "Motivational Quotes",
      "Positive Quotes",
      "Success Quotes",
      "Life Quotes",
      "Short Inspirational Quotes",
      "Words Of Encouragement",
      "Encouraging Quotes"
    ];

    for (int i = 0; i < quotesCategory.length; i++) {
      map[quotesCategory[i]] = (parsedJson[quotesCategory[i]] as List)
          .map((i) => Quote.fromJson(i))
          .toList();
    }
    return QuotesDTO(map);
  }
}

QuotesDTO allQuotes;

Future<String> _loadAStudentAsset() async {
  return await rootBundle.loadString('assets/data.json');
}

Future<QuotesDTO> loadQuotes() async {
  //await wait(2);
  if(allQuotes == null) {
    String jsonString = await _loadAStudentAsset();
    final jsonResponse = json.decode(jsonString);
    allQuotes = QuotesDTO.fromJson(jsonResponse);
  }
  return allQuotes;
}

Future wait(int seconds) {
  return new Future.delayed(Duration(seconds: seconds), () => {});
}

class Quote {
  String quote;
  String author;

  Quote(String quote, String author) {
    if(author == null || author.isEmpty) {
      this.author = "Unknown";
    }
    else {
      this.author = author;
    }
    this.quote = quote;
  }


  factory Quote.fromJson(Map<String, dynamic> quoteJson) {
    return Quote(quoteJson['quote'], quoteJson['author']);
  }
}
