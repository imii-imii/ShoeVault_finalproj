import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StockService {
  static const String _storageKey = 'product_stocks';

  // Initialize stock data per size
  static Future<Map<String, Map<String, int>>> initializeStocks() async {
    final prefs = await SharedPreferences.getInstance();
    final stockData = prefs.getString(_storageKey);
    
    if (stockData == null || stockData.isEmpty) {
      // Initial stock values per size for each product
      final initialStocks = {
        'Nike Air Max': {'7': 3, '8': 4, '9': 5, '10': 3},
        'Adidas Ultraboost': {'6': 2, '7': 3, '8': 2, '9': 1},
        'Puma Suede': {'8': 3, '9': 4, '10': 3, '11': 2},
        'Nike Air Jordan': {'6': 4, '7': 5, '8': 4, '9': 4, '10': 3},
        'New Balance 574': {'7': 1, '8': 2, '9': 1, '10': 1, '11': 0},
        'Reebok Classic': {'7': 2, '8': 2, '9': 2, '10': 1},
        'ASICS Gel-Lyte': {'8': 2, '9': 3, '10': 2, '11': 2},
        'Fila Disruptor': {'6': 3, '7': 4, '8': 4, '9': 3},
        'Under Armour HOVR': {'7': 2, '8': 2, '9': 1, '10': 1},
        'Saucony Jazz': {'8': 3, '9': 3, '10': 3, '11': 2},
        'Jordan 1 Mid': {'7': 1, '8': 1, '9': 1, '10': 0, '11': 0},
      };
      
      await saveStocks(initialStocks);
      return initialStocks;
    }
    
    final Map<String, dynamic> jsonData = jsonDecode(stockData);
    return jsonData.map((key, value) => MapEntry(key, Map<String, int>.from(value)));
  }

  // Save stock data
  static Future<void> saveStocks(Map<String, Map<String, int>> stocks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(stocks);
    await prefs.setString(_storageKey, jsonData);
  }

  // Update stock for a specific product and size
  static Future<void> updateStock(String productName, String size, int newStock) async {
    final stocks = await initializeStocks();
    if (stocks.containsKey(productName)) {
      stocks[productName]![size] = newStock;
      await saveStocks(stocks);
    }
  }

  // Get current stock for a product and size
  static Future<int> getStock(String productName, String size) async {
    final stocks = await initializeStocks();
    return stocks[productName]?[size] ?? 0;
  }

  // Get total stock for a product (sum of all sizes)
  static Future<int> getTotalStock(String productName) async {
    final stocks = await initializeStocks();
    final productStocks = stocks[productName];
    if (productStocks == null) return 0;
    return productStocks.values.reduce((sum, stock) => sum + stock);
  }

  // Deduct stock for specific product and size
  static Future<void> deductStock(String productName, String size, int quantity) async {
    final stocks = await initializeStocks();
    if (stocks.containsKey(productName) && stocks[productName]!.containsKey(size)) {
      final currentStock = stocks[productName]![size]!;
      stocks[productName]![size] = (currentStock - quantity).clamp(0, double.infinity).toInt();
      await saveStocks(stocks);
    }
  }

  // Deduct stock for multiple products and sizes
  static Future<void> deductStocks(Map<String, Map<String, int>> deductions) async {
    final stocks = await initializeStocks();
    
    for (var productEntry in deductions.entries) {
      final productName = productEntry.key;
      final sizeDeductions = productEntry.value;
      
      if (stocks.containsKey(productName)) {
        for (var sizeEntry in sizeDeductions.entries) {
          final size = sizeEntry.key;
          final quantity = sizeEntry.value;
          
          if (stocks[productName]!.containsKey(size)) {
            final currentStock = stocks[productName]![size]!;
            stocks[productName]![size] = (currentStock - quantity).clamp(0, double.infinity).toInt();
          }
        }
      }
    }
    
    await saveStocks(stocks);
  }
}
