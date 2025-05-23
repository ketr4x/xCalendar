import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CurrencyApi {
  static final String _apiKey = dotenv.env['CURRENCY_API_KEY'] ?? '';
  static const String _baseUrl = 'https://api.exchangeratesapi.io/v1';
  static const String _latestEndpoint = '$_baseUrl/latest';


  static Future<Map<String, double>> fetchLatestRates(String baseCurrency) async {
    final response = await http.get(
      Uri.parse(_latestEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'access_key': _apiKey,
        'base': baseCurrency,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['success'] == true) {
        return data['rates'] as Map<String, double>;
      } else {
        throw Exception('Failed to fetch latest rates');
      }
    } else {
      throw Exception('Failed to load latest rates');
    }
  }
}