abstract class Constants {

  static const String stockBaseUrl = String.fromEnvironment(
    'STOCK_BASE_URL',
    defaultValue: 'https://query1.finance.yahoo.com'
  );

  static const String cryptoBaseUrl = String.fromEnvironment(
      'CRYPTO_BASE_URL',
      defaultValue: 'https://coinranking1.p.rapidapi.com'
  );

  static const List<String> stockList = ['AAPL', 'GOOG', 'MSFT', 'AMZN'];

  static const String HEADER_KEY = 'X-RapidAPI-Key';
  static const String HEADER_KEY_VALUE = '37738eaddbmsh7ddf36c36bee1d7p155d54jsn8e36e9585327';

  static const String HEADER_HOST = 'X-RapidAPI-Host';
  static const String HEADER_HOST_VALUE = 'yahoo-finance15.p.rapidapi.com';
  static const String HEADER_HOST_CRYPTO_VALUE = 'coinranking1.p.rapidapi.com';

}