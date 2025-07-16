import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loginpage.dart' as login;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin - ShoeVaultBatangas',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF7F9FB),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.black54,
          ),
        ),
      ),
      home: OwnerPage(),
    );
  }
}

class OwnerPage extends StatefulWidget {
  const OwnerPage({super.key});
  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  int _selectedDrawerIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    ReportPage(),
  ];

  final List<Map<String, dynamic>> _drawerItems = [
    {'icon': Icons.analytics, 'title' : 'Dashboard'},
    {'icon': Icons.assignment, 'title' : 'Cancellation Report'}
  ];

  void _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => login.MyApp()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_drawerItems[_selectedDrawerIndex]['title']), // Dynamic title
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Header
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.store,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'ShoeVault Admin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Batangas',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Menu items
            Expanded(
              child: ListView.builder(
                itemCount: _drawerItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(_drawerItems[index]['icon']),
                    title: Text(_drawerItems[index]['title']),
                    selected: index == _selectedDrawerIndex,
                    onTap: () => _onSelectItem(index),
                  );
                },
              ),
            ),
            // Logout button at bottom
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _logout();
                          },
                          style: TextButton.styleFrom(foregroundColor: Colors.red),
                          child: Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedDrawerIndex],
    );
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedRange = 0; // 0: Week, 1: Month, 2: Quarter

  // Data for different time ranges
  Map<String, dynamic> getDataForRange() {
    switch (selectedRange) {
      case 0: // Week
        return {
          'totalReservations': '247',
          'completedPickups': '189',
          'pendingPickups': '35',
          'cancelled': '23',
          'chartTitle': 'Daily Reservations vs Pickups during June 6-12',
          'chartLabels': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          'chartData': [
            {'reservations': 40.0, 'pickups': 25.0},
            {'reservations': 35.0, 'pickups': 30.0},
            {'reservations': 30.0, 'pickups': 28.0},
            {'reservations': 50.0, 'pickups': 35.0},
            {'reservations': 70.0, 'pickups': 45.0},
            {'reservations': 75.0, 'pickups': 60.0},
            {'reservations': 30.0, 'pickups': 20.0},
          ],
        };
      case 1: // Month
        return {
          'totalReservations': '1,247',
          'completedPickups': '1,089',
          'pendingPickups': '89',
          'cancelled': '69',
          'chartTitle': 'Weekly Reservations vs Pickups during June 2025',
          'chartLabels': ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
          'chartData': [
            {'reservations': 280.0, 'pickups': 245.0},
            {'reservations': 320.0, 'pickups': 290.0},
            {'reservations': 310.0, 'pickups': 275.0},
            {'reservations': 337.0, 'pickups': 279.0},
          ],
        };
      case 2: // Quarter
        return {
          'totalReservations': '3,741',
          'completedPickups': '3,267',
          'pendingPickups': '267',
          'cancelled': '207',
          'chartTitle': 'Monthly Reservations vs Pickups during the 2nd Quarter of 2025',
          'chartLabels': ['April', 'May', 'June'],
          'chartData': [
            {'reservations': 1100.0, 'pickups': 980.0},
            {'reservations': 1247.0, 'pickups': 1089.0},
            {'reservations': 1394.0, 'pickups': 1198.0},
          ],
        };
      default:
        return getDataForRange();
    }
  }

  double _getMaxYValue() {
    final chartData = getDataForRange()['chartData'] as List<Map<String, double>>;
    double maxVal = 0;
    for (var data in chartData) {
      if (data['reservations']! > maxVal) maxVal = data['reservations']!;
      if (data['pickups']! > maxVal) maxVal = data['pickups']!;
    }
    
    // Round up to nearest nice number based on scale
    if (maxVal < 100) {
      return (maxVal * 1.2).ceilToDouble();
    } else if (maxVal < 1000) {
      return ((maxVal * 1.2) / 100).ceil() * 100;
    } else {
      return ((maxVal * 1.2) / 500).ceil() * 500;
    }
  }

  double _getYAxisInterval() {
    double maxY = _getMaxYValue();
    if (maxY <= 100) {
      return 20;
    } else if (maxY <= 500) {
      return 100;
    } else if (maxY <= 1000) {
      return 200;
    } else {
      return 500;
    }
  }

  List<BarChartGroupData> _getBarGroups() {
    final chartData = getDataForRange()['chartData'] as List<Map<String, double>>;
    return chartData.asMap().entries.map((entry) {
      return _makeBarGroup(
        entry.key,
        entry.value['reservations']!,
        entry.value['pickups']!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shoe Reservation Analytics',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 4),
          Text(
            'Track reservations, pickups, and customer patterns',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16),
          ToggleButtons(
            isSelected: [
              selectedRange == 0,
              selectedRange == 1,
              selectedRange == 2,
            ],
            onPressed: (index) {
              setState(() {
                selectedRange = index;
              });
            },
            borderRadius: BorderRadius.circular(15),
            fillColor: Colors.blue,
            selectedColor: Colors.white,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Week'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Month'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Quarter'),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Summary cards
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;
              final data = getDataForRange();
              
              return GridView.count(
                crossAxisCount: isMobile ? 1 : 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: isMobile ? 3.5 : 2.2,
                children: [
              _buildSummaryCard(
                icon: Icons.inventory_2,
                label: 'Total Reservations',
                value: data['totalReservations'],
                color: Colors.blue[50],
                iconColor: Colors.blue,
              ),
              _buildSummaryCard(
                icon: Icons.people,
                label: 'Completed Pickups',
                value: data['completedPickups'],
                color: Colors.green[50],
                iconColor: Colors.green,
              ),
              _buildSummaryCard(
                icon: Icons.access_time,
                label: 'Pending Pickups',
                value: data['pendingPickups'],
                color: Colors.orange[50],
                iconColor: Colors.orange,
              ),
              _buildSummaryCard(
                icon: Icons.trending_up,
                label: 'Cancelled',
                value: data['cancelled'],
                color: Colors.red[50],
                iconColor: Colors.red,
              ),
            ],
          );
        },
      ),
          SizedBox(height: 24),
          Text(
            getDataForRange()['chartTitle'],
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Container(
            height: 300, // Fixed height instead of aspect ratio
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: BarChart(
              key: ValueKey(selectedRange), // Add key for smooth transitions
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxYValue(),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true, 
                      reservedSize: 50, // Increased from 28 to 50
                      interval: _getYAxisInterval(),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40, // Added reserved space for bottom labels
                      getTitlesWidget: (value, meta) {
                        final labels = getDataForRange()['chartLabels'] as List<String>;
                        if (value.toInt() >= 0 && value.toInt() < labels.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              labels[value.toInt()],
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                barGroups: _getBarGroups(),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(Colors.blue, 'Reservations'),
              SizedBox(width: 16),
              _buildLegend(Colors.green, 'Pickups'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required IconData icon,
    required String label,
    required String value,
    Color? color,
    Color? iconColor,
  }) {
    return Card(
      color: color,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(label, style: TextStyle(fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double reservations, double pickups) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: reservations,
          color: Colors.blue,
          width: 12,
          borderRadius: BorderRadius.circular(4),
        ),
        BarChartRodData(
          toY: pickups,
          color: Colors.green,
          width: 12,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
      barsSpace: 4,
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 8, color: color),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ReportPage extends StatefulWidget {
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedStatus = 'All Status';
  List<String> statusOptions = ['All Status', 'Pending', 'Completed', 'Cancelled'];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> reservations = [
    {
      'id': 'REV-001',
      'customer': 'John Smith',
      'email': 'john.smith@email.com',
      'shoe': 'Nike Air Max 270',
      'size': 'Size 42',
      'date': '2025-06-28',
      'pickup': '2025-06-27',
      'status': 'Cancelled',
      'days': '7 days overdue'
    },
    {
      'id': 'REV-002',
      'customer': 'Sarah Johnson',
      'email': 'sarah.johnson@email.com',
      'shoe': 'Adidas Ultraboost 22',
      'size': 'Size 38',
      'date': '2025-06-28',
      'pickup': '2025-07-02',
      'status': 'Cancelled',
      'days': '6 days overdue'
    },
    {
      'id': 'REV-003',
      'customer': 'Mike Brown',
      'email': 'mike.brown@email.com',
      'shoe': 'Converse Chuck Taylor',
      'size': 'Size 44',
      'date': '2025-06-28',
      'pickup': '2025-07-01',
      'status': 'Expired Today',
      'days': 'Expires today'
    },
    {
      'id': 'REV-004',
      'customer': 'Emma Davis',
      'email': 'emma.davis@email.com',
      'shoe': 'Vans Old Skool',
      'size': 'Size 36',
      'date': '2025-06-16',
      'pickup': '2025-06-22',
      'status': 'Cancelled',
      'days': '14 days overdue'
    },
    {
      'id': 'REV-005',
      'customer': 'Ivan Miguel Doller',
      'email': 'ivanmigueldoller@email.com',
      'shoe': 'Nike Air Force 1',
      'size': 'Size 41',
      'date': '2025-06-16',
      'pickup': '2025-06-22',
      'status': 'Completed',
      'days': 'Completed'
    },
  ];

  void _deleteReservation(String reservationId) {
    setState(() {
      reservations.removeWhere((reservation) => reservation['id'] == reservationId);
    });
    
    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reservation $reservationId has been deleted'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showDeleteConfirmation(String reservationId, String customerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Reservation'),
          content: Text('Are you sure you want to delete the reservation for $customerName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteReservation(reservationId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> get filteredReservations {
    List<Map<String, dynamic>> filtered = reservations;
    
    // Filter by status
    if (selectedStatus != 'All Status') {
      filtered = filtered.where((reservation) => reservation['status'] == selectedStatus).toList();
    }
    
    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((reservation) {
        final query = searchQuery.toLowerCase();
        return reservation['customer'].toLowerCase().contains(query) ||
               reservation['email'].toLowerCase().contains(query) ||
               reservation['shoe'].toLowerCase().contains(query) ||
               reservation['id'].toLowerCase().contains(query) ||
               reservation['size'].toLowerCase().contains(query);
      }).toList();
    }
    
    return filtered;
  }

  int get overdueCount {
    return reservations.where((reservation) => 
      reservation['status'] == 'Cancelled' && 
      reservation['days'].contains('overdue')
    ).length;
  }

  int get expiringTodayCount {
    return reservations.where((reservation) => 
      reservation['status'] == 'Expired Today'
    ).length;
  }

  int get completedCount {
    return reservations.where((reservation) => 
      reservation['status'] == 'Completed'
    ).length;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Reservation Cancellation Report',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Manage overdue and expiring reservations',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),
          
          // Statistics Cards
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;
              
              return GridView.count(
                crossAxisCount: isMobile ? 2 : 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: isMobile ? 1.3 : 1.5,
                children: [
                  _buildStatCard(
                    icon: Icons.warning,
                    title: 'Overdue Reservations',
                    value: overdueCount.toString(),
                    color: Colors.orange,
                    bgColor: Colors.orange[50]!,
                  ),
                  _buildStatCard(
                    icon: Icons.schedule,
                    title: 'Expiring Soon',
                    value: '1',
                    color: Colors.blue,
                    bgColor: Colors.blue[50]!,
                  ),
                  _buildStatCard(
                    icon: Icons.access_time,
                    title: 'Expiring Today',
                    value: expiringTodayCount.toString(),
                    color: Colors.orange,
                    bgColor: Colors.orange[50]!,
                  ),
                  _buildStatCard(
                    icon: Icons.rotate_left,
                    title: 'Total Reservations',
                    value: reservations.length.toString(),
                    color: Colors.blue,
                    bgColor: Colors.blue[50]!,
                  ),
                ],
              );
            },
          ),
          SizedBox(height: 24),
          
          // Search and Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by customer, email, shoe, or ID...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                searchQuery = '';
                                _searchController.clear();
                              });
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedStatus,
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                    });
                  },
                  items: statusOptions.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  underline: SizedBox.shrink(),
                  icon: Icon(Icons.arrow_drop_down),
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Search results indicator
          if (searchQuery.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Icon(Icons.search, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 8),
                  Text(
                    'Found ${filteredReservations.length} result${filteredReservations.length != 1 ? 's' : ''} for "$searchQuery"',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          
          // Action Buttons
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text('Select All'),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[200],
                  foregroundColor: Colors.black87,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text('Cancel Selected (0)'),
              ),
            ],
          ),
          SizedBox(height: 16),
          
          // Data Table
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 800;
              
              if (filteredReservations.isEmpty) {
                return _buildEmptyState();
              }
              
              if (isMobile) {
                return _buildMobileReservationList();
              } else {
                return _buildDesktopReservationTable();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            searchQuery.isNotEmpty ? Icons.search_off : Icons.inbox_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty 
                ? 'No reservations found for "$searchQuery"'
                : 'No reservations found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty 
                ? 'Try adjusting your search terms or check the status filter'
                : 'Reservations will appear here once they are created',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          if (searchQuery.isNotEmpty) ...[
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  searchQuery = '';
                  _searchController.clear();
                });
              },
              child: Text('Clear Search'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color bgColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMobileReservationList() {
    return Column(
      children: filteredReservations.map((reservation) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      reservation['id'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                    ),
                    _buildStatusChip(reservation['status']),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  reservation['customer'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  reservation['email'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${reservation['shoe']} - ${reservation['size']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${reservation['date']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Pickup: ${reservation['pickup']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      reservation['days'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => _showDeleteConfirmation(
                        reservation['id'],
                        reservation['customer'],
                      ),
                      icon: Icon(Icons.close, color: Colors.red),
                      iconSize: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopReservationTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        columns: [
          DataColumn(label: Text('RESERVATION ID')),
          DataColumn(label: Text('CUSTOMER')),
          DataColumn(label: Text('SHOE DETAILS')),
          DataColumn(label: Text('RESERVATION DATE')),
          DataColumn(label: Text('EXPECTED PICKUP')),
          DataColumn(label: Text('STATUS')),
          DataColumn(label: Text('ACTIONS')),
        ],
        rows: filteredReservations.map((reservation) {
          return DataRow(
            cells: [
              DataCell(
                Text(
                  reservation['id'],
                  style: TextStyle(
                    color: Colors.blue[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      reservation['customer'],
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      reservation['email'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(reservation['shoe']),
                    Text(
                      reservation['size'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              DataCell(Text(reservation['date'])),
              DataCell(Text(reservation['pickup'])),
              DataCell(_buildStatusChip(reservation['status'])),
              DataCell(
                IconButton(
                  onPressed: () => _showDeleteConfirmation(
                    reservation['id'],
                    reservation['customer'],
                  ),
                  icon: Icon(Icons.close, color: Colors.red),
                  iconSize: 20,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    Color backgroundColor;
    
    switch (status) {
      case 'Cancelled':
        color = Colors.red;
        backgroundColor = Colors.red[50]!;
        break;
      case 'Expired Today':
        color = Colors.orange;
        backgroundColor = Colors.orange[50]!;
        break;
      default:
        color = Colors.grey;
        backgroundColor = Colors.grey[50]!;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


