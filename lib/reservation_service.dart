import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationData {
  final String id;
  final String customer;
  final String email;
  final String phone;
  final String shoe;
  final String size;
  final String date;
  final String pickup;
  final String status;
  final String days;

  ReservationData({
    required this.id,
    required this.customer,
    required this.email,
    required this.phone,
    required this.shoe,
    required this.size,
    required this.date,
    required this.pickup,
    required this.status,
    required this.days,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer': customer,
      'email': email,
      'phone': phone,
      'shoe': shoe,
      'size': size,
      'date': date,
      'pickup': pickup,
      'status': status,
      'days': days,
    };
  }

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    return ReservationData(
      id: json['id'],
      customer: json['customer'],
      email: json['email'],
      phone: json['phone'],
      shoe: json['shoe'],
      size: json['size'],
      date: json['date'],
      pickup: json['pickup'],
      status: json['status'],
      days: json['days'],
    );
  }
}

class ReservationService {
  static const String _storageKey = 'reservations';
  static int _nextId = 1;

  // Initialize with sample data if empty
  static Future<void> initializeWithSampleData() async {
    final prefs = await SharedPreferences.getInstance();
    final existingData = prefs.getString(_storageKey);
    
    if (existingData == null || existingData.isEmpty) {
      final sampleReservations = [
        ReservationData(
          id: 'REV-001',
          customer: 'John Smith',
          email: 'john.smith@email.com',
          phone: '09171234567',
          shoe: 'Nike Air Max 270',
          size: 'Size 42',
          date: '2025-06-28',
          pickup: '2025-06-27',
          status: 'Cancelled',
          days: 'Cancelled - 7 days overdue',
        ),
        ReservationData(
          id: 'REV-002',
          customer: 'Sarah Johnson',
          email: 'sarah.johnson@email.com',
          phone: '09171234568',
          shoe: 'Adidas Ultraboost 22',
          size: 'Size 38',
          date: '2025-06-28',
          pickup: '2025-07-02',
          status: 'Cancelled',
          days: 'Cancelled - 6 days overdue',
        ),
        ReservationData(
          id: 'REV-003',
          customer: 'Mike Brown',
          email: 'mike.brown@email.com',
          phone: '09171234569',
          shoe: 'Converse Chuck Taylor',
          size: 'Size 44',
          date: '2025-06-28',
          pickup: '2025-07-01',
          status: 'Pending',
          days: 'Pending - Expires today',
        ),
        ReservationData(
          id: 'REV-004',
          customer: 'Emma Davis',
          email: 'emma.davis@email.com',
          phone: '09171234570',
          shoe: 'Vans Old Skool',
          size: 'Size 36',
          date: '2025-06-16',
          pickup: '2025-06-22',
          status: 'Cancelled',
          days: 'Cancelled - 14 days overdue',
        ),
        ReservationData(
          id: 'REV-005',
          customer: 'Ivan Miguel Doller',
          email: 'ivanmigueldoller@email.com',
          phone: '09171234571',
          shoe: 'Nike Air Force 1',
          size: 'Size 41',
          date: '2025-06-16',
          pickup: '2025-06-22',
          status: 'Completed',
          days: 'Completed successfully',
        ),
        ReservationData(
          id: 'REV-006',
          customer: 'Dan Francis Belarmino',
          email: 'danfrancisbelarmino@email.com',
          phone: '09171234572',
          shoe: 'Nike Air Force 1',
          size: 'Size 41',
          date: '2025-06-22',
          pickup: '2025-06-30',
          status: 'Pending',
          days: 'Pending - Expiring in 2 days',
        ),
      ];

      await saveReservations(sampleReservations);
      _nextId = 7; // Set next ID after sample data
    } else {
      // Load existing data and find the highest ID
      final reservations = await getReservations();
      if (reservations.isNotEmpty) {
        final highestId = reservations
            .map((r) => int.tryParse(r.id.replaceAll('REV-', '')) ?? 0)
            .reduce((a, b) => a > b ? a : b);
        _nextId = highestId + 1;
      }
    }
  }

  // Save reservations to storage
  static Future<void> saveReservations(List<ReservationData> reservations) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = reservations.map((r) => r.toJson()).toList();
    await prefs.setString(_storageKey, jsonEncode(jsonList));
  }

  // Get all reservations from storage
  static Future<List<ReservationData>> getReservations() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final jsonList = jsonDecode(jsonString) as List;
    return jsonList.map((json) => ReservationData.fromJson(json)).toList();
  }

  // Add a new reservation
  static Future<void> addReservation(ReservationData reservation) async {
    final reservations = await getReservations();
    reservations.add(reservation);
    await saveReservations(reservations);
  }

  // Create a new reservation with auto-generated ID
  static Future<void> createReservation({
    required String customer,
    required String email,
    required String phone,
    required String shoe,
    required String size,
    required String date,
    required String pickup,
  }) async {
    final id = 'REV-${_nextId.toString().padLeft(3, '0')}';
    _nextId++;

    final reservation = ReservationData(
      id: id,
      customer: customer,
      email: email,
      phone: phone,
      shoe: shoe,
      size: size,
      date: date,
      pickup: pickup,
      status: 'Pending',
      days: 'Pending - Expires in 7 days',
    );

    await addReservation(reservation);
  }

  // Update reservation status
  static Future<void> updateReservationStatus(String reservationId, String newStatus, String newDays) async {
    final reservations = await getReservations();
    final index = reservations.indexWhere((r) => r.id == reservationId);
    
    if (index != -1) {
      final updatedReservation = ReservationData(
        id: reservations[index].id,
        customer: reservations[index].customer,
        email: reservations[index].email,
        phone: reservations[index].phone,
        shoe: reservations[index].shoe,
        size: reservations[index].size,
        date: reservations[index].date,
        pickup: reservations[index].pickup,
        status: newStatus,
        days: newDays,
      );
      
      reservations[index] = updatedReservation;
      await saveReservations(reservations);
    }
  }

  // Delete a reservation
  static Future<void> deleteReservation(String reservationId) async {
    final reservations = await getReservations();
    reservations.removeWhere((r) => r.id == reservationId);
    await saveReservations(reservations);
  }

  // Get reservations as Map for admin page
  static Future<List<Map<String, dynamic>>> getReservationsAsMap() async {
    final reservations = await getReservations();
    return reservations.map((r) => r.toJson()).toList();
  }
} 