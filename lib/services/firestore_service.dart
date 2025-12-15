import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ADD EMPLOYEE
  Future<void> addEmployee({
    required String name,
    required int perDaySalary,
  }) async {
    await _db.collection('employees').add({
      'name': name,
      'perDaySalary': perDaySalary,
      'totalPresentDays': 0,
    });
  }

  // FETCH EMPLOYEES
  Stream<QuerySnapshot> getEmployees() {
    return _db.collection('employees').snapshots();
  }

  // MARK PRESENT (INCREASE DAY COUNT)
  Future<void> markPresent(String empId) async {
    final doc = _db.collection('employees').doc(empId);

    await _db.runTransaction((tx) async {
      final snapshot = await tx.get(doc);
      int currentDays = snapshot['totalPresentDays'];
      tx.update(doc, {'totalPresentDays': currentDays + 1});
    });
  }
}
