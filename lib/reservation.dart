import 'package:flutter/material.dart';
import 'reservation_service.dart';
import 'stock_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReservationService.initializeWithSampleData();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  
  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  String get currentThemeLabel {
    return _themeMode == ThemeMode.light ? 'Light' : 'Dark';
  }

  IconData get currentThemeIcon {
    return _themeMode == ThemeMode.light ? Icons.light_mode : Icons.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOEVAULT',
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF0730E8), // Main brand color
          secondary: const Color(0xFF4D7CFF), // Secondary color
          surface: Colors.white, // Scaffold background
          onPrimary: Colors.white, // Text/icon color on primary color
          onSecondary: Colors.white, // Text/icon color on secondary color
          onSurface: Colors.black87, // Default text color
        ),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Open Sans',
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF0730E8),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF4D7CFF), // Slightly lighter for dark mode
          secondary: const Color(0xFF7B9EFF), // Secondary color
          surface: const Color(0xFF1E1E1E), // Scaffold background
          onPrimary: Colors.white, // Text/icon color on primary color
          onSecondary: Colors.white, // Text/icon color on secondary color
          onSurface: Colors.white, // Default text color
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Open Sans',
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF1E1E1E),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        final screenHeight = MediaQuery.of(context).size.height;
        final screenWidth = MediaQuery.of(context).size.width;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section
                Container(
                  height: isMobile ? screenHeight * 0.9 : screenHeight * 1.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorScheme.primary.withOpacity(0.8),
                        colorScheme.secondary.withOpacity(0.6),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: -100,
                        right: -100,
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -150,
                        left: -150,
                        child: Container(
                          width: 550,
                          height: 550,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : screenWidth * 0.1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: isMobile ? 40 : screenHeight * 0.1),
                            Text(
                              'STEP INTO STYLE',
                              style: TextStyle(
                                fontSize: isMobile ? 12 : 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8),
                                letterSpacing: 2,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              isMobile
                                  ? 'Premium Sneakers Reservation'
                                  : 'Premium Sneakers\nReservation',
                              style: TextStyle(
                                fontSize: isMobile ? 28 : 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Reserve your favorite sneakers online and pick them up at our store. Limited stocks available.',
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            SizedBox(height: 40),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => ProductCatalogScreen(),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: animation,
                                          curve: Curves.easeInOut,
                                        )),
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                    transitionDuration: Duration(milliseconds: 500),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white, // Button background
                                foregroundColor: colorScheme.primary, // Text color
                                padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 30 : 40,
                                    vertical: isMobile ? 15 : 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                'Start a Reservation',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: isMobile ? 20 : 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Features Section
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 40 : 80,
                      horizontal: isMobile ? 20 : screenWidth * 0.1),
                  child: Column(
                    children: [
                      Text(
                        'WHY CHOOSE US',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        isMobile
                            ? 'The Best Sneaker Shopping Experience'
                            : 'The Best Sneaker\nShopping Experience',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 24 : 32,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      SizedBox(height: isMobile ? 30 : 50),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isNarrow = constraints.maxWidth < 800;
                          if (isNarrow) {
                            return Column(
                              children: [
                                _buildFeature(
                                  icon: Icons.local_shipping,
                                  title: 'Fast Pickup',
                                  description: 'Reserve online and pick up in-store within hours',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                                _buildFeature(
                                  icon: Icons.verified_user,
                                  title: 'Authentic Products',
                                  description: '100% genuine sneakers with verification',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                                _buildFeature(
                                  icon: Icons.star,
                                  title: 'Exclusive Drops',
                                  description: 'Access to limited edition releases',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildFeature(
                                  icon: Icons.local_shipping,
                                  title: 'Fast Pickup',
                                  description: 'Reserve online and pick up in-store within hours',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                                _buildFeature(
                                  icon: Icons.verified_user,
                                  title: 'Authentic Products',
                                  description: '100% genuine sneakers with verification',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                                _buildFeature(
                                  icon: Icons.star,
                                  title: 'Exclusive Drops',
                                  description: 'Access to limited edition releases',
                                  colorScheme: colorScheme,
                                  isMobile: isMobile,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                
                // CTA Section
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 40 : 80,
                      horizontal: isMobile ? 20 : screenWidth * 0.1),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        colorScheme.primary.withOpacity(0.1),
                        colorScheme.secondary.withOpacity(0.1),
                      ],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'READY TO RESERVE?',
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Browse Our Latest Collection',
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 28,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ProductCatalogScreen(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  )),
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 500),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary, // Button background
                          foregroundColor: colorScheme.onPrimary, // Text color
                          padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 30 : 40,
                              vertical: isMobile ? 15 : 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                        child: Text(
                          'Explore Catalog',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Footer
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 30 : 40,
                      horizontal: isMobile ? 20 : screenWidth * 0.1),
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? colorScheme.surface.withOpacity(0.8)
                      : Colors.grey[900],
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          bool isNarrow = constraints.maxWidth < 800;
                          if (isNarrow) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SHOEVAULT',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).brightness == Brightness.dark 
                                            ? colorScheme.onSurface 
                                            : Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Premium sneaker reservation system for true enthusiasts',
                                      style: TextStyle(
                                        color: Theme.of(context).brightness == Brightness.dark 
                                            ? colorScheme.onSurface.withOpacity(0.7)
                                            : Colors.white70,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CONTACT',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Manghinao, Bauan, Batangas\nshoevervaultbats@gmail.com\n0917-123-4567',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'SHOEVAULT',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Premium sneaker reservation\nsystem for true enthusiasts',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CONTACT',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Manghinao, Bauan, Batangas\nshoevervaultbats@gmail.com\n0917-123-4567',
                                      style: TextStyle(
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                      SizedBox(height: isMobile ? 30 : 40),
                      Divider(color: Colors.white30),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '© 2023 SHOEVAULT. All rights reserved.',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          // Theme toggle button
                          TextButton.icon(
                            onPressed: () {
                              MyApp.of(context)?.toggleTheme();
                            },
                            icon: Icon(
                              MyApp.of(context)?.currentThemeIcon ?? Icons.light_mode,
                              color: Colors.white70,
                              size: 16,
                            ),
                            label: Text(
                              MyApp.of(context)?.currentThemeLabel ?? 'Light',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeature({
    required IconData icon,
    required String title,
    required String description,
    required ColorScheme colorScheme,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? double.infinity : 250,
      padding: EdgeInsets.all(isMobile ? 15 : 20),
      margin: isMobile ? EdgeInsets.only(bottom: 20) : null,
      child: Column(
        children: [
          Container(
            width: isMobile ? 50 : 60,
            height: isMobile ? 50 : 60,
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              size: isMobile ? 25 : 30,
              color: colorScheme.primary,
            ),
          ),
          SizedBox(height: isMobile ? 15 : 20),
          Text(
            title,
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: isMobile ? 14 : null,
            ),
          ),
        ],
      ),
    );
  }
}

// Product data model
class Product {
  final String name;
  final double price;
  final List<String> sizes;
  final String imageUrl;
  final String category;
  Map<String, int> stockPerSize; // Stock per size

  Product({
    required this.name,
    required this.price,
    required this.sizes,
    required this.imageUrl,
    required this.category,
    required this.stockPerSize,
  });

  // Get total stock across all sizes
  int get totalStock {
    return stockPerSize.values.fold(0, (sum, stock) => sum + stock);
  }

  // Get stock for a specific size
  int getStockForSize(String size) {
    return stockPerSize[size] ?? 0;
  }

  // Check if a size is available
  bool isSizeAvailable(String size) {
    return getStockForSize(size) > 0;
  }
}

class ProductCatalogApp extends StatelessWidget {
  const ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOEVAULT RESERVATION',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductCatalogScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  _ProductCatalogScreenState createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductsWithStock();
  }

  Future<void> _loadProductsWithStock() async {
    // Load products immediately with default stock values
    setState(() {
      products = [
        Product(name: 'Nike Air Max', price: 5995.0, sizes: ['7', '8', '9', '10'], imageUrl: 'assets/pictures/ar1.png', category: 'Sneakers', stockPerSize: {'7': 3, '8': 4, '9': 5, '10': 3}),
        Product(name: 'Adidas Ultraboost', price: 7995.0, sizes: ['6', '7', '8', '9'], imageUrl: 'assets/pictures/ar2.png', category: 'Running', stockPerSize: {'6': 2, '7': 3, '8': 2, '9': 1}),
        Product(name: 'Puma Suede', price: 4595.0, sizes: ['8', '9', '10', '11'], imageUrl: 'assets/pictures/ar3.png', category: 'Casual', stockPerSize: {'8': 3, '9': 4, '10': 3, '11': 2}),
        Product(name: 'Nike Air Jordan', price: 3495.0, sizes: ['6', '7', '8', '9', '10'], imageUrl: 'assets/pictures/ar4.png', category: 'Casual', stockPerSize: {'6': 4, '7': 5, '8': 4, '9': 4, '10': 3}),
        Product(name: 'New Balance 574', price: 5295.0, sizes: ['7', '8', '9', '10', '11'], imageUrl: 'assets/pictures/ar5.png', category: 'Running', stockPerSize: {'7': 1, '8': 2, '9': 1, '10': 1, '11': 0}),
        Product(name: 'Reebok Classic', price: 4795.0, sizes: ['7', '8', '9', '10'], imageUrl: 'assets/pictures/ar6.png', category: 'Casual', stockPerSize: {'7': 2, '8': 2, '9': 2, '10': 1}),
        Product(name: 'ASICS Gel-Lyte', price: 5295.0, sizes: ['8', '9', '10', '11'], imageUrl: 'assets/pictures/ar7.png', category: 'Running', stockPerSize: {'8': 2, '9': 3, '10': 2, '11': 2}),
        Product(name: 'Fila Disruptor', price: 3995.0, sizes: ['6', '7', '8', '9'], imageUrl: 'assets/pictures/ar8.png', category: 'Sneakers', stockPerSize: {'6': 3, '7': 4, '8': 4, '9': 3}),
        Product(name: 'Under Armour HOVR', price: 6595.0, sizes: ['7', '8', '9', '10'], imageUrl: 'assets/pictures/ar9.png', category: 'Running', stockPerSize: {'7': 2, '8': 2, '9': 1, '10': 1}),
        Product(name: 'Saucony Jazz', price: 4995.0, sizes: ['8', '9', '10', '11'], imageUrl: 'assets/pictures/ar10.png', category: 'Running', stockPerSize: {'8': 3, '9': 3, '10': 3, '11': 2}),
        Product(name: 'Jordan 1 Mid', price: 7495.0, sizes: ['7', '8', '9', '10', '11'], imageUrl: 'assets/pictures/ar11.png', category: 'Sneakers', stockPerSize: {'7': 1, '8': 1, '9': 1, '10': 0, '11': 0}),
      ];
      isLoading = false;
    });
    
    // Load actual stock data in background and update if different
    try {
      final stocks = await StockService.initializeStocks();
      
      // Only update if there are actual differences
      bool needsUpdate = false;
      for (int i = 0; i < products.length; i++) {
        final productName = products[i].name;
        final actualStocks = stocks[productName];
        if (actualStocks != null) {
          // Check if any stock values are different
          for (var entry in actualStocks.entries) {
            if (products[i].stockPerSize[entry.key] != entry.value) {
              needsUpdate = true;
              break;
            }
          }
        }
      }
      
      if (needsUpdate) {
        setState(() {
          for (int i = 0; i < products.length; i++) {
            final productName = products[i].name;
            final actualStocks = stocks[productName];
            if (actualStocks != null) {
              products[i].stockPerSize = Map.from(actualStocks);
            }
          }
        });
      }
    } catch (e) {
      // If stock loading fails, keep default values
      print('Stock loading failed: $e');
    }
  }

  Future<void> _refreshStockData() async {
    setState(() {
      isLoading = true;
    });
    
    try {
      final stocks = await StockService.initializeStocks();
      
      setState(() {
        for (int i = 0; i < products.length; i++) {
          final productName = products[i].name;
          final actualStocks = stocks[productName];
          if (actualStocks != null) {
            products[i].stockPerSize = Map.from(actualStocks);
          }
        }
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Stock refresh failed: $e');
    }
  }

  final Map<String, SelectedProduct> reservedProducts = {};
  String searchQuery = '';
  String selectedCategory = 'All';

  List<String> get categories {
    final cats = products.map((p) => p.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<Product> get filteredProducts {
    return products.where((product) {
      final matchesCategory = selectedCategory == 'All' || product.category == selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _addToReservation(int index, String size) {
    setState(() {
      final product = products[index];
      final key = '${product.name}_$size';

      // Prevent adding more than available stock for this size
      int alreadyReserved = reservedProducts[key]?.quantity ?? 0;
      int availableStock = product.getStockForSize(size);
      if (alreadyReserved >= availableStock) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Not enough stock for ${product.name} (Size: $size)')),
        );
        return;
      }

      if (reservedProducts.containsKey(key)) {
        reservedProducts[key] = SelectedProduct(
          product: product,
          size: size,
          quantity: reservedProducts[key]!.quantity + 1,
        );
      } else {
        reservedProducts[key] = SelectedProduct(
          product: product,
          size: size,
          quantity: 1,
        );
      }
    });
  }

  void _removeFromReservation(int index, String size) {
    setState(() {
      final product = products[index];
      final key = '${product.name}_$size';
      
      if (reservedProducts.containsKey(key)) {
        if (reservedProducts[key]!.quantity > 1) {
          reservedProducts[key] = SelectedProduct(
            product: product,
            size: size,
            quantity: reservedProducts[key]!.quantity - 1,
          );
        } else {
          reservedProducts.remove(key);
        }
      }
    });
  }

  void _showReservationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Your Reservation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  if (reservedProducts.isEmpty)
                    Text('No items selected', style: TextStyle(color: Colors.grey))
                  else
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: reservedProducts.length,
                        itemBuilder: (context, index) {
                          final key = reservedProducts.keys.elementAt(index);
                          final sp = reservedProducts[key]!;

                          return ListTile(
                            title: Text(sp.product.name),
                            subtitle: Text('Size: ${sp.size} | ₱${sp.product.price.toStringAsFixed(2)}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, size: 20),
                                  onPressed: () {
                                    _removeFromReservation(products.indexOf(sp.product), sp.size);
                                    setModalState(() {}); // Refresh the bottom sheet
                                  },
                                ),
                                Text(sp.quantity.toString()),
                                IconButton(
                                  icon: Icon(Icons.add, size: 20),
                                  onPressed: () {
                                    _addToReservation(products.indexOf(sp.product), sp.size);
                                    setModalState(() {}); // Refresh the bottom sheet
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 600;
                      if (reservedProducts.isNotEmpty && isMobile) {
                        return ElevatedButton(
                          child: Text('Proceed to Reservation'),
                          onPressed: () async {
                            Navigator.pop(context);
                            // Navigate to ReservationFormScreen
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReservationFormScreen(
                                  selectedProducts: reservedProducts.values.toList(),
                                  onReservationSuccess: _deductStocksAfterReservation,
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Deduct stocks after reservation is successful
  void _deductStocksAfterReservation(List<SelectedProduct> reservedList) async {
    // Create a map of stock deductions per product and size
    Map<String, Map<String, int>> stockDeductions = {};
    
    setState(() {
      for (var sp in reservedList) {
        // Update local stock
        final currentStock = sp.product.getStockForSize(sp.size);
        sp.product.stockPerSize[sp.size] = (currentStock - sp.quantity).clamp(0, double.infinity).toInt();
        
        // Prepare for storage update
        if (!stockDeductions.containsKey(sp.product.name)) {
          stockDeductions[sp.product.name] = {};
        }
        stockDeductions[sp.product.name]![sp.size] = sp.quantity;
      }
      reservedProducts.clear();
    });
    
    // Save stock changes to persistent storage
    await StockService.deductStocks(stockDeductions);
    
    // Show success message with stock updates
    String stockUpdateMessage = '✅ Reservation successful!\n\nStock updated:';
    for (var sp in reservedList) {
      stockUpdateMessage += '\n• ${sp.product.name} (${sp.size}): -${sp.quantity} units';
    }
    stockUpdateMessage += '\n\nAll items have been reserved successfully!';
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(stockUpdateMessage),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _showSizeSelectionDialog(BuildContext context, Product product, int index) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: isMobile ? screenWidth * 0.9 : 500,
            constraints: BoxConstraints(
              maxWidth: 600,
              minWidth: 300,
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Select Size',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                
                // Product name and stock info
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: product.totalStock > 10 
                              ? Colors.green.withOpacity(0.2)
                              : product.totalStock > 5 
                                  ? Colors.orange.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              product.totalStock > 10 
                                  ? Icons.inventory_2
                                  : product.totalStock > 5 
                                      ? Icons.warning
                                      : Icons.error,
                              size: 16,
                              color: product.totalStock > 10 
                                  ? Colors.green
                                  : product.totalStock > 5 
                                      ? Colors.orange
                                      : Colors.red,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Total Available: ${product.totalStock}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: product.totalStock > 10 
                                    ? Colors.green
                                    : product.totalStock > 5 
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                
                // Instruction text
                Text(
                  'Choose your preferred size:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20),
                
                // Size buttons
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: product.sizes.map((size) {
                    final sizeStock = product.getStockForSize(size);
                    final isAvailable = sizeStock > 0;
                    
                    return SizedBox(
                      width: isMobile ? 80 : 100,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isAvailable ? () {
                          Navigator.pop(context);
                          _addToReservation(index, size);
                          
                          // Show enhanced confirmation with stock info
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${product.name} (Size: $size) added to reservation',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Quantity: 1 | Available: $sizeStock',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              duration: Duration(seconds: 3),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              action: SnackBarAction(
                                label: 'View Cart',
                                textColor: Colors.white,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                  // You could add navigation to cart here if needed
                                },
                              ),
                            ),
                          );
                        } : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isAvailable 
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: isAvailable ? 2 : 0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              size,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (!isAvailable)
                              Text(
                                'Out',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 24),
                
                // Cancel button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    if (isLoading) {
      return Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          title: Text('ShoeVault Catalog'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: colorScheme.primary,
              ),
              SizedBox(height: 16),
              Text(
                'Loading product catalog...',
                style: TextStyle(
                  fontSize: 16,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'ShoeVault Catalog',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Open Sans',
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              // Refresh button
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.white),
                onPressed: () async {
                  await _refreshStockData();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Stock data refreshed'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                tooltip: 'Refresh Stock Data',
              ),
              // Theme toggle button
              IconButton(
                icon: Icon(
                  MyApp.of(context)?.currentThemeIcon ?? Icons.light_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  MyApp.of(context)?.toggleTheme();
                },
                tooltip: 'Toggle ${MyApp.of(context)?.currentThemeLabel == 'Light' ? 'Dark' : 'Light'} Mode',
              ),
              Image.asset(
                'assets/pictures/shoevault_logo.png',
                height: 40,
                width: 50,
              ),
            ],
          ),
          centerTitle: false,
          elevation: 0,
          backgroundColor: colorScheme.primary.withOpacity(0.8),
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth >= 1000;
            
            if (isDesktop) {
              return _buildDesktopLayout();
            } else {
              return _buildMobileLayout();
            }
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text('Reserve (${reservedProducts.values.fold(0, (sum, sp) => sum + sp.quantity)})'),
          icon: Icon(Icons.shopping_cart),
          onPressed: () async {
            if (reservedProducts.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select at least one product.')),
              );
              return;
            }
            
            // Determine if we should show desktop or mobile flow
            if (MediaQuery.of(context).size.width >= 1000) {
              // Navigate to ReservationFormScreen for desktop
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => ReservationFormScreen(
                    selectedProducts: reservedProducts.values.toList(),
                    onReservationSuccess: _deductStocksAfterReservation,
                  ),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  transitionDuration: Duration(milliseconds: 300),
                ),
              );
            } else {
              _showReservationBottomSheet();
            }
          },
        ),
    );
  }

  Widget _buildDesktopLayout() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search shoes...',
                    prefixIcon: Icon(Icons.search, color: colorScheme.onSurface.withOpacity(0.6)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    filled: true,
                    fillColor: colorScheme.surface,
                    hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                  ),
                  style: TextStyle(color: colorScheme.onSurface),
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categories.map((cat) => Padding(
                      padding: const EdgeInsets.only(right: 4.0),
                      child: ChoiceChip(
                        label: Text(cat, style: TextStyle(
                          fontFamily: 'Open Sans',
                          color: selectedCategory == cat ? Colors.white : colorScheme.onSurface,
                        )),
                        selected: selectedCategory == cat,
                        selectedColor: colorScheme.primary,
                        backgroundColor: colorScheme.surface,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        },
                      ),
                    )).toList(),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 600;
                      return GridView.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 2 : 4,
                          childAspectRatio: 0.65,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, filteredIndex) {
                          final product = filteredProducts[filteredIndex];
                          final index = products.indexOf(product);
                          
                          return _buildProductCard(product, index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border(left: BorderSide(color: colorScheme.onSurface.withOpacity(0.2))),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 12,
                offset: Offset(-2, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Your Reservation', 
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    )),
              ),
              Divider(color: colorScheme.onSurface.withOpacity(0.2)),
              if (reservedProducts.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No items selected', 
                      style: TextStyle(color: colorScheme.onSurface.withOpacity(0.6))),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: reservedProducts.length,
                    itemBuilder: (context, index) {
                      final key = reservedProducts.keys.elementAt(index);
                      final sp = reservedProducts[key]!;
                      return ListTile(
                        title: Text(sp.product.name, style: TextStyle(color: colorScheme.onSurface)),
                        subtitle: Text('Size: ${sp.size} | ₱${sp.product.price.toStringAsFixed(2)}',
                            style: TextStyle(color: colorScheme.onSurface.withOpacity(0.7))),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, size: 20, color: colorScheme.onSurface),
                              onPressed: () => _removeFromReservation(
                                products.indexOf(sp.product), 
                                sp.size
                              ),
                            ),
                            Text(sp.quantity.toString(), style: TextStyle(color: colorScheme.onSurface)),
                            IconButton(
                              icon: Icon(Icons.add, size: 20, color: colorScheme.onSurface),
                              onPressed: () => _addToReservation(
                                products.indexOf(sp.product), 
                                sp.size
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search shoes...',
              prefixIcon: Icon(Icons.search, color: colorScheme.onSurface.withOpacity(0.6)),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              filled: true,
              fillColor: colorScheme.surface,
              hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
            ),
            style: TextStyle(color: colorScheme.onSurface),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Category:', style: TextStyle(fontSize: 14, color: colorScheme.onSurface)),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedCategory,
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat, style: TextStyle(color: colorScheme.onSurface)),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val!;
                  });
                },
                dropdownColor: colorScheme.surface,
                style: TextStyle(color: colorScheme.onSurface),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 600;
                return GridView.builder(
                  itemCount: filteredProducts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isMobile ? 2 : 4,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: isMobile ? 12 : 20,
                    mainAxisSpacing: isMobile ? 16 : 30,
                  ),
                  itemBuilder: (context, filteredIndex) {
                    final product = filteredProducts[filteredIndex];
                    final index = products.indexOf(product);
                    
                    return _buildProductCard(product, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Product product, int index) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Card(
      margin: EdgeInsets.zero,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.surface,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final containerWidth = constraints.maxWidth;
            final imageHeight = containerWidth * 0.55;
            final imageMargin = containerWidth * 0.06;
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: imageHeight,
                  margin: EdgeInsets.all(imageMargin),
                  decoration: BoxDecoration(
                    color: colorScheme.brightness == Brightness.dark 
                        ? Colors.grey[800] 
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: product.imageUrl.isNotEmpty
                        ? Image.asset(
                            product.imageUrl,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.image,
                                  size: imageHeight * 0.4,
                                  color: colorScheme.brightness == Brightness.dark 
                                      ? Colors.grey[600] 
                                      : Colors.grey[400],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Icon(
                              Icons.image,
                              size: imageHeight * 0.4,
                              color: colorScheme.brightness == Brightness.dark 
                                  ? Colors.grey[600] 
                                  : Colors.grey[400],
                            ),
                          ),
                  ),
                ),
                
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: imageMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                            fontSize: containerWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 6),
                        Text(
                          '₱${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: containerWidth * 0.07,
                            color: Colors.green[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                                                Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: product.totalStock > 10 
                                ? Colors.green.withOpacity(0.1)
                                : product.totalStock > 5 
                                    ? Colors.orange.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: product.totalStock > 10 
                                  ? Colors.green
                                  : product.totalStock > 5 
                                      ? Colors.orange
                                      : Colors.red,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                product.totalStock > 10 
                                    ? Icons.inventory_2
                                    : product.totalStock > 5 
                                        ? Icons.warning
                                        : Icons.error,
                                size: containerWidth * 0.05,
                                color: product.totalStock > 10 
                                    ? Colors.green
                                    : product.totalStock > 5 
                                        ? Colors.orange
                                        : Colors.red,
                              ),
                              SizedBox(width: 4),
                        Text(
                          'Stock: ${product.totalStock}',
                          style: TextStyle(
                            fontSize: containerWidth * 0.06,
                                  fontWeight: FontWeight.w600,
                                  color: product.totalStock > 10 
                                      ? Colors.green
                                      : product.totalStock > 5 
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        

                        
                                                // Add to Reservation button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: product.totalStock > 0 ? () {
                              _showSizeSelectionDialog(context, product, index);
                            } : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: product.totalStock > 0 ? colorScheme.primary : Colors.grey,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (product.totalStock > 0) ...[
                                  Icon(
                                    Icons.add_shopping_cart,
                                    size: containerWidth * 0.05,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                ] else ...[
                                  Icon(
                                    Icons.block,
                                    size: containerWidth * 0.05,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                ],
                        Text(
                                  product.totalStock > 0 ? 'Add to Reservation' : 'Out of Stock',
                          style: TextStyle(
                            fontSize: containerWidth * 0.06,
                            fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SelectedProduct {
  final Product product;
  final String size;
  int quantity;

  SelectedProduct({
    required this.product,
    required this.size,
    this.quantity = 1,
  });
}

class ReservationFormScreen extends StatefulWidget {
  final List<SelectedProduct> selectedProducts;
  final void Function(List<SelectedProduct>)? onReservationSuccess;

  const ReservationFormScreen({
    super.key,
    required this.selectedProducts,
    this.onReservationSuccess,
  });

  @override
  _ReservationFormScreenState createState() => _ReservationFormScreenState();
}

class _ReservationFormScreenState extends State<ReservationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String phone = '';
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  bool _validatePhoneNumber(String phone) {
    return phone.startsWith('09') && phone.length == 11 && RegExp(r'^[0-9]+$').hasMatch(phone);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (selectedDate == null || selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both date and time for pickup')),
        );
        return;
      }
      
      _formKey.currentState!.save();
      
      if (!_validatePhoneNumber(phone)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please enter a valid Philippine phone number starting with 09 (11 digits)')),
        );
        return;
      }
      
      // Show confirmation dialog before proceeding
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Confirm Reservation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Are you sure you want to submit your reservation?'),
              SizedBox(height: 16),
              Text(
                'Stock will be deducted:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(height: 8),
              ...widget.selectedProducts.map((sp) => Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Text('• ${sp.product.name} (${sp.size}): '),
                    Text(
                      '${sp.quantity} unit(s)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(' (${sp.product.getStockForSize(sp.size)} → ${sp.product.getStockForSize(sp.size) - sp.quantity})'),
                  ],
                ),
              )),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                Navigator.pop(context); // Close the dialog

                // Save reservation to storage
                for (var selectedProduct in widget.selectedProducts) {
                  await ReservationService.createReservation(
                    customer: name,
                    email: email,
                    phone: phone,
                    shoe: selectedProduct.product.name,
                    size: selectedProduct.size,
                    date: selectedDate!.toIso8601String().split('T')[0],
                    pickup: selectedTime!.format(context),
                  );
                }

                // Deduct stocks in parent (ProductCatalogScreen) via callback
                if (widget.onReservationSuccess != null) {
                  widget.onReservationSuccess!(widget.selectedProducts);
                }

                // Go to receipt screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceiptScreen(
                      selectedProducts: widget.selectedProducts,
                      name: name,
                      email: email,
                      phone: phone,
                      date: selectedDate!,
                      time: selectedTime!,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = widget.selectedProducts.fold(0, (sum, sp) => sum + (sp.product.price * sp.quantity));

    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve Pickup'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ...widget.selectedProducts.map((sp) => ListTile(
                    title: Text('${sp.product.name} (x${sp.quantity})'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Size: ${sp.size} | ₱${(sp.product.price * sp.quantity).toStringAsFixed(2)}'),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: sp.product.getStockForSize(sp.size) > 10 
                                    ? Colors.green.withOpacity(0.1)
                                    : sp.product.getStockForSize(sp.size) > 5 
                                        ? Colors.orange.withOpacity(0.1)
                                        : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: sp.product.getStockForSize(sp.size) > 10 
                                      ? Colors.green
                                      : sp.product.getStockForSize(sp.size) > 5 
                                          ? Colors.orange
                                          : Colors.red,
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                'Stock: ${sp.product.getStockForSize(sp.size)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: sp.product.getStockForSize(sp.size) > 10 
                                      ? Colors.green
                                      : sp.product.getStockForSize(sp.size) > 5 
                                          ? Colors.orange
                                          : Colors.red,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                'Will deduct: ${sp.quantity}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Divider(),
              Text('Total: ₱${total.toStringAsFixed(2)}', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 24),
              Text('Customer Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => name = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  if (!value.contains('@')) return 'Please enter a valid email';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) => email = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: '09XXXXXXXXX (11 digits)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? 'Please enter your phone number' : null,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                onSaved: (value) => phone = value!,
              ),
              SizedBox(height: 24),
              Text('Pickup Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ListTile(
                title: Text(selectedDate == null
                    ? 'Select Pickup Date'
                    : 'Pickup Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              ListTile(
                title: Text(selectedTime == null
                    ? 'Select Preferred Time'
                    : 'Preferred Time: ${selectedTime!.format(context)}'),
                trailing: Icon(Icons.access_time),
                onTap: () => _pickTime(context),
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit Pickup Reservation'),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiptScreen extends StatelessWidget {
  final List<SelectedProduct> selectedProducts;
  final String name;
  final String email;
  final String phone;
  final DateTime date;
  final TimeOfDay time;

  const ReceiptScreen({super.key, 
    required this.selectedProducts,
    required this.name,
    required this.email,
    required this.phone,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    double total = selectedProducts.fold(0, (sum, sp) => sum + (sp.product.price * sp.quantity));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Ticket'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to Landing Page (Home)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LandingPage()),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to Landing Page (Home)
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
                (route) => false,
              );
            },
            tooltip: 'Go to Home',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              border: Border.all(color: colorScheme.primary, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with logo and title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pictures/shoevault_logo.png',
                      height: 40,
                      width: 50,
                    ),
                    SizedBox(width: 10),
                    Text('SHOEVAULT', 
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        )),
                  ],
                ),
                SizedBox(height: 10),
                Text('PICKUP RESERVATION RECEIPT', 
                    style: TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    )),
                Divider(thickness: 2, color: colorScheme.primary),
                SizedBox(height: 10),
                
                // Store Info
                Text('Manghinao, Bauan, Batangas', 
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface)),
                Text('Contact: 0917-123-4567', 
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface)),
                Text('Email: shoevaultbats@gmail.com', 
                    style: TextStyle(fontSize: 12, color: colorScheme.onSurface)),
                SizedBox(height: 10),
                Divider(thickness: 1, color: colorScheme.onSurface.withOpacity(0.3)),
                
                // Customer Info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Customer Information:', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name:', style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
                    Text(name, style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Phone:', style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
                    Text(phone, style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email:', style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
                    Flexible(child: Text(email, overflow: TextOverflow.ellipsis, style: TextStyle(color: colorScheme.onSurface))),
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 1, color: colorScheme.onSurface.withOpacity(0.3)),
                
                // Pickup Info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Pickup Details:', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Date:', style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
                    Text('${date.toLocal()}'.split(' ')[0], style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Time:', style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface)),
                    Text(time.format(context), style: TextStyle(color: colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 10),
                Divider(thickness: 1, color: colorScheme.onSurface.withOpacity(0.3)),
                
                // Items
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Reserved Items:', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface)),
                ),
                SizedBox(height: 8),
                ...selectedProducts.map((sp) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${sp.product.name} (${sp.size}) x${sp.quantity}', 
                            style: TextStyle(fontSize: 12, color: colorScheme.onSurface)),
                      ),
                      Text('₱${(sp.product.price * sp.quantity).toStringAsFixed(2)}', 
                          style: TextStyle(fontSize: 12, color: colorScheme.onSurface)),
                    ],
                  ),
                )),
                Divider(thickness: 1, color: colorScheme.onSurface.withOpacity(0.3)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
                    Text('₱${total.toStringAsFixed(2)}', 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorScheme.onSurface)),
                  ],
                ),
                SizedBox(height: 20),
                Text('Please present this receipt when picking up your items.',
                    style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: colorScheme.onSurface.withOpacity(0.7))),
                SizedBox(height: 20),
                
                // Navigation button
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to Landing Page (Home)
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LandingPage()),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.home),
                      label: Text('Go to Home'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
