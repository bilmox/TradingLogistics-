import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trading_logsitis/Screens/ContactPage/ContactPage.dart';
import 'package:trading_logsitis/Screens/InquiryScreen/InquiryScreen.dart';
import 'package:trading_logsitis/Screens/ProjectScreen/ProjectScreen.dart';
import 'package:trading_logsitis/Screens/ServiceScreen/ServicesScreen.dart';
import 'package:trading_logsitis/data/app_data.dart';
import '../../language_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../SettingsScreen/SettingsScreen.dart';


// --- THEME COLORS ---
const Color brandTeal = Color(0xFF329EA6);
const Color brandSteel = Color(0xFF77797D);
const Color bgColor = Color(0xFFF4F7F7);
const Color navBarColor = Color(0xFF0F2A44);

class TradingLogisticApp extends StatefulWidget {
  const TradingLogisticApp({super.key});

  @override
  State<TradingLogisticApp> createState() => _TradingLogisticAppState();
}

class _TradingLogisticAppState extends State<TradingLogisticApp> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  String _userName = "User"; // Default fallback

  List<Project> _foundProjects = [];
  final TextEditingController _searchController = TextEditingController();

  // Define your icon list for the bottom bar

  final List<IconData> iconList = [
    Icons.home_outlined,
    Icons.business_center,
    Icons.miscellaneous_services,
    Icons.contact_phone_rounded,
  ];

  @override
  void initState() {
    super.initState();
    _foundProjects = allProjects;
    _loadUserName();
  }
  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // This fetches the "user_name" we saved in the NameInputScreen
      _userName = prefs.getString('user_name') ?? "Guest";
    });
  }

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _runFilter(String enteredKeyword) {
    List<Project> results = [];
    if (enteredKeyword.isEmpty) {
      results = allProjects;
    } else {
      results = allProjects.where((project) {
        final matchesEn = project.title.toLowerCase().contains(enteredKeyword.toLowerCase());
        final matchesAr = project.titleAr.contains(enteredKeyword);
        final matchesLoc = project.location.toLowerCase().contains(enteredKeyword.toLowerCase());
        return matchesEn || matchesAr || matchesLoc;
      }).toList();
    }
    setState(() {
      _foundProjects = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';
    final List<Widget> _pages = [
      _buildHomeContent(isAr),
      const ProjectsPage(),
      ServicesPage(),
      const ContactPage(),
    ];

    return Scaffold(
      backgroundColor: bgColor,
      // 1. Extend body behind the navigation bar for a seamless look
      extendBody: true,

      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),

      // 2. Central Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: brandTeal,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InquiryScreen()),
        ),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 3. Animated Bottom Navigation Bar
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        backgroundColor: navBarColor.withOpacity(0.95),
        activeColor: brandTeal,
        inactiveColor: Colors.white.withOpacity(0.4),
        splashColor: brandTeal,
        iconSize: 26,
        onTap: (index) => setState(() => _selectedIndex = index),
        // FIX: Use this parameter name instead
      ),
    );
  }
  Widget _dockIcon(IconData icon, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _navigateTo(index),
      child: FaIcon( // Use FaIcon instead of Icon for better scaling
        icon,
        color: isActive ? brandTeal : Colors.white.withOpacity(0.4),
        size: isActive ? 24 : 20, // FA icons often look larger, so 20-24 is a sweet spot
      ),
    );
  }
  // --- HOME CONTENT ---
  Widget _buildHomeContent(bool isAr) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 10),
            child: Row(
              children: [
                _buildProfileAvatar(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      // THE DYNAMIC USERNAME (Greetings)
                      Text(
                        isAr ? "مرحباً، $_userName 👋" : "Hi, $_userName 👋",
                        style: const TextStyle(
                          fontSize: 26, // Larger for the user
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A1A),
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // YOUR BRANDING TAG
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: brandTeal.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              "M Bilal Tanveer",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: brandTeal,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isAr ? "• مسقط، عمان" : "• Muscat, Oman",
                            style: TextStyle(
                              color: brandSteel.withOpacity(0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildLanguageToggle(isAr),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: _buildSearchBar(isAr)),
        SliverToBoxAdapter(child: _buildSectionHeader(isAr ? "البنية التحتية النشطة" : "Active Infrastructure", () => _navigateTo(1), isAr)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 280,
            child: _foundProjects.isEmpty
                ? Center(child: Text(isAr ? "لم يتم العثور على مشاريع" : "No projects found"))
                : ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsetsDirectional.only(start: 24),
              itemCount: _foundProjects.length,
              itemBuilder: (context, index) => _buildProjectCard(_foundProjects[index], isAr),
            ),
          ),
        ),
        SliverToBoxAdapter(child: _buildSectionHeader(isAr ? "خدمات الشركة" : "Company Services", () => _navigateTo(2), isAr)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildHomeServiceCard(services[index], isAr),
              childCount: services.take(4).length,
            ),
          ),
        ),
        // Spacer to prevent content from being hidden behind the nav bar
        const SliverToBoxAdapter(child: SizedBox(height: 120)),
      ],
    );
  }

  // --- COMPONENT BUILDERS ---
  Widget _buildProjectCard(Project project, bool isAr) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProjectDetailScreen(project: project))),
      child: Container(
        width: 300,
        margin: const EdgeInsetsDirectional.only(end: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(image: AssetImage(project.imagePath), fit: BoxFit.cover),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)]),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isAr ? project.titleAr : project.title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                isAr ? project.ownerAr : project.owner,
                style: const TextStyle(color: brandTeal, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                project.location,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(bool isAr) {
    final langProvider = Provider.of<LanguageProvider>(context, listen: false);
    return GestureDetector(
      onTap: () => langProvider.changeLanguage(isAr ? const Locale('en') : const Locale('ar')),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: brandTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: brandTeal.withOpacity(0.2)),
        ),
        child: Text(
          isAr ? "English" : "العربية",
          style: const TextStyle(color: brandTeal, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap, bool isAr) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: brandTeal)),
          IconButton(
            onPressed: onTap,
            icon: Icon(isAr ? Icons.arrow_back_ios_rounded : Icons.arrow_forward_ios_rounded,
                size: 16, color: brandTeal),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isAr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
            hintText: isAr ? "ابحث عن المشاريع..." : "Search Projects...",
            border: InputBorder.none,
            icon: const Icon(Icons.search, color: brandTeal),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileAvatar() {
    // Detect language for the label
    final bool isAr = Localizations.localeOf(context).languageCode == 'ar';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SettingsScreen()),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 22, // Slightly smaller to accommodate text
            backgroundColor: brandSteel.withOpacity(0.2),
            child: const Icon(Icons.person, color: brandTeal),
          ),
          const SizedBox(height: 4),
          Text(
            isAr ? "الإعدادات" : "Settings",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: brandSteel.withAlpha(200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeServiceCard(ServiceItem service, bool isAr) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: brandSteel.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(service.icon, color: brandTeal, size: 24),
          const Spacer(),
          Text(service.title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: brandTeal, fontSize: 13)),
        ],
      ),
    );
  }
}