import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String id;
  String senderId;
  String userNotificationToken;
  String gpaId;
  String rType;
  String message;
  Timestamp timestamp;


  MessageModel({
    this.id="",
    this.senderId='',
    this.userNotificationToken = '',
    this.gpaId = '',
    this.rType = "1",
    this.message = '',
    required this.timestamp,

  });

  factory MessageModel.fromFirestore(DocumentSnapshot data) {
    Map<String,dynamic> mapData=data.data() as Map<String,dynamic> ;

    return MessageModel(
      id:data.id,
      senderId:mapData['senderId']??'QxCredit',
      userNotificationToken: mapData['userNotificationToken'] ?? '',
      gpaId: mapData['gpaId'] ?? '',
      rType: mapData['rType'] ?? "1",
      message: mapData['message'] ?? "I have a query regarding my purchased token",
      timestamp: mapData['timestamp']??Timestamp.now(),
      );
  }

  Map<String, dynamic> getMap() {
    return {
      'senderId':senderId,
      'userNotificationToken': userNotificationToken,
      'gpaId': gpaId,
      'rType': rType,
      'message': message,
      'timestamp':timestamp,

    };
  }

}