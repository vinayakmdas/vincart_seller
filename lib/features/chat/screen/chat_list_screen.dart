import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_seller/features/chat/screen/chatscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerChatListScreen extends StatelessWidget {
  const SellerChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final sellerUid = FirebaseAuth.instance.currentUser!.uid;
    print(sellerUid);

    return Scaffold( 
      appBar: AppBar(title: const Text("My Chats")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat_rooms')
            .where('sellerId', isEqualTo: sellerUid)
            .orderBy('lastMessageTime', descending: true)
            .snapshots(),
   builder: (context, snapshot) {

  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
  }

  if (snapshot.hasError) {
    print(snapshot.error);
    return Center(child: Text("Error: ${snapshot.error}"));
  }

  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return const Center(child: Text("No chats yet"));
  }
 print('this is snap shot data ${snapshot.data}');
  final chats = snapshot.data!.docs;

  return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {

              final chat = chats[index];

              final chatId = chat.id;
              final adminId = chat['adminId'];

              return ListTile(
                title: Text("Admin"),
                subtitle: Text(chat['lastMessage'] ?? ""),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SellerChatScreen(
                        chatId: chatId,
                        adminId: adminId,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}