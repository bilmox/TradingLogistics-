import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../language_provider.dart'; // Adjust path
import '../AboutAppScreen/AboutAppScreen.dart';
import '../SplashScreen/splash_screen.dart'; // Adjust path

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _userName = "User";
  static const Color brandTeal = Color(0xFF329EA6);

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  void _loadName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _userName = prefs.getString('user_name') ?? "Guest");
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text(isAr ? "الإعدادات" : "Settings",
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // --- PROFILE CARD ---
          _buildProfileHeader(isAr),
          const SizedBox(height: 30),

          _buildSectionTitle(isAr ? "الحساب" : "Account"),
          _buildSettingTile(
            icon: Icons.person_outline,
            title: isAr ? "تعديل الاسم" : "Edit Name",
            subtitle: _userName,
            onTap: () => _showEditNameDialog(isAr),
          ),

          const SizedBox(height: 20),
          _buildSectionTitle(isAr ? "التفضيلات" : "Preferences"),
          _buildSettingTile(
            icon: Icons.language,
            title: isAr ? "اللغة" : "Language",
            subtitle: isAr ? "العربية" : "English",
            onTap: () {
              langProvider.changeLanguage(isAr ? const Locale('en') : const Locale('ar'));
            },
          ),
          _buildSettingTile(
            icon: Icons.dark_mode_outlined,
            title: isAr ? "المظهر الداكن" : "Dark Mode",
            subtitle: isAr ? "قريباً" : "Coming Soon",
            trailing: Switch(value: false, onChanged: (v) {}, activeColor: brandTeal),
          ),

          const SizedBox(height: 20),
          _buildSectionTitle(isAr ? "النظام" : "System"),
          _buildSettingTile(
            icon: Icons.info_outline,
            title: isAr ? "حول التطبيق" : "About App",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutAppScreen()),
              );
            },
          ),
          _buildSettingTile(
            icon: Icons.logout,
            title: isAr ? "تسجيل الخروج" : "Logout",
            textColor: Colors.redAccent,
            onTap: () => _handleLogout(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(bool isAr) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: brandTeal,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: brandTeal.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 35, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white, size: 40)),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_userName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              Text(isAr ? "مستخدم" : "User", style: const TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10, right: 10),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  Widget _buildSettingTile({required IconData icon, required String title, String? subtitle, Widget? trailing, VoidCallback? onTap, Color textColor = Colors.black}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: textColor == Colors.redAccent ? Colors.redAccent : brandTeal),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: textColor)),
        subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      ),
    );
  }

  // --- LOGIC FEATURES ---

  void _showEditNameDialog(bool isAr) {
    final controller = TextEditingController(text: _userName);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isAr ? "تعديل الاسم" : "Edit Name"),
        content: TextField(controller: controller, decoration: InputDecoration(hintText: isAr ? "الاسم الجديد" : "New Name")),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(isAr ? "إلغاء" : "Cancel")),
          ElevatedButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('user_name', controller.text);
              _loadName();
              if (mounted) Navigator.pop(context);
            },
            child: Text(isAr ? "حفظ" : "Save"),
          ),
        ],
      ),
    );
  }

  void _handleLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name'); // Clear data
    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SplashScreen(onLanguageChange: (l){})),
              (route) => false
      );
    }
  }
}