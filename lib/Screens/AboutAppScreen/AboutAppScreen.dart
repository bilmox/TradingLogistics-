import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isAr = Localizations.localeOf(context).languageCode == 'ar';
    const Color brandTeal = Color(0xFF329EA6);
    const Color brandDark = Color(0xFF1A1A1A);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        title: Text(isAr ? "حول الشركة" : "About the Company",
            style: const TextStyle(color: brandDark, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: brandDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. CORPORATE HEADER
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  const Icon(Icons.business_rounded, size: 70, color: brandTeal),
                  const SizedBox(height: 15),
                  const Text(
                    "Trading Logistic (LLC)",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: brandDark),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isAr ? "تأسست عام 2006 • صلالة، عمان" : "Established 2006 • Salalah, Oman",
                    style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      isAr
                          ? "بناء بثقة، متجذر في الالتزام. نساهم في تحقيق رؤية عمان 2040."
                          : "Building with confidence, rooted in commitment. Actively contributing to Oman Vision 2040.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: brandDark.withOpacity(0.7), height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            // 2. CORE DIVISIONS (Grid)
            _buildSectionTitle(isAr ? "مجالات العمل" : "Our Core Divisions", isAr),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
                children: [
                  _buildDivisionCard(Icons.apartment, isAr ? "البناء المدني" : "Civil Construction"),
                  _buildDivisionCard(Icons.add_road, isAr ? "البنية التحتية" : "Infrastructure"),
                  _buildDivisionCard(Icons.engineering, isAr ? "المقاولات" : "General Contracting"),
                  _buildDivisionCard(Icons.architecture, isAr ? "هندسة متخصصة" : "Specialized Engineering"),
                ],
              ),
            ),

            // 3. MASTER PROJECTS LIST
            _buildSectionTitle(isAr ? "أبرز المشاريع" : "Master Projects List", isAr),
            _buildProjectTile(
              title: isAr ? "جامع الدقم الكبير" : "New Duqm Grand Mosque",
              subtitle: "31,676 m² • 5,250 Worshippers",
              icon: Icons.mosque_outlined,
            ),
            _buildProjectTile(
              title: isAr ? "تطوير واجهة المصنعة" : "Al-Musannah Waterfront",
              subtitle: "150,000 m² • 2.1km Track",
              icon: Icons.water_rounded,
            ),
            _buildProjectTile(
              title: isAr ? "بناية صلالة الجديدة" : "New Salalah Building",
              subtitle: "10 Levels • 23 Luxury Apartments",
              icon: Icons.foundation,
            ),
            _buildProjectTile(
              title: isAr ? "وحدة العلاج المائي" : "Hydrotherapy Unit",
              subtitle: "Ministry of Social Development",
              icon: Icons.medical_services_outlined,
            ),

            // 4. DEVELOPER FOOTER
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  Text(isAr ? "تم التطوير بواسطة" : "Developed By", style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  const Text(
                    "M Bilal Tanveer",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandTeal),
                  ),
                  const SizedBox(height: 10),
                  const Text("v1.0.0 Build 2026", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, bool isAr) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 15),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF1A1A1A))),
    );
  }

  Widget _buildDivisionCard(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFF329EA6), size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildProjectTile({required String title, required String subtitle, required IconData icon}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: const Color(0xFFF0F7F7), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: const Color(0xFF329EA6)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      ),
    );
  }
}