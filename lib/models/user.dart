import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String phone;
  final bool hasTransport;
  final Timestamp created;
  final double balance;

  User({this.uid, this.phone, this.created, this.balance, this.hasTransport});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      uid: doc['uid'],
      phone: doc['phone'],
      hasTransport: doc['hasTransport'],
      created: doc['created'].toDate(),
      balance: doc['balance'],
    );
  }
}
