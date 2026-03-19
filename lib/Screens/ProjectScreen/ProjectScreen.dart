import 'package:flutter/material.dart';
import '../../data/app_data.dart';

// --- THEME ---
const Color brandTeal = Color(0xFF329EA6);
const Color brandSteel = Color(0xFF77797D);

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  // We keep the filter value in English to match your logic in app_data.dart
  String selectedFilter = "In Progress";

  @override
  Widget build(BuildContext context) {
    // Check if current locale is Arabic
    final bool isAr = Localizations.localeOf(context).languageCode == 'ar';

    final filteredList = allProjects.where((p) => p.status == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F7),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                  isAr ? "المشاريع" : "Portfolio",
                  style: const TextStyle(color: brandTeal, fontWeight: FontWeight.bold)
              ),
              centerTitle: false,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _filterButton(isAr ? "قيد التنفيذ" : "In Progress", "In Progress"),
                  const SizedBox(width: 10),
                  _filterButton(isAr ? "مكتمل" : "Complete", "Complete"),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildWideProjectCard(context, filteredList[index], isAr),
                childCount: filteredList.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _filterButton(String label, String value) {
    bool isSelected = selectedFilter == value;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? brandTeal : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: brandTeal.withOpacity(0.2)),
        ),
        child: Text(
            label,
            style: TextStyle(
                color: isSelected ? Colors.white : brandTeal,
                fontWeight: FontWeight.bold
            )
        ),
      ),
    );
  }

  Widget _buildWideProjectCard(BuildContext context, Project project, bool isAr) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProjectDetailScreen(project: project))
      ),
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: brandSteel.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset(project.imagePath, fit: BoxFit.cover)),
              Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [brandTeal.withOpacity(0.85), brandTeal.withOpacity(0.3)]
                          )
                      )
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(5)),
                      child: Text(
                          project.category.toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)
                      ),
                    ),
                    const Spacer(),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                          isAr ? project.titleAr : project.title,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)
                      ),
                    ),
                    Text(
                        project.location,
                        style: const TextStyle(color: Colors.white70, fontSize: 14)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectDetailScreen extends StatelessWidget {
  final Project project;
  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final bool isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: brandTeal,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(project.imagePath, fit: BoxFit.cover),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. CATEGORY TAG
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: brandTeal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      project.category.toUpperCase(),
                      style: const TextStyle(color: brandTeal, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // 2. TITLE & LOCATION
                  Text(
                    isAr ? project.titleAr : project.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: brandTeal, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 18, color: brandSteel),
                      const SizedBox(width: 5),
                      Text(project.location, style: const TextStyle(color: brandSteel, fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),

                  const Divider(height: 40, thickness: 1),

                  // 3. PROJECT META-DATA
                  Text(
                    isAr ? "معلومات المشروع" : "Project Information",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FB),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: brandSteel.withOpacity(0.1)),
                    ),
                    child: Column(
                      children: [
                        _buildDetailRow(
                          Icons.business_outlined,
                          isAr ? "المالك / العميل" : "Client / Owner",
                          isAr ? project.ownerAr : project.owner,
                          isAr,
                        ),
                        const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: Divider(height: 1)),
                        _buildDetailRow(
                          Icons.assessment_outlined,
                          isAr ? "الحالة الحالية" : "Current Status",
                          isAr ? (project.status == "Complete" ? "مكتمل" : "قيد التنفيذ") : project.status,
                          isAr,
                          valueColor: project.status == "Complete" ? Colors.green : Colors.orange,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 35),

                  // 4. DESCRIPTION
                  Text(
                    isAr ? "نظرة عامة على المشروع" : "Project Overview",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAr ? project.descriptionAr : project.description,
                    style: const TextStyle(fontSize: 15, height: 1.7, color: Color(0xFF4A4A4A)),
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, bool isAr, {Color? valueColor}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: brandTeal),
        const SizedBox(width: 12),
        Text(
          "$label:",
          style: const TextStyle(fontWeight: FontWeight.w600, color: brandSteel, fontSize: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            // Align text based on language direction
            textAlign: isAr ? TextAlign.left : TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? brandTeal,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}