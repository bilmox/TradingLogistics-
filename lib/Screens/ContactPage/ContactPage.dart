import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../language_provider.dart';

// --- THEME ---
const Color brandTeal = Color(0xFF329EA6);
const Color brandSteel = Color(0xFF77797D);
const Color bgColor = Color(0xFFF4F7F7);

String _formatNumber(String input, bool isAr) {
  if (!isAr) return input;

  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], arabic[i]);
  }
  return input;
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 1. DYNAMIC PREMIUM HEADER
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            stretch: true,
            backgroundColor: brandTeal,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                isAr ? "تواصل معنا" : "Contact Us",
                style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: 1),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0F2A44), brandTeal],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Decorative Circles
                  Positioned(top: -50, right: -50, child: CircleAvatar(radius: 100, backgroundColor: Colors.white.withOpacity(0.05))),
                  Positioned(bottom: 20, left: 20, child: Icon(Icons.support_agent, size: 120, color: Colors.white.withOpacity(0.1))),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // SECTION: HEADQUARTERS
                  _buildSectionHeader(isAr ? "المقر الرئيسي" : "Headquarters", isAr),
                  const SizedBox(height: 15),
                  _buildGlassAddressCard(isAr),

                  const SizedBox(height: 35),

                  // SECTION: QUICK CONNECT
                  _buildSectionHeader(isAr ? "اتصال سريع" : "Quick Connect", isAr),
                  const SizedBox(height: 15),

                  // GRID OF ACTION BUTTONS
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.4,
                    children: [
                      _buildActionCard(
                          Icons.phone_in_talk_rounded,
                          isAr ? "اتصل بنا" : "Call Us",
                          _formatNumber("+968 23 298149", isAr), // Localized
                              () => _launchURL("tel:+96823298149")
                      ),
                      _buildActionCard(
                          Icons.email_outlined,
                          isAr ? "البريد" : "Email",
                          "info@TL-Oman.com",
                              () => _launchURL("mailto:info@TL-Oman.com")
                      ),
                      _buildActionCard(
                          Icons.fax_outlined,
                          isAr ? "فاكس" : "Fax",
                          _formatNumber("+968 23 292323", isAr), // Localized
                              () {}
                      ),
                      _buildActionCard(
                          Icons.chat_bubble_outline_rounded,
                          isAr ? "واتساب" : "WhatsApp",
                          isAr ? "تواصل الآن" : "Connect Now",
                              () => _launchURL("http://api.whatsapp.com/send?phone=96823298149")
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  // GOOGLE MAPS SECTION
                  _buildGoogleMapsSection(isAr),
                  const SizedBox(height: 15),

                  _buildDeveloperSection(isAr),

                  const SizedBox(height: 120),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isAr) {
    return Row(
      children: [
        if (!isAr) Container(width: 4, height: 20, color: brandTeal),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F2A44))),
        ),
        if (isAr) Container(width: 4, height: 20, color: brandTeal),
      ],
    );
  }

  Widget _buildGlassAddressCard(bool isAr) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            isAr ? "سلطنة عمان / صلالة" : "SULTANATE OF OMAN / SALALAH",
            style: const TextStyle(fontWeight: FontWeight.w900, color: brandTeal, fontSize: 12, letterSpacing: 1.2),
          ),
          const SizedBox(height: 12),
          Text(
            isAr
                ? "شارع ${_formatNumber("23", true)} يوليو، بناية المزيونة\nالدور الخامس، شقة رقم ${_formatNumber("20", true)}"
                : "23rd of July Street, Al Mazyouna Building\n5th Floor, Flat No: 20",
            textAlign: isAr ? TextAlign.right : TextAlign.left,
            style: const TextStyle(fontSize: 16, height: 1.6, color: brandSteel, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildDeveloperSection(bool isAr) {
    return SizedBox(
      width: double.infinity, // Ensures the container spans full width
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center, // Centers everything horizontally
        children: [
          // Subtle Divider Line
          Container(
            width: 80,
            height: 1,
            margin: const EdgeInsets.only(bottom: 30),
            color: brandTeal.withOpacity(0.2),
          ),

          // Developer Icon
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: brandTeal.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.code_rounded, color: brandTeal, size: 28),
          ),

          const SizedBox(height: 16),

          Text(
            isAr ? "تم التطوير بواسطة" : "Developed By",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: brandSteel.withOpacity(0.7),
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "M Bilal Tanveer",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F2A44),
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 20),

          // Premium Link Button
          TextButton.icon(
            onPressed: () => _launchURL("https://codebybilal.netlify.app/"),
            icon: const Icon(Icons.alternate_email, size: 18),
            label: Text(
              isAr ? "تواصل معي" : "Connect on Website",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: TextButton.styleFrom(
              foregroundColor: brandTeal,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: brandTeal.withOpacity(0.2)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label, String value, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: brandTeal.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: brandTeal, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 12, color: brandSteel)),
            Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F2A44))),
          ],
        ),
      ),
    );
  }

  Widget _buildGoogleMapsSection(bool isAr) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF4285F4).withOpacity(0.1),
        borderRadius: BorderRadius.circular(28),
      ),
      child: ElevatedButton(
        onPressed: () => _launchURL("https://www.google.com/maps/search/?api=1&query=Salalah+Oman"),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4285F4),
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 65),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.map_outlined),
            const SizedBox(width: 12),
            Text(
              isAr ? "فتح الموقع في خرائط جوجل" : "Open in Google Maps",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}