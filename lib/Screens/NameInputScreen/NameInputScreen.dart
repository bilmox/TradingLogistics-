import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../HomeScreen/home_screen.dart'; // Ensure this points to your actual Home file
import '../../language_provider.dart';  // Ensure this points to your actual Provider file

class NameInputScreen extends StatefulWidget {
  const NameInputScreen({super.key});

  @override
  State<NameInputScreen> createState() => _NameInputScreenState();
}

class _NameInputScreenState extends State<NameInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;

  // Constants for your brand colors
  static const Color brandTeal = Color(0xFF329EA6);
  static const Color brandDark = Color(0xFF1A1A1A);

  Future<void> _saveAndProceed() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', _nameController.text.trim());

      // Subtle delay for a professional processing feel
      await Future.delayed(const Duration(milliseconds: 800));

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const TradingLogisticApp(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: Stack(
        children: [
          // --- BACKGROUND DECORATION ---
          Positioned(
            top: -100,
            right: isAr ? null : -50,
            left: isAr ? -50 : null,
            child: CircleAvatar(
              radius: 150,
              backgroundColor: brandTeal.withOpacity(0.05),
            ),
          ),

          // --- MAIN CONTENT ---
          SafeArea(
            child: Column(
              children: [
                // 1. TOP BAR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.blur_on_rounded, color: brandTeal, size: 32),
                      _buildLanguageToggle(langProvider, isAr),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 60),

                          // 2. HEADLINE
                          Text(
                            isAr ? "أهلاً بك" : "Welcome,",
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              color: brandDark,
                              letterSpacing: -1,
                            ),
                          ),
                          Text(
                            isAr ? "لنتعرف عليك أكثر" : "Let's get to know you.",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF77797D),
                                fontWeight: FontWeight.w500
                            ),
                          ),

                          const SizedBox(height: 50),

                          // 3. INPUT FIELD
                          _buildEliteInputField(isAr),

                          const SizedBox(height: 50),

                          // 4. ACTION BUTTON
                          _buildEliteButton(isAr),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageToggle(LanguageProvider provider, bool isAr) {
    return GestureDetector(
      onTap: () {
        provider.changeLanguage(isAr ? const Locale('en') : const Locale('ar'));
      },
      child: Container(
        width: 110,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: brandTeal.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOutBack,
              alignment: isAr ? Alignment.centerLeft : Alignment.centerRight,
              child: Container(
                width: 50,
                height: 36,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [brandTeal, Color(0xFF268289)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "AR",
                      style: TextStyle(
                        color: isAr ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "EN",
                      style: TextStyle(
                        color: !isAr ? Colors.white : Colors.grey,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEliteInputField(bool isAr) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: brandTeal.withOpacity(0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: TextFormField(
        controller: _nameController,
        textAlign: isAr ? TextAlign.right : TextAlign.left,
        textCapitalization: TextCapitalization.words,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: isAr ? "ما هو اسمك؟" : "What is your name?",
          hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
          prefixIcon: isAr ? null : const Icon(Icons.person_pin_rounded, color: brandTeal),
          suffixIcon: isAr ? const Icon(Icons.person_pin_rounded, color: brandTeal) : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(24),
        ),
        validator: (v) => v!.isEmpty ? (isAr ? "الاسم مطلوب" : "Name is required") : null,
      ),
    );
  }

  Widget _buildEliteButton(bool isAr) {
    return Container(
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [brandTeal, Color(0xFF1E7D84)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: brandTeal.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isProcessing ? null : _saveAndProceed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: _isProcessing
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
        )
            : Text(
          isAr ? "ابدأ الرحلة" : "Get Started",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}