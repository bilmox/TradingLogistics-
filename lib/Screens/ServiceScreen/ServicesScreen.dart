import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/app_data.dart';
import '../../language_provider.dart'; // Import your provider
import '../InquiryScreen/InquiryScreen.dart';

// --- THEME CONSTANTS ---
const Color brandTeal = Color(0xFF329EA6);
const Color brandSteel = Color(0xFF77797D);
const Color bgColor = Color(0xFFF4F7F7);

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the language state
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: bgColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // CUSTOM APP BAR
          // --- FIX: Remove textAlign from FlexibleSpaceBar ---
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            backgroundColor: bgColor,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              // This property handles alignment for both English and Arabic automatically
              centerTitle: false,
              title: Text(
                isAr ? "خدماتنا" : "Our Services",
                style: const TextStyle(
                  color: brandTeal,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
            ),
          ),

// --- CORRECT: textAlign belongs inside the Text widget only ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Text(
                isAr
                    ? "حلول شاملة مصممة خصيصاً لاحتياجات البنية التحتية والإنشاءات في سلطنة عمان."
                    : "Comprehensive solutions tailored for the infrastructure and construction needs of Oman.",
                textAlign: isAr ? TextAlign.right : TextAlign.left, // This is allowed here
                style: TextStyle(
                  color: brandSteel.withOpacity(0.8),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
          ),

          // SERVICES LIST
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 120),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildServiceCard(context, services[index], isAr),
                childCount: services.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE SERVICE CARD ---
  Widget _buildServiceCard(BuildContext context, ServiceItem service, bool isAr) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: brandSteel.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          // Leading icon container
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: brandTeal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(service.icon, color: brandTeal, size: 28),
          ),
          // BILINGUAL TITLE
          title: Text(
            isAr ? service.titleAr : service.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: brandTeal,
              fontSize: 17,
            ),
          ),
          // BILINGUAL SUBTITLE
          subtitle: Text(
            isAr ? service.subtitleAr : service.subtitle,
            style: const TextStyle(color: brandSteel, fontSize: 13),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(height: 20),
                  // BILINGUAL DESCRIPTION
                  Text(
                    isAr ? service.descriptionAr : service.description,
                    textAlign: isAr ? TextAlign.right : TextAlign.left,
                    style: const TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: 14,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // ACTION BUTTON
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const InquiryScreen()));
                    },
                    icon: const Icon(Icons.mail_outline, size: 18),
                    label: Text(isAr ? "استفسر عن هذه الخدمة" : "Inquire About This Service"),
                    style: TextButton.styleFrom(
                      foregroundColor: brandTeal,
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}