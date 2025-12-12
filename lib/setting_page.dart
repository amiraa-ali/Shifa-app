import 'package:flutter/material.dart';
import 'package:nav1/welcome.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: const Color(0xff39ab4a),
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
      body: ListView(
        children: [
          const SizedBox(height: 20),

          // تغيير الحساب
          ListTile(
            leading: const Icon(Icons.person, color: Colors.teal),
            title: const Text("Account"),
            subtitle: const Text("Update your profile info"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // هنا ممكن تحطي توجيه لصفحة تعديل الحساب
            },
          ),

          const Divider(),

          // الإشعارات
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.teal),
            title: const Text("Notifications"),
            subtitle: const Text("Manage notification settings"),
            trailing: Switch(
              value: true,
              onChanged: (val) {
                // تقدر تتحكم في تفعيل/إيقاف الإشعارات هنا
              },
            ),
          ),

          const Divider(),

          // اللغة
          ListTile(
            leading: const Icon(Icons.language, color: Colors.teal),
            title: const Text("Language"),
            subtitle: const Text("Change app language"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // توجيه لصفحة اختيار اللغة
            },
          ),

          const Divider(),

          // الخصوصية
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.teal),
            title: const Text("Privacy"),
            subtitle: const Text("Privacy settings"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // توجيه لصفحة الخصوصية
            },
          ),

          const Divider(),

          // تسجيل الخروج
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
               Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
            },
          ),
        ],
      ),
    );
  }
}
