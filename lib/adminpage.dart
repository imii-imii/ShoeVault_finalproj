import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

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
    {'icon': Icons.assignment, 'title' : 'Reports'}
  ];

  void _onSelectItem(int index) {
    setState(() {
      _selectedDrawerIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_drawerItems[_selectedDrawerIndex]['title']), // Dynamic title
      ),
      drawer: Drawer(
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
                value: '1247',
                color: Colors.blue[50],
                iconColor: Colors.blue,
              ),
              _buildSummaryCard(
                icon: Icons.people,
                label: 'Completed Pickups',
                value: '1089',
                color: Colors.green[50],
                iconColor: Colors.green,
              ),
              _buildSummaryCard(
                icon: Icons.access_time,
                label: 'Pending Pickups',
                value: '89',
                color: Colors.orange[50],
                iconColor: Colors.orange,
              ),
              _buildSummaryCard(
                icon: Icons.trending_up,
                label: 'Cancelled',
                value: '69',
                color: Colors.red[50],
                iconColor: Colors.red,
              ),
            ],
          );
        },
      ),
          SizedBox(height: 24),
          Text(
            'Daily Reservations vs Pickups',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          AspectRatio(
            aspectRatio: 1.7,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 80,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        return Text(days[value.toInt()]);
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _makeBarGroup(0, 40, 25),
                  _makeBarGroup(1, 35, 30),
                  _makeBarGroup(2, 30, 28),
                  _makeBarGroup(3, 50, 35),
                  _makeBarGroup(4, 70, 45),
                  _makeBarGroup(5, 75, 60),
                  _makeBarGroup(6, 30, 20),
                ],
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
  ];

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
                    value: '4',
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
                    value: '1',
                    color: Colors.orange,
                    bgColor: Colors.orange[50]!,
                  ),
                  _buildStatCard(
                    icon: Icons.rotate_left,
                    title: 'Due At Risk',
                    value: '5',
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
                  decoration: InputDecoration(
                    hintText: 'Search reservations...',
                    prefixIcon: Icon(Icons.search),
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
      children: reservations.map((reservation) {
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
                      onPressed: () {},
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
        rows: reservations.map((reservation) {
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
                  onPressed: () {},
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


