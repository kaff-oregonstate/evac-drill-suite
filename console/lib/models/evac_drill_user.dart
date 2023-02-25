import 'package:cloud_firestore/cloud_firestore.dart';

/// The EvacDrillUser data model holds information about a Console EvacDrillUser,
/// as stored in Firestore.

class EvacDrillUser {
  final String userID;
  final String email;
  final String? userName;

  EvacDrillUser({
    required this.userID,
    required this.email,
    this.userName,
  });

  factory EvacDrillUser.fromJson(Map<String, dynamic> json) {
    return EvacDrillUser(
      userID: json['userID'],
      email: json['email'],
      userName: json['userName'],
    );
  }

  /// Constructs a new DrillPlan object from the Firestore DocumentSnapshot
  factory EvacDrillUser.fromDoc(DocumentSnapshot snap) {
    final docData = snap.data() as Map<String, dynamic>;
    docData['userID'] = snap.id;
    return EvacDrillUser.fromJson(docData);
  }

  Future<void> updateEvacDrillUserName(
      String currEvacDrillUserID, String newEvacDrillUserName) {
    if (currEvacDrillUserID != userID) {
      throw Exception('Cannot change the name of another user');
    }
    final firestore = FirebaseFirestore.instance;
    final usersCol = firestore.collection('EvacDrillUser');
    final userDoc = usersCol.doc(userID);
    return userDoc.update({'userName': newEvacDrillUserName});
  }

  Map<String, dynamic> toJson() => {
        // 'userID': userID,
        'email': email,
        'userName': userName,
      };
}
