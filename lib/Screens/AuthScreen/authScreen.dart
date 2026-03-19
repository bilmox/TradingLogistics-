import 'dart:ui';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  final Color primaryColor = const Color(0xFF0F2A44);
  final Color accentColor = const Color(0xFFFFB300);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. TOP BRANDING SECTION ---
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                ),
                image: DecorationImage(
                  image: const AssetImage("images/Picture3.jpg"), // Using your project image as a low-opacity bg
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(primaryColor.withOpacity(0.8), BlendMode.darken),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const Text("TRADING LOGISTIC",
                        style: TextStyle(color: Colors.white, fontSize: 12, letterSpacing: 3, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(isLogin ? "Welcome\nBack" : "Create\nAccount",
                        style: const TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.w900, height: 1.1)),
                  ],
                ),
              ),
            ),

            // --- 2. INPUT FORM SECTION ---
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  if (!isLogin) _buildTextField(Icons.person_outline, "Full Name"),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.email_outlined, "Email Address"),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.lock_outline, "Password", isPassword: true),

                  if (isLogin)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Forgot Password?", style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
                      ),
                    ),

                  const SizedBox(height: 40),

                  // Main CTA Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        shadowColor: primaryColor.withOpacity(0.4),
                      ),
                      child: Text(isLogin ? "LOGIN" : "SIGN UP",
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Toggle Login/Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(isLogin ? "New to the hub?" : "Already have an account? ",
                          style: TextStyle(color: Colors.grey[600])),
                      GestureDetector(
                        onTap: () => setState(() => isLogin = !isLogin),
                        child: Text(isLogin ? " Create Account" : " Login",
                            style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String label, {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(icon, color: primaryColor, size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
      ),
    );
  }
}