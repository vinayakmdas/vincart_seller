import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerChatScreen extends StatefulWidget {

  final String chatId;
  final String adminId;

  const SellerChatScreen({
    super.key,
    required this.chatId,
    required this.adminId,
  });

  @override
  State<SellerChatScreen> createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends State<SellerChatScreen> {

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final sellerUid = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text("Chat with Admin")),
      body: Column(
        children: [

          /// MESSAGES
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat_rooms')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('createdAt')
                  .snapshots(),
              builder: (context, snapshot) {

                if (!snapshot.hasData) {
                  return const SizedBox();
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {

                    final message = messages[index];

                    final isMe =
                        message['senderId'] == sellerUid;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(5),
                        color: isMe
                            ? Colors.green
                            : Colors.grey,
                        child: Text(message['text']),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// INPUT
          Row(
            children: [
              Expanded(
                child: TextField(controller: controller),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {

                  if (controller.text.trim().isEmpty) return;

                  final chatRef = FirebaseFirestore.instance
                      .collection('chat_rooms')
                      .doc(widget.chatId);

                  final messageRef =
                      chatRef.collection('messages').doc();

                  await FirebaseFirestore.instance.runTransaction(
                    (transaction) async {

                      transaction.set(messageRef, {
                        'senderId': sellerUid,
                        'text': controller.text,
                        'createdAt':
                            FieldValue.serverTimestamp(),
                      });

                      transaction.update(chatRef, {
                        'lastMessage': controller.text,
                        'lastMessageTime':
                            FieldValue.serverTimestamp(),
                      });
                    },
                  );

                  controller.clear();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}