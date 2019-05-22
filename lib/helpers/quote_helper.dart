import "package:daily_quotes/dto/QuotesDTO.dart";
import 'dart:math';

class quote_helper {

  Future<String> getQuote() async {
    QuotesDTO listOfQuotes = await loadQuotes();

    //get Random key
    int numberOfCategories = listOfQuotes.map.keys.length;
    int randomCategory = getRandom(numberOfCategories);

    String category = listOfQuotes.map.keys.toList()[randomCategory];
    List<Quote> quotes = listOfQuotes.map[category];

    return quotes.elementAt(getRandom(quotes.length)).quote;
  }

  int getRandom(int number) {
    var random = Random.secure();
    return random.nextInt(number);
  }
}