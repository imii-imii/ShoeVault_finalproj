import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOEVAULT',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF0730E8), // Main brand color
          secondary: const Color(0xFF4D7CFF), // Secondary color
          surface: const Color.fromARGB(255, 255, 255, 255), // Background color for cards, etc.
          background: Colors.white, // Scaffold background
          onPrimary: Colors.white, // Text/icon color on primary color
          onSecondary: Colors.white, // Text/icon color on secondary color
          onSurface: Colors.black87, // Default text color
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Open Sans',
      ),
      home: LandingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 800 && screenWidth < 1200;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              height: isMobile ? screenHeight * 0.9 : screenHeight * 1.0,
              width: 1800,
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
                  isMobile || isTablet
                      ? Column(
                          children: [
                            _buildFeature(
                              icon: Icons.local_shipping,
                              title: 'Fast Pickup',
                              description:
                                  'Reserve online and pick up in-store within hours',
                              colorScheme: colorScheme,
                              isMobile: isMobile,
                            ),
                            _buildFeature(
                              icon: Icons.verified_user,
                              title: 'Authentic Products',
                              description:
                                  '100% genuine sneakers with verification',
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
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildFeature(
                              icon: Icons.local_shipping,
                              title: 'Fast Pickup',
                              description:
                                  'Reserve online and pick up in-store within hours',
                              colorScheme: colorScheme,
                              isMobile: isMobile,
                            ),
                            _buildFeature(
                              icon: Icons.verified_user,
                              title: 'Authentic Products',
                              description:
                                  '100% genuine sneakers with verification',
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
                        ),
                ],
              ),
            ),
            
            // CTA Section
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 40 : 80,
                  horizontal: isMobile ? 20 : screenWidth * 0.1),
              width: 1800,
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
              color: Colors.black87,
              child: Column(
                children: [
                  isMobile || isTablet
                      ? Column(
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
                                  'Premium sneaker reservation system for true enthusiasts',
                                  style: TextStyle(
                                    color: Colors.white70,
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
                        )
                      : Row(
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
                        ),
                  SizedBox(height: isMobile ? 30 : 40),
                  Divider(color: Colors.white30),
                  SizedBox(height: 20),
                  Text(
                    '© 2023 SHOEVAULT. All rights reserved.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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

// The rest of your existing code for ProductCatalogScreen and other classes goes here...
class Product {
  final String name;
  final double price;
  final List<String> sizes;
  final String imageUrl;
  final String category;
  int stock; // Made mutable

  Product({
    required this.name,
    required this.price,
    required this.sizes,
    required this.imageUrl,
    required this.category,
    required this.stock,
  });
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
  final List<Product> products = [
    Product(
      name: 'Nike Air Max',
      price: 5995.0,
      sizes: ['7', '8', '9', '10'],
      imageUrl: '',
      category: 'Sneakers',
      stock: 15,
    ),
    Product(
      name: 'Adidas Ultraboost',
      price: 7995.0,
      sizes: ['6', '7', '8', '9'],
      imageUrl: '',
      category: 'Running',
      stock: 8,
    ),
    Product(
      name: 'Puma Suede',
      price: 4595.0,
      sizes: ['8', '9', '10', '11'],
      imageUrl: '',
      category: 'Casual',
      stock: 12,
    ),
    Product(
      name: 'Converse Chuck Taylor',
      price: 3495.0,
      sizes: ['6', '7', '8', '9', '10'],
      imageUrl: '',
      category: 'Casual',
      stock: 20,
    ),
    Product(
      name: 'New Balance 574',
      price: 5295.0,
      sizes: ['7', '8', '9', '10', '11'],
      imageUrl: '',
      category: 'Running',
      stock: 5,
    ),
    Product(
      name: 'Reebok Classic',
      price: 4795.0,
      sizes: ['7', '8', '9', '10'],
      imageUrl: '',
      category: 'Casual',
      stock: 7,
    ),
    Product(
      name: 'ASICS Gel-Lyte',
      price: 5295.0,
      sizes: ['8', '9', '10', '11'],
      imageUrl: '',
      category: 'Running',
      stock: 9,
    ),
    Product(
      name: 'Fila Disruptor',
      price: 3995.0,
      sizes: ['6', '7', '8', '9'],
      imageUrl: '',
      category: 'Sneakers',
      stock: 14,
    ),
    Product(
      name: 'Under Armour HOVR',
      price: 6595.0,
      sizes: ['7', '8', '9', '10'],
      imageUrl: '',
      category: 'Running',
      stock: 6,
    ),
    Product(
      name: 'Saucony Jazz',
      price: 4995.0,
      sizes: ['8', '9', '10', '11'],
      imageUrl: '',
      category: 'Running',
      stock: 11,
    ),
    Product(
      name: 'Jordan 1 Mid',
      price: 7495.0,
      sizes: ['7', '8', '9', '10', '11'],
      imageUrl: '',
      category: 'Sneakers',
      stock: 3,
    ),
  ];

  final Map<String, SelectedProduct> reservedProducts = {};
  String searchQuery = '';
  String selectedCategory = 'All';

  bool get isDesktop {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.size.width >= 1000;
  }

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

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 700) {
      return 2;
    } else if (width < 1200) {
      return 3;
    } else {
      return 4;
    }
  }

  double _getCardHeight(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 700) {
      return 450;
    } else if (width < 1200) {
      return 480;
    } else {
      return 500;
    }
  }

  void _addToReservation(int index, String size) {
    setState(() {
      final product = products[index];
      final key = '${product.name}_$size';

      // Prevent adding more than available stock
      int alreadyReserved = reservedProducts[key]?.quantity ?? 0;
      if (alreadyReserved >= product.stock) {
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
          if (!isDesktop && reservedProducts.isEmpty) {
            Navigator.pop(context);
          }
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
                  if (reservedProducts.isNotEmpty && !isDesktop)
                    ElevatedButton(
                      child: Text('Proceed to Reservation'),
                      onPressed: () async {
                        Navigator.pop(context);
                        // Await for result from ReservationFormScreen
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationFormScreen(
                              selectedProducts: reservedProducts.values.toList(),
                              onReservationSuccess: _deductStocksAfterReservation,
                            ),
                          ),
                        );
                        // Optionally handle result if needed
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
  void _deductStocksAfterReservation(List<SelectedProduct> reservedList) {
    setState(() {
      for (var sp in reservedList) {
        sp.product.stock -= sp.quantity;
        if (sp.product.stock < 0) sp.product.stock = 0;
      }
      reservedProducts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    // Set the background gradient for the whole catalog area
    return Container(
             decoration: BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [
                    colorScheme.primary.withOpacity(0.1),
                    colorScheme.secondary.withOpacity(0.1),
                  ],
         ),
       ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
        body: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
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
            
            if (isDesktop) {
              // Await for result from ReservationFormScreen
              final result = await Navigator.push(
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
              // Optionally handle result if needed
            } else {
              _showReservationBottomSheet();
            }
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
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
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  ),
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
                        label: Text(cat, style: TextStyle(fontFamily: 'Open Sans')),
                        selected: selectedCategory == cat,
                        selectedColor: const Color(0xFF0730E8),
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
                  child: Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final crossAxisCount = _getCrossAxisCount(context);
                        final cardHeight = _getCardHeight(context);
                        return GridView.builder(
                          itemCount: filteredProducts.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 0.62,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 30,
                          ),
                          itemBuilder: (context, filteredIndex) {
                            final product = filteredProducts[filteredIndex];
                            final index = products.indexOf(product);
                            final currentSize = product.sizes.first;
                            
                            return Center(
                              child: Card(
                                margin: EdgeInsets.zero,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color: Colors.white, // Make card white
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final containerWidth = constraints.maxWidth;
                                      final imageHeight = containerWidth * 0.6;
                                      final imageMargin = containerWidth * 0.08;
                                      return SizedBox(
                                        width: containerWidth,
                                        height: cardHeight,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: imageMargin),
                                            Container(
                                              height: imageHeight,
                                              width: containerWidth - imageMargin * 2,
                                              margin: EdgeInsets.symmetric(horizontal: imageMargin),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: Icon(Icons.image, size: imageHeight * 0.7, color: Colors.grey[600]),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 6),
                                                                                          Text(
                                                product.name,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: Colors.black87,
                                                  fontFamily: 'Open Sans',
                                                ),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            SizedBox(height: 2),
                                            Text('Price: ₱${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                            SizedBox(height: 2),
                                            Text('Stock: ${product.stock}', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Open Sans')),
                                            Text(product.category, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Open Sans')),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text('Size:', style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                                SizedBox(width: 2),
                                                DropdownButton<String>(
                                                  value: currentSize,
                                                  items: product.sizes
                                                      .map((size) => DropdownMenuItem(
                                                            value: size,
                                                            child: Text(size, style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                                          ))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    // Size selection handled in the add/remove functions
                                                  },
                                                  style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Open Sans'),
                                                  underline: SizedBox(),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF0730E8),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: Icon(Icons.add, color: Colors.white),
                                                  onPressed: () {
                                                    _addToReservation(index, currentSize);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(color: const Color.fromARGB(255, 211, 210, 210)!)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 2,
                blurRadius: 12,
                offset: Offset(-2, 4), // subtle shadow to the left and down
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Your Reservation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Divider(),
              if (reservedProducts.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No items selected', style: TextStyle(color: Colors.grey)),
                )
              else
                Expanded(
                  child: ListView.builder(
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
                              onPressed: () => _removeFromReservation(
                                products.indexOf(sp.product), 
                                sp.size
                              ),
                            ),
                            Text(sp.quantity.toString()),
                            IconButton(
                              icon: Icon(Icons.add, size: 20),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search shoes...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text('Category:', style: TextStyle(fontSize: 14)),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: selectedCategory,
                items: categories
                    .map((cat) => DropdownMenuItem(
                          value: cat,
                          child: Text(cat),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    selectedCategory = val!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = _getCrossAxisCount(context);
                  final cardHeight = _getCardHeight(context);
                  return GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.62,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, filteredIndex) {
                      final product = filteredProducts[filteredIndex];
                      final index = products.indexOf(product);
                      final currentSize = product.sizes.first;
                      
                      return Center(
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                final containerWidth = constraints.maxWidth;
                                final imageHeight = containerWidth * 0.6;
                                final imageMargin = containerWidth * 0.08;
                                return SizedBox(
                                  width: containerWidth,
                                  height: cardHeight,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: imageMargin),
                                      Container(
                                        height: imageHeight,
                                        width: containerWidth - imageMargin * 2,
                                        margin: EdgeInsets.symmetric(horizontal: imageMargin),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Icon(Icons.image, size: imageHeight * 0.7, color: Colors.grey[600]),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        product.name,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, fontFamily: 'Open Sans'),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 2),
                                      Text('Price: ₱${product.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                      SizedBox(height: 2),
                                      Text('Stock: ${product.stock}', style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Open Sans')),
                                      Text(product.category, style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'Open Sans')),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Size:', style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                          SizedBox(width: 2),
                                          DropdownButton<String>(
                                            value: currentSize,
                                            items: product.sizes
                                                .map((size) => DropdownMenuItem(
                                                      value: size,
                                                      child: Text(size, style: TextStyle(fontSize: 12, fontFamily: 'Open Sans')),
                                                    ))
                                                .toList(),
                                            onChanged: (val) {
                                              // Size selection handled in the add/remove functions
                                            },
                                            style: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Open Sans'),
                                            underline: SizedBox(),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                          padding: EdgeInsets.only(bottom: 6.0),
                                          child: LayoutBuilder(
                                          builder: (context, constraints) {
                                          // Calculate responsive size based on screen width
                                          final screenWidth = MediaQuery.of(context).size.width;
                                          final buttonSize = screenWidth < 700 ? 20.0 : 40.0; // Smaller on very small devices
                                          final iconSize = screenWidth < 700 ? 10.0 : 20.0; // Smaller icon on small devices

                                            return Container(
                                              width: buttonSize,
                                              height: buttonSize,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF0730E8),
                                                shape: BoxShape.circle,
                                              ),
                                              child: IconButton(
                                                icon: Icon(Icons.add, 
                                                color: Colors.white, 
                                                size: iconSize),
                                                padding: EdgeInsets.zero, // Remove default padding
                                                onPressed: () {
                                                  _addToReservation(index, currentSize);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
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
          content: Text('Are you sure you want to submit your reservation?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog

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
                    subtitle: Text('Size: ${sp.size} | ₱${(sp.product.price * sp.quantity).toStringAsFixed(2)}'),
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
                    : 'Pickup Date: ${selectedDate!.toLocal()}'.split(' ')[0]),
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Ticket'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
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
                    Icon(Icons.shopping_bag, size: 30, color: Colors.blue),
                    SizedBox(width: 10),
                    Text('SHOEVAULT', 
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Text('PICKUP RESERVATION RECEIPT', 
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Divider(thickness: 2, color: Colors.blue),
                SizedBox(height: 10),
                
                // Store Info
                Text('Manghinao, Bauan, Batangas', style: TextStyle(fontSize: 12)),
                Text('Contact: 0917-123-4567', style: TextStyle(fontSize: 12)),
                Text('Email: shoevaultbats@gmail.com', style: TextStyle(fontSize: 12)),
                SizedBox(height: 10),
                Divider(thickness: 1),
                
                // Customer Info
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('CUSTOMER DETAILS:', 
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.email, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(email),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.phone, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(phone),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('${date.toLocal()}'.split(' ')[0]),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(time.format(context)),
                  ],
                ),
                
                Divider(thickness: 1),
                SizedBox(height: 10),
                
                // Items
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('RESERVED ITEMS:', 
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 8),
                ...selectedProducts.map((sp) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text('${sp.product.name} (Size: ${sp.size}) x${sp.quantity}'),
                      ),
                      Text('₱${(sp.product.price * sp.quantity).toStringAsFixed(2)}'),
                    ],
                  ),
                )),
                
                Divider(thickness: 1),
                SizedBox(height: 10),
                
                // Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('₱${total.toStringAsFixed(2)}', 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                
                SizedBox(height: 20),
                // Footer notes
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Text('Thank you for your reservation!', 
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      SizedBox(height: 5),
                      Text('Please bring this ticket when picking up your items.',
                          style: TextStyle(fontSize: 12)),
                      Text('Valid ID and proof of payment required.',
                          style: TextStyle(fontSize: 12)),
                      SizedBox(height: 5),
                      Text('Reservation ID: ${DateTime.now().millisecondsSinceEpoch}',
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.share),
                      label: Text('Share'),
                      onPressed: () {
                        // Share functionality would go here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Sharing receipt...')),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextButton(
                  child: Text('Back to Catalog'),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}