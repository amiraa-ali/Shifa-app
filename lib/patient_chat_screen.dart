import 'package:flutter/material.dart';
import 'package:nav1/homepage.dart';

class PatientChatScreen extends StatelessWidget {
  const PatientChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
    appBar: AppBar(
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    },
  ),
  title: const Text(
    "Chats",
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  ),
  flexibleSpace: Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xff39ab4a), Color(0xff009f93)],
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
      ),
    ),
  ),
),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chatData.length,
        itemBuilder: (context, index) {
          final chat = chatData[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ChatTile(
              name: chat['name']!,
              message: chat['message']!,
            ),
          );
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String name;
  final String message;

  const ChatTile({super.key, required this.name, required this.message});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      shadowColor: Colors.black12,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xff39ab4a), Color(0xff009f93)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 28),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          message,
          style: TextStyle(color: Colors.grey.shade700),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}

// بيانات تجريبية للدردشة
final List<Map<String, String>> chatData = [
  {"name": "Dr. Madeline Ross", "message": "Doctor, I need help with pain"},
  {"name": "Dr. Hannah Morgan", "message": "When is my appointment?"},
  {"name": "Dr. Harper Lawson", "message": "Thank you doctor ❤️"},
  {"name": "Dr. Natalie Cooper", "message": "Thank you doctor ❤️"},
  {"name": "Dr. Benjamin Cole", "message": "Thank you doctor ❤️"},
];
