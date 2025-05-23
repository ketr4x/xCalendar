import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CurrencyApi {
  static final String _apiKey = dotenv.env['CURRENCY_API_KEY'] ?? '';
  static const String _baseUrl = 'https://api.exchangeratesapi.io/v1';
  static const String _latestEndpoint = '$_baseUrl/latest';

  Future<void> updateDatabase() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'currency_database.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE currencies(name TEXT PRIMARY KEY, rate REAL)',
          );
        },
        version: 1,
      );

      final rates = await fetchLatestRates();
      for (var entry in rates.entries) {
        await db.insert(
          'currencies',
          {'name': entry.key, 'rate': entry.value},
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  static Future<Map<String, double>> fetchLatestRates() async {
    final response = await http.get(
      Uri.parse(_latestEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'access_key': _apiKey,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data['success'] == true) {
        final Map<String, dynamic> ratesData = data['rates'];
        return Map<String, double>.from(ratesData);
      } else {
        throw Exception('Failed to fetch latest rates');
      }
    } else {
      throw Exception('Failed to load latest rates');
    }
  }

  Future<Map<String, double>> requestCurrencies() async {
    try {
      final dbPath = join(await getDatabasesPath(), 'currency_database.db');
      final dbFile = File(dbPath);
      
      if (await dbFile.exists()) {
        final lastModified = await dbFile.lastModified();
        final now = DateTime.now();
        if (now.difference(lastModified).inSeconds > 1200) {
          await updateDatabase();
        }
      } else {
        await updateDatabase();
      }
      return await getCurrenciesFromDatabase();
    } catch (e) {
      throw Exception('$e');
    }
  }
  
  Future<Map<String, double>> getCurrenciesFromDatabase() async {
    try {
      final db = await openDatabase(
        join(await getDatabasesPath(), 'currency_database.db'),
      );
      final List<Map<String, dynamic>> maps = await db.query('currencies');
      Map<String, double> result = {};
      for (var map in maps) {
        result[map['name']] = map['rate'];
      }
      return result;
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<List> requestCurrencyList() async {
    try {
      final dbPath = join(await getDatabasesPath(), 'currency_database.db');
      final dbFile = File(dbPath);

      if (await dbFile.exists()) {
        final lastModified = await dbFile.lastModified();
        final now = DateTime.now();
        if (now.difference(lastModified).inSeconds > 1200) {
          await updateDatabase();
        }
      } else {
        await updateDatabase();
      }

      final db = await openDatabase(
        join(await getDatabasesPath(), 'currency_database.db'),
      );
      final List<Map<String, dynamic>> exchangeRates = await db.query('currencies');
      List currencyList = [];
      for (var currency in exchangeRates) {
        currencyList.add(currency);
      }
      return currencyList;

    } catch (e) {
      throw Exception('$e');
    }
  }
}