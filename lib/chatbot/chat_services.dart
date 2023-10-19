import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mhi_pred_app/chatbot/models/user_main.dart';
import './models/message_model.dart';

var _db = FirebaseFirestore.instance;


Stream<List<MessageModel>> streamMessages() {
    var ref =
        _db.collection('mhi_chatbot').doc('mhi_cb').collection('allMessages');
    // int len=await ref.snapshots().length;
    // debugPrint(len);
    return ref.snapshots().map((list) => list.docs.map((doc) {
          debugPrint(doc.data().toString());
          return MessageModel.fromFirestore(
            doc,
          );
        }).toList());
//   return const Stream.empty();
}

void sendMessage(
    UserModel user, context, String txt, String rType) {
  MessageModel message = MessageModel(timestamp: Timestamp.now());
  message.senderId = user.uid.split(' ')[0] + "@QxCredit";
//   message.userNotificationToken = user.userNotificationToken;
//   message.gpaId = token == null ? '' : token.buyTransactionId;
  message.rType = rType;
  message.timestamp = Timestamp.now();
  message.message = txt;
  _db
      .collection('chatbot')
      .doc(user.uid)
      .collection('userMessages')
      .doc(message.timestamp.millisecondsSinceEpoch.toString())
      .set(message.getMap());
  _db
      .collection('chatbot')
      .doc(user.uid)
      .collection('allMessages')
      .doc(message.timestamp.millisecondsSinceEpoch.toString())
      .set(message.getMap());
}
