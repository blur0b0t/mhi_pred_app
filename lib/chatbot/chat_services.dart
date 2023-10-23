import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mhi_pred_app/chatbot/models/user_main.dart';
import 'package:mhi_pred_app/main.dart';
import './models/message_model.dart';

var _db = FirebaseFirestore.instance;

Stream<List<MessageModel>> streamMessages(UserModel user) {
  var ref = _db.collection(coll_name).doc(user.uid).collection('allMessages');
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

void sendMessage(UserModel user, context, String txt, String rType) {
  if (txt.isEmpty) return;
  MessageModel message = MessageModel(timestamp: Timestamp.now());
  message.senderId = rType=='0'?"chatbot@red":"${user.name?.split(' ')[0]}@red";
  message.rType = rType;
  message.timestamp = Timestamp.now();
  message.message = txt;

  _db
      .collection(coll_name)
      .doc(user.uid)
      .collection('allMessages')
      .doc(message.timestamp.millisecondsSinceEpoch.toString())
      .set(message.getMap());

  // -------------chatbot response
  if(rType=='0')
  return;

  var request_body={
    'input':context,
    'instruction':txt,
  };
  // var response=response from Api
  // txt=response['output']

  txt='chatbot respone.......';
  message = MessageModel(timestamp: Timestamp.now());
  message.senderId = 'chatbot' + "@red";
  message.rType = rType;
  message.timestamp = Timestamp.now();
  message.message = txt;

  _db
      .collection(coll_name)
      .doc(user.uid)
      .collection('allMessages')
      .doc(message.timestamp.millisecondsSinceEpoch.toString())
      .set(message.getMap());


}
