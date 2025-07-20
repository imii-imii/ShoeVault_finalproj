import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'loginpage.dart' as login;
import 'reservation_service.dart';

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
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme() {
    setState(() {
      switch (_themeMode) {
        case ThemeMode.system:
          _themeMode = ThemeMode.light;
          break;
        case ThemeMode.light:
          _themeMode = ThemeMode.dark;
          break;
        case ThemeMode.dark:
          _themeMode = ThemeMode.system;
          break;
      }
    });
  }

  String get currentThemeLabel {
    switch (_themeMode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  IconData get currentThemeIcon {
    switch (_themeMode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

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
          color: Colors.white,
          elevation: 2,
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
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFF121212),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1F1F1F),
          foregroundColor: Colors.white,
          elevation: 0.5,
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF1E1E1E),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(8),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.white70,
          ),
        ),
      ),
      themeMode: _themeMode,
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
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Update time every minute
    _updateTime();
  }

  void _updateTime() {
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
        _updateTime();
      }
    });
  }

  String _formatDateTime(DateTime dateTime) {
    // Fixed date: June 28, 2025
    final fixedDate = 'Jun 28, 2025';
    
    // Real-time with seconds
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final second = dateTime.second.toString().padLeft(2, '0');
    
    return '$fixedDate\n$hour:$minute:$second';
  }

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
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/pictures/shoevault_logo.png',
                    height: 100,
                    width: 180,
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
            // Time and Date Display
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 24,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  SizedBox(height: 8),
                  Text(
                    _formatDateTime(_currentTime),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            // Theme Toggle
            ListTile(
              leading: Icon(MyApp.of(context)?.currentThemeIcon ?? Icons.brightness_auto),
              title: Text('Theme: ${MyApp.of(context)?.currentThemeLabel ?? 'System'}'),
              subtitle: Text('Tap to cycle through themes'),
              onTap: () {
                MyApp.of(context)?.toggleTheme();
              },
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
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int selectedRange = 0; // 0: Daily, 1: Week, 2: Month, 3: Quarter
  DateTime selectedDate = DateTime.now();
  
  // Date range limits
  final DateTime minDate = DateTime(2023, 6, 1);
  final DateTime maxDate = DateTime(2025, 6, 28);

  @override
  void initState() {
    super.initState();
    // Ensure initial date is within range
    if (selectedDate.isBefore(minDate)) {
      selectedDate = minDate;
    } else if (selectedDate.isAfter(maxDate)) {
      selectedDate = maxDate;
    }
  }

  // Show date picker
  Future<void> _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: minDate,
      lastDate: maxDate,
      helpText: 'Select Date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.blue,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Get date range string for display
  String getDateRangeString() {
    switch (selectedRange) {
      case 0: // Daily
        return '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      case 1: // Week
        DateTime startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
        return '${startOfWeek.day}/${startOfWeek.month} - ${endOfWeek.day}/${endOfWeek.month}/${endOfWeek.year}';
      case 2: // Month
        List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return '${months[selectedDate.month - 1]} ${selectedDate.year}';
      case 3: // Quarter
        int quarter = ((selectedDate.month - 1) ~/ 3) + 1;
        return 'Q$quarter ${selectedDate.year}';
      default:
        return '';
    }
  }

  // Data for different time ranges
  Map<String, dynamic> getDataForRange() {
    // Generate data based on date and range type
    final dateKey = '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
    final hash = dateKey.hashCode.abs();
    
    switch (selectedRange) {
      case 0: // Daily
        final baseReservations = 15 + (hash % 20); // 15-35 per day
        final basePickups = (baseReservations * 0.7).round() + (hash % 5);
        final pending = (baseReservations * 0.2).round() + (hash % 3);
        final cancelled = (baseReservations - basePickups - pending).clamp(0, baseReservations);
        
        return {
          'totalReservations': baseReservations.toString(),
          'completedPickups': basePickups.toString(),
          'pendingPickups': pending.toString(),
          'cancelled': cancelled.toString(),
          'chartTitle': 'Hourly Reservations vs Pickups on ${getDateRangeString()}',
          'chartLabels': ['9AM', '11AM', '1PM', '3PM', '5PM', '7PM', '9PM'],
          'chartData': _generateHourlyData(baseReservations, basePickups),
        };
      case 1: // Week
        final weekStart = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
        final weekHash = '${weekStart.year}-${weekStart.month}-${weekStart.day}'.hashCode.abs();
        final baseReservations = 180 + (weekHash % 100); // 180-280 per week
        final basePickups = (baseReservations * 0.75).round() + (weekHash % 20);
        final pending = (baseReservations * 0.15).round() + (weekHash % 15);
        final cancelled = (baseReservations - basePickups - pending).clamp(0, baseReservations);
        
        return {
          'totalReservations': baseReservations.toString(),
          'completedPickups': basePickups.toString(),
          'pendingPickups': pending.toString(),
          'cancelled': cancelled.toString(),
          'chartTitle': 'Daily Reservations vs Pickups for week ${getDateRangeString()}',
          'chartLabels': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
          'chartData': _generateWeeklyData(baseReservations, basePickups),
        };
      case 2: // Month
        final monthHash = '${selectedDate.year}-${selectedDate.month}'.hashCode.abs();
        final baseReservations = 800 + (monthHash % 600); // 800-1400 per month
        final basePickups = (baseReservations * 0.8).round() + (monthHash % 50);
        final pending = (baseReservations * 0.12).round() + (monthHash % 30);
        final cancelled = (baseReservations - basePickups - pending).clamp(0, baseReservations);
        
        return {
          'totalReservations': _formatNumber(baseReservations),
          'completedPickups': _formatNumber(basePickups),
          'pendingPickups': pending.toString(),
          'cancelled': cancelled.toString(),
          'chartTitle': 'Weekly Reservations vs Pickups for ${getDateRangeString()}',
          'chartLabels': ['Week 1', 'Week 2', 'Week 3', 'Week 4'],
          'chartData': _generateMonthlyData(baseReservations, basePickups),
        };
      case 3: // Quarter
        final quarter = ((selectedDate.month - 1) ~/ 3) + 1;
        final quarterHash = '${selectedDate.year}-Q$quarter'.hashCode.abs();
        final baseReservations = 2500 + (quarterHash % 1500); // 2500-4000 per quarter
        final basePickups = (baseReservations * 0.82).round() + (quarterHash % 100);
        final pending = (baseReservations * 0.1).round() + (quarterHash % 50);
        final cancelled = (baseReservations - basePickups - pending).clamp(0, baseReservations);
        
        return {
          'totalReservations': _formatNumber(baseReservations),
          'completedPickups': _formatNumber(basePickups),
          'pendingPickups': pending.toString(),
          'cancelled': cancelled.toString(),
          'chartTitle': 'Monthly Reservations vs Pickups for ${getDateRangeString()}',
          'chartLabels': _getQuarterMonthLabels(),
          'chartData': _generateQuarterlyData(baseReservations, basePickups),
        };
      default:
        return getDataForRange();
    }
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k'.replaceAll('.0k', 'k');
    }
    return number.toString();
  }

  List<String> _getQuarterMonthLabels() {
    final quarter = ((selectedDate.month - 1) ~/ 3) + 1;
    const monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final startMonth = (quarter - 1) * 3;
    return [
      monthNames[startMonth],
      monthNames[startMonth + 1],
      monthNames[startMonth + 2],
    ];
  }

  List<Map<String, double>> _generateHourlyData(int totalReservations, int totalPickups) {
    final hash = selectedDate.hashCode.abs();
    final hourlyData = <Map<String, double>>[];
    
    for (int i = 0; i < 7; i++) {
      final hourHash = (hash + i * 17) % 100;
      final reservations = (totalReservations / 7 * (0.5 + hourHash / 100)).round().toDouble();
      final pickups = (reservations * (0.6 + (hourHash % 30) / 100)).round().toDouble();
      
      hourlyData.add({
        'reservations': reservations,
        'pickups': pickups,
      });
    }
    
    return hourlyData;
  }

  List<Map<String, double>> _generateWeeklyData(int totalReservations, int totalPickups) {
    final hash = selectedDate.hashCode.abs();
    final dailyData = <Map<String, double>>[];
    
    for (int i = 0; i < 7; i++) {
      final dayHash = (hash + i * 23) % 100;
      final reservations = (totalReservations / 7 * (0.7 + dayHash / 200)).round().toDouble();
      final pickups = (reservations * (0.65 + (dayHash % 25) / 100)).round().toDouble();
      
      dailyData.add({
        'reservations': reservations,
        'pickups': pickups,
      });
    }
    
    return dailyData;
  }

  List<Map<String, double>> _generateMonthlyData(int totalReservations, int totalPickups) {
    final hash = selectedDate.hashCode.abs();
    final weeklyData = <Map<String, double>>[];
    
    for (int i = 0; i < 4; i++) {
      final weekHash = (hash + i * 31) % 100;
      final reservations = (totalReservations / 4 * (0.8 + weekHash / 250)).round().toDouble();
      final pickups = (reservations * (0.7 + (weekHash % 20) / 100)).round().toDouble();
      
      weeklyData.add({
        'reservations': reservations,
        'pickups': pickups,
      });
    }
    
    return weeklyData;
  }

  List<Map<String, double>> _generateQuarterlyData(int totalReservations, int totalPickups) {
    final hash = selectedDate.hashCode.abs();
    final monthlyData = <Map<String, double>>[];
    
    for (int i = 0; i < 3; i++) {
      final monthHash = (hash + i * 37) % 100;
      final reservations = (totalReservations / 3 * (0.85 + monthHash / 300)).round().toDouble();
      final pickups = (reservations * (0.75 + (monthHash % 15) / 100)).round().toDouble();
      
      monthlyData.add({
        'reservations': reservations,
        'pickups': pickups,
      });
    }
    
    return monthlyData;
  }

  // Date navigation methods
  void _goToPreviousPeriod() {
    DateTime newDate;
    switch (selectedRange) {
      case 0: // Daily
        newDate = selectedDate.subtract(Duration(days: 1));
        break;
      case 1: // Week
        newDate = selectedDate.subtract(Duration(days: 7));
        break;
      case 2: // Month
        newDate = DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
        break;
      case 3: // Quarter
        newDate = DateTime(selectedDate.year, selectedDate.month - 3, selectedDate.day);
        break;
      default:
        newDate = selectedDate;
    }
    
    // Ensure new date is within range
    if (!newDate.isBefore(minDate)) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  void _goToNextPeriod() {
    DateTime newDate;
    switch (selectedRange) {
      case 0: // Daily
        newDate = selectedDate.add(Duration(days: 1));
        break;
      case 1: // Week
        newDate = selectedDate.add(Duration(days: 7));
        break;
      case 2: // Month
        newDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
        break;
      case 3: // Quarter
        newDate = DateTime(selectedDate.year, selectedDate.month + 3, selectedDate.day);
        break;
      default:
        newDate = selectedDate;
    }
    
    // Ensure new date is within range
    if (!newDate.isAfter(maxDate)) {
      setState(() {
        selectedDate = newDate;
      });
    }
  }

  void _goToToday() {
    DateTime today = DateTime.now();
    // Clamp to date range
    if (today.isBefore(minDate)) {
      today = minDate;
    } else if (today.isAfter(maxDate)) {
      today = maxDate;
    }
    
    setState(() {
      selectedDate = today;
    });
  }

  bool _canGoToPrevious() {
    DateTime testDate;
    switch (selectedRange) {
      case 0: // Daily
        testDate = selectedDate.subtract(Duration(days: 1));
        break;
      case 1: // Week
        testDate = selectedDate.subtract(Duration(days: 7));
        break;
      case 2: // Month
        testDate = DateTime(selectedDate.year, selectedDate.month - 1, selectedDate.day);
        break;
      case 3: // Quarter
        testDate = DateTime(selectedDate.year, selectedDate.month - 3, selectedDate.day);
        break;
      default:
        return false;
    }
    return !testDate.isBefore(minDate);
  }

  bool _canGoToNext() {
    DateTime testDate;
    switch (selectedRange) {
      case 0: // Daily
        testDate = selectedDate.add(Duration(days: 1));
        break;
      case 1: // Week
        testDate = selectedDate.add(Duration(days: 7));
        break;
      case 2: // Month
        testDate = DateTime(selectedDate.year, selectedDate.month + 1, selectedDate.day);
        break;
      case 3: // Quarter
        testDate = DateTime(selectedDate.year, selectedDate.month + 3, selectedDate.day);
        break;
      default:
        return false;
    }
    return !testDate.isAfter(maxDate);
  }

  String _getPeriodName() {
    switch (selectedRange) {
      case 0:
        return 'Day';
      case 1:
        return 'Week';
      case 2:
        return 'Month';
      case 3:
        return 'Quarter';
      default:
        return 'Period';
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

  List<BarChartGroupData> _getBarGroups(BuildContext context) {
    final chartData = getDataForRange()['chartData'] as List<Map<String, double>>;
    return chartData.asMap().entries.map((entry) {
      return _makeBarGroup(
        context,
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
          
          // Time Range Selection with Date Navigation
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ToggleButtons(
                      isSelected: [
                        selectedRange == 0,
                        selectedRange == 1,
                        selectedRange == 2,
                        selectedRange == 3,
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
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Daily'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Week'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Month'),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('Quarter'),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    
                    // Date Navigation
                    Row(
                      children: [
                        IconButton(
                          onPressed: _canGoToPrevious() ? _goToPreviousPeriod : null,
                          icon: Icon(Icons.arrow_back_ios),
                          tooltip: 'Previous ${_getPeriodName()}',
                        ),
                        Expanded(
                          child: Center(
                            child: Tooltip(
                              message: 'Click to select date (${minDate.day}/${minDate.month}/${minDate.year} - ${maxDate.day}/${maxDate.month}/${maxDate.year})',
                              child: InkWell(
                                onTap: _showDatePicker,
                                borderRadius: BorderRadius.circular(8),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context).brightness == Brightness.dark 
                                          ? Colors.white30 
                                          : Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        getDateRangeString(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).textTheme.titleMedium?.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: _canGoToNext() ? _goToNextPeriod : null,
                          icon: Icon(Icons.arrow_forward_ios),
                          tooltip: 'Next ${_getPeriodName()}',
                        ),
                        SizedBox(width: 8),
                        TextButton(
                          onPressed: _goToToday,
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          child: Text('Today'),
                        ),
                      ],
                    ),
                  ],
                ),
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
                crossAxisCount: isMobile ? 1 : 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: isMobile ? 3.5 : 2.2,
                children: [
              _buildSummaryCard(
                context,
                icon: Icons.inventory_2,
                label: 'Total Reservations',
                value: data['totalReservations'],
                colorScheme: 'blue',
              ),
              _buildSummaryCard(
                context,
                icon: Icons.people,
                label: 'Completed Pickups',
                value: data['completedPickups'],
                colorScheme: 'green',
              ),
              _buildSummaryCard(
                context,
                icon: Icons.access_time,
                label: 'Pending Pickups',
                value: data['pendingPickups'],
                colorScheme: 'orange',
              ),
              _buildSummaryCard(
                context,
                icon: Icons.trending_up,
                label: 'Cancelled',
                value: data['cancelled'],
                colorScheme: 'red',
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
              color: Theme.of(context).cardTheme.color,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.black.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.1),
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
                                color: Theme.of(context).textTheme.bodyMedium?.color,
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
                barGroups: _getBarGroups(context),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegend(context, Colors.blue, 'Reservations'),
              SizedBox(width: 16),
              _buildLegend(context, Colors.green, 'Pickups'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required String colorScheme,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Color backgroundColor;
    Color iconColor;
    
    switch (colorScheme) {
      case 'blue':
        backgroundColor = isDark ? Colors.blue.withOpacity(0.2) : Colors.blue[50]!;
        iconColor = Colors.blue;
        break;
      case 'green':
        backgroundColor = isDark ? Colors.green.withOpacity(0.2) : Colors.green[50]!;
        iconColor = Colors.green;
        break;
      case 'orange':
        backgroundColor = isDark ? Colors.orange.withOpacity(0.2) : Colors.orange[50]!;
        iconColor = Colors.orange;
        break;
      case 'red':
        backgroundColor = isDark ? Colors.red.withOpacity(0.2) : Colors.red[50]!;
        iconColor = Colors.red;
        break;
      default:
        backgroundColor = isDark ? Colors.grey.withOpacity(0.2) : Colors.grey[50]!;
        iconColor = Colors.grey;
    }

    return Card(
      color: backgroundColor,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 32),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value, 
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    label, 
                    style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
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

  BarChartGroupData _makeBarGroup(BuildContext context, int x, double reservations, double pickups) {
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

  Widget _buildLegend(BuildContext context, Color color, String label) {
    return Row(
      children: [
        Container(width: 16, height: 8, color: color),
        SizedBox(width: 4),
        Text(
          label, 
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
      ],
    );
  }
}

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  String selectedStatus = 'All Status';
  List<String> statusOptions = ['All Status', 'Pending', 'Completed', 'Cancelled'];
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> reservations = [];

  @override
  void initState() {
    super.initState();
    _loadReservations();
  }

  Future<void> _loadReservations() async {
    final data = await ReservationService.getReservationsAsMap();
    setState(() {
      reservations = data;
    });
  }

  void _deleteReservation(String reservationId) async {
    await ReservationService.deleteReservation(reservationId);
    await _loadReservations();
    
    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reservation $reservationId has been deleted'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAsCompleted(String reservationId) async {
    await ReservationService.updateReservationStatus(reservationId, 'Completed', 'Completed successfully');
    await _loadReservations();
    
    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reservation $reservationId marked as completed'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _markAsCancelled(String reservationId) async {
    await ReservationService.updateReservationStatus(reservationId, 'Cancelled', 'Cancelled by admin');
    await _loadReservations();
    
    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reservation $reservationId has been cancelled'),
        backgroundColor: Colors.red,
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

  void _showCompletionConfirmation(String reservationId, String customerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mark as Completed'),
          content: Text('Are you sure you want to mark the reservation for $customerName as completed?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _markAsCompleted(reservationId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.green),
              child: Text('Mark Completed'),
            ),
          ],
        );
      },
    );
  }

  void _showCancellationConfirmation(String reservationId, String customerName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Reservation'),
          content: Text('Are you sure you want to cancel the reservation for $customerName?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _markAsCancelled(reservationId);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.orange),
              child: Text('Cancel Reservation'),
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
               reservation['phone'].toLowerCase().contains(query) ||
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
      reservation['status'] == 'Pending' && 
      reservation['days'].contains('Expires today')
    ).length;
  }

  int get completedCount {
    return reservations.where((reservation) => 
      reservation['status'] == 'Completed'
    ).length;
  }

  int get pendingCount {
    return reservations.where((reservation) =>
      reservation['status'] == 'Pending'
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
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Manage overdue and expiring reservations',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          SizedBox(height: 20),
          
          // Statistics Cards
          LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 600;
              bool isTablet = constraints.maxWidth < 1000;
              
              return GridView.count(
                crossAxisCount: isMobile ? 2 : isTablet ? 3 : 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: isMobile ? 8 : constraints.maxWidth * 0.02,
                crossAxisSpacing: isMobile ? 8 : constraints.maxWidth * 0.02,
                childAspectRatio: isMobile ? 1.1 : isTablet ? 1.4 : 1.5,
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
                    value: pendingCount.toString(),
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
                child:                 TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search by customer, email, phone, shoe, or ID...',
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
              SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  await _loadReservations();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data refreshed successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                icon: Icon(Icons.refresh),
                label: Text('Refresh'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

          
          // Data Table
          LayoutBuilder(
            builder: (context, constraints) {
              if (filteredReservations.isEmpty) {
                return _buildEmptyState();
              }
              
              // Responsive breakpoints
              if (constraints.maxWidth < 800) {
                return _buildMobileReservationList();
              } else if (constraints.maxWidth < 1200) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildTabletReservationTable(constraints.maxWidth),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildDesktopReservationTable(constraints.maxWidth),
                );
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    
    // Tone down the background colors for dark mode
    Color adjustedBgColor = isDark 
        ? color.withOpacity(0.15) 
        : bgColor;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : screenWidth * 0.02),
      decoration: BoxDecoration(
        color: adjustedBgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon, 
            color: color, 
            size: isMobile ? 24 : screenWidth * 0.025,
          ),
          SizedBox(height: isMobile ? 6 : screenWidth * 0.01),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 20 : screenWidth * 0.025,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: isMobile ? 2 : screenWidth * 0.005),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: isMobile ? 12 : screenWidth * 0.012,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
                    Expanded(
                      child: Text(
                        reservation['id'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[600],
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8),
                    _buildStatusChip(reservation['status']),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  reservation['customer'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                  ),
                ),
                Text(
                  reservation['email'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                Text(
                  reservation['phone'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${reservation['shoe']} - ${reservation['size']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.titleMedium?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date: ${reservation['date']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                          Text(
                            'Pickup: ${reservation['pickup']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      reservation['days'],
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(reservation['status']),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (reservation['status'] == 'Pending') ...[
                      IconButton(
                        onPressed: () => _showCompletionConfirmation(
                          reservation['id'],
                          reservation['customer'],
                        ),
                        icon: Icon(Icons.check, color: Colors.green),
                        iconSize: 20,
                        tooltip: 'Mark as Completed',
                      ),
                      IconButton(
                        onPressed: () => _showCancellationConfirmation(
                          reservation['id'],
                          reservation['customer'],
                        ),
                        icon: Icon(Icons.cancel, color: Colors.orange),
                        iconSize: 20,
                        tooltip: 'Cancel Reservation',
                      ),
                    ],
                    IconButton(
                      onPressed: () => _showDeleteConfirmation(
                        reservation['id'],
                        reservation['customer'],
                      ),
                      icon: Icon(Icons.delete, color: Colors.red),
                      iconSize: 20,
                      tooltip: 'Delete Reservation',
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

  Widget _buildTabletReservationTable(double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: DataTable(
        columnSpacing: screenWidth * 0.015, // Reduced spacing for better fit
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: screenWidth * 0.011, // Slightly smaller font
        ),
        columns: [
          DataColumn(
            label: Expanded(
              child: Text('ID'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('CUSTOMER'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('PHONE'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('SHOE'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('DATE'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('STATUS'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('ACTIONS'),
            ),
            numeric: false,
          ),
        ],
        rows: filteredReservations.map((reservation) {
          return DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: screenWidth * 0.07,
                  child: Text(
                    reservation['id'],
                    style: TextStyle(
                      color: Colors.blue[600],
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth * 0.010,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.18,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reservation['customer'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500, 
                          fontSize: screenWidth * 0.011,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        reservation['email'],
                        style: TextStyle(
                          fontSize: screenWidth * 0.009,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.10,
                  child: Text(
                    reservation['phone'],
                    style: TextStyle(fontSize: screenWidth * 0.010),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reservation['shoe'],
                        style: TextStyle(fontSize: screenWidth * 0.011),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        reservation['size'],
                        style: TextStyle(
                          fontSize: screenWidth * 0.009,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reservation['date'],
                        style: TextStyle(fontSize: screenWidth * 0.010),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        reservation['pickup'],
                        style: TextStyle(
                          fontSize: screenWidth * 0.009,
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.07,
                  child: _buildStatusChip(reservation['status']),
                ),
              ),
              DataCell(
                SizedBox(
                  width: screenWidth * 0.15,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (reservation['status'] == 'Pending') ...[
                        IconButton(
                          onPressed: () => _showCompletionConfirmation(
                            reservation['id'],
                            reservation['customer'],
                          ),
                          icon: Icon(Icons.check, color: Colors.green),
                          iconSize: screenWidth * 0.014,
                          tooltip: 'Mark as Completed',
                        ),
                        IconButton(
                          onPressed: () => _showCancellationConfirmation(
                            reservation['id'],
                            reservation['customer'],
                          ),
                          icon: Icon(Icons.cancel, color: Colors.orange),
                          iconSize: screenWidth * 0.014,
                          tooltip: 'Cancel Reservation',
                        ),
                      ],
                      IconButton(
                        onPressed: () => _showDeleteConfirmation(
                          reservation['id'],
                          reservation['customer'],
                        ),
                        icon: Icon(Icons.delete, color: Colors.red),
                        iconSize: screenWidth * 0.014,
                        tooltip: 'Delete Reservation',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDesktopReservationTable(double screenWidth) {
    return SizedBox(
      width: screenWidth,
      child: DataTable(
        columnSpacing: screenWidth * 0.012, // Reduced spacing for better fit
        headingTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: screenWidth * 0.009, // Slightly smaller font
        ),
        columns: [
          DataColumn(
            label: Expanded(
              child: Text('RESERVATION ID'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('CUSTOMER'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('PHONE'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('SHOE DETAILS'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('RESERVATION DATE'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('EXPECTED PICKUP'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('STATUS'),
            ),
            numeric: false,
          ),
          DataColumn(
            label: Expanded(
              child: Text('ACTIONS'),
            ),
            numeric: false,
          ),
        ],
        rows: filteredReservations.map((reservation) {
          return DataRow(
                          cells: [
                                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.08,
                      child: Text(
                        reservation['id'],
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.008,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.13,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            reservation['customer'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: screenWidth * 0.008,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            reservation['email'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.007,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.08,
                      child: Text(
                        reservation['phone'],
                        style: TextStyle(fontSize: screenWidth * 0.008),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            reservation['shoe'],
                            style: TextStyle(fontSize: screenWidth * 0.008),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            reservation['size'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.007,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.08,
                      child: Text(
                        reservation['date'],
                        style: TextStyle(fontSize: screenWidth * 0.008),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.08,
                      child: Text(
                        reservation['pickup'],
                        style: TextStyle(fontSize: screenWidth * 0.008),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.06,
                      child: _buildStatusChip(reservation['status']),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: screenWidth * 0.18,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (reservation['status'] == 'Pending') ...[
                            IconButton(
                              onPressed: () => _showCompletionConfirmation(
                                reservation['id'],
                                reservation['customer'],
                              ),
                              icon: Icon(Icons.check, color: Colors.green),
                              iconSize: screenWidth * 0.011,
                              tooltip: 'Mark as Completed',
                            ),
                            IconButton(
                              onPressed: () => _showCancellationConfirmation(
                                reservation['id'],
                                reservation['customer'],
                              ),
                              icon: Icon(Icons.cancel, color: Colors.orange),
                              iconSize: screenWidth * 0.011,
                              tooltip: 'Cancel Reservation',
                            ),
                          ],
                          IconButton(
                            onPressed: () => _showDeleteConfirmation(
                              reservation['id'],
                              reservation['customer'],
                            ),
                            icon: Icon(Icons.delete, color: Colors.red),
                            iconSize: screenWidth * 0.011,
                            tooltip: 'Delete Reservation',
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    Color color;
    Color backgroundColor;
    
    switch (status) {
      case 'Cancelled':
        color = Colors.red;
        backgroundColor = isDark ? Colors.red.withOpacity(0.2) : Colors.red[50]!;
        break;
      case 'Pending':
        color = Colors.yellow[700]!;
        backgroundColor = isDark ? Colors.yellow.withOpacity(0.2) : Colors.yellow[50]!;
        break;
      case 'Completed':
        color = Colors.green;
        backgroundColor = isDark ? Colors.green.withOpacity(0.2) : Colors.green[50]!;
        break;
      case 'Expired Today':
        color = Colors.orange;
        backgroundColor = isDark ? Colors.orange.withOpacity(0.2) : Colors.orange[50]!;
        break;
      default:
        color = Colors.grey;
        backgroundColor = isDark ? Colors.grey.withOpacity(0.2) : Colors.grey[50]!;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : screenWidth * 0.006, 
        vertical: isMobile ? 4 : screenWidth * 0.003,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: isMobile ? 12 : screenWidth * 0.009,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Cancelled':
        return Colors.red;
      case 'Pending':
        return Colors.yellow[700]!;
      case 'Completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}

