import 'package:flutter/material.dart';

// --- MODELS ---

class Project {
  final String title;
  final String titleAr;

  final String location;
  final String status;
  final String category;
  final String imagePath;
  final String description;
  final String descriptionAr;

  final String owner;
  final String ownerAr;


  Project({
    required this.title,
    required this.titleAr,

    required this.location,
    required this.status,
    required this.category,
    required this.imagePath,
    required this.description,
    required this.descriptionAr,

    required this.owner,
    required this.ownerAr,

  });
}
class ServiceItem {
  final IconData icon;
  final String title;
  final String titleAr;      // Added
  final String subtitle;
  final String subtitleAr;   // Added
  final String description;
  final String descriptionAr;// Added

  ServiceItem({
    required this.icon,
    required this.title,
    required this.titleAr,
    required this.subtitle,
    required this.subtitleAr,
    required this.description,
    required this.descriptionAr,
  });
}

// --- DATA LISTS ---

final List<Project> allProjects = [
  // --- IN PROGRESS PROJECTS ---
  Project(
    title: "New Salalah Building",
    titleAr: "بناية صلالة الجديدة",

    location: "Salalah",
    status: "In Progress",
    category: "Infrastructure",
    imagePath: "assets/images/InProgress/salala-1.jpeg",
    descriptionAr: "مشروع سكني مميز يقع في موقع استراتيجي على أرض بمساحة 334 متر مربع، مع مساحة بناء إجمالية تصل إلى 3095 متر مربع. يتكون المبنى من سرداب، طابق أرضي، طابق ميزانيين، خمسة طوابق متكررة، وطابق ملحق. يضم المشروع 23 شقة سكنية مصممة بعناية لتوفر الراحة والجودة.",

    description: "A distinctive residential project strategically located on a 334-square-meter plot, with a total built-up area of 3,095 square meters. Features 23 meticulously designed apartments across five upper floors and an annex.",
    owner: "Private Developer",
    ownerAr: "خاص",

  ),
  Project(
    title: "Hydrotherapy Unit Project",
    titleAr: "مشروع وحدة العلاج المائي",

    location: "Oman",
    status: "In Progress",
    category: "Medical",
    imagePath: "assets/images/InProgress/hydrotherapy-unit2.jpg",

    description: "The Al Wafaa Social Center project includes a therapeutic swimming pool, jacuzzi, changing rooms, and a reception area designed to provide a comprehensive therapeutic environment for people with disabilities.",
    descriptionAr: "يشتمل مشروع مركز الوفاء الاجتماعي على مسبح علاجي، وجاكوزي، وغرف تبديل الملابس، ومنطقة استقبال مصممة لتوفير بيئة علاجية شاملة للأشخاص ذوي الإعاقة.",

    owner: "Ministry of Social Development",
    ownerAr: "وزارة التنمية الاجتماعية",
  ),
  Project(
    title: "Al-Qawf Building Project",
    titleAr: "مشروع مبنى القوف",
    location: "Oman",
    status: "In Progress",
    category: "Civil",
    imagePath: "assets/images/InProgress/The-Al-Quf-project3d.jpeg",
    description: "Multi-story residential project on a 348.5 sqm plot. Total built-up area of 3,196.7 sqm comprising a basement, mezzanine, and five upper floors with 23 apartments.",
    descriptionAr: "مشروع سكني متعدد الطوابق على قطعة أرض بمساحة 348.5 متر مربع. تبلغ المساحة الإجمالية للبناء 3,196.7 متر مربع، وتتكون من قبو وميزانين وخمسة طوابق علوية تضم 23 شقة.",
    owner: "Real Estate Investment Fund",
    ownerAr: "صندوق الاستثمار العقاري",
  ),

  Project(
    title: "New Duqm Mosque",
    titleAr: "جامع الدقم الجديد",
    location: "Duqm",
    status: "In Progress",
    category: "Religious",
    imagePath: "assets/images/InProgress/Duqm-Grand-Mosque.jpeg",
    description: "Built on a 31,676 m² plot with 3,000 m² of building area. Accommodates 5,000 worshippers and features two 32-meter minarets and a 12-meter diameter dome.",
    descriptionAr: "بني على مساحة 31,676 متر مربع مع مساحة بناء تبلغ 3,000 متر مربع. يتسع لـ 5,000 مصلٍ ويتميز بمئذنتين بارتفاع 32 مترًا وقبة بقطر 12 مترًا.",
    owner: "Ministry of Endowments and Religious Affairs",
    ownerAr: "وزارة الأوقاف والشؤون الدينية",
  ),

  Project(
    title: "Waterfront Al-Musannah",
    titleAr: "واجهة المصنعة البحرية",
    location: "Al-Musannah",
    status: "In Progress",
    category: "Development",
    imagePath: "assets/images/InProgress/masnaa-project.jpeg",
    description: "Spanning 150,000 m², featuring eight buildings, a 2,100m walkway, bicycle paths, and parking for over 1,000 cars.",
    descriptionAr: "يمتد على مساحة 150,000 متر مربع، ويضم ثمانية مبانٍ وممشى بطول 2,100 متر ومسارات للدراجات ومواقف لأكثر من 1,000 سيارة.",
    owner: "South Al Batinah Municipality",
    ownerAr: "بلدية جنوب الباطنة",
  ),

  Project(
    title: "Waterfront Barka",
    titleAr: "واجهة بركاء البحرية",
    location: "Barka",
    status: "In Progress",
    category: "Development",
    imagePath: "assets/images/InProgress/barkaa-beach.jpeg",
    description: "Coastal development on a 150,000 m² plot including seven buildings, extensive landscaping, and beachfront shower facilities.",
    descriptionAr: "تطوير ساحلي على مساحة 150,000 متر مربع يضم سبعة مبانٍ ومناظر طبيعية واسعة ومرافق استحمام على الشاطئ.",
    owner: "South Al Batinah Municipality",
    ownerAr: "بلدية جنوب الباطنة",
  ),

  // --- COMPLETED PROJECTS ---
  Project(
    title: "Infrastructure Projects",
    titleAr: "مشاريع البنية التحتية",
    location: "Oman",
    status: "Complete",
    category: "Systems",
    imagePath: "assets/images/ready/tlomanproj-12.jpeg",
    description: "Delivered master-planned infrastructure including road networks and utility connections.",
    descriptionAr: "تنفيذ بنية تحتية مخططة بشكل متكامل تشمل شبكات الطرق وتوصيلات المرافق الخدمية.",
    owner: "Ministry of Transport, Communications and IT",
    ownerAr: "وزارة النقل والاتصالات وتقنية المعلومات",
  ),
  Project(
    title: "Aghbir Recreational Area",
    titleAr: "منطقة أغبير الترفيهية",
    location: "Mirbat",
    status: "Complete",
    category: "Recreational",
    imagePath: "assets/images/Mirbat-Park4.jpeg",
    description: "A community-focused green space project in Mirbat with sustainable landscaping.",
    descriptionAr: "مشروع مساحة خضراء مجتمعية في مرباط مع تنسيق حدائق مستدام.",
    owner: "Dhofar Municipality",
    ownerAr: "بلدية ظفار",
  ),
  Project(
    title: "Meliá Melouga Hotel",
    titleAr: "فندق ميليا ملوجا",
    location: "Oman",
    status: "Complete",
    category: "Hospitality",
    imagePath: "assets/images/ready/hotel.jpg",
    description: "A five-star luxury hotel project where we managed core structural civil works.",
    descriptionAr: "مشروع فندق فاخر فئة خمس نجوم حيث قمنا بإدارة الأعمال المدنية الإنشائية الأساسية.",
    owner: "Meliá Hotels International",
    ownerAr: "مجموعة فنادق ميليا العالمية",
  ),
  Project(
    title: "Buildings and Villas",
    titleAr: "مباني وفلل",
    location: "Oman",
    status: "Complete",
    category: "Civil",
    imagePath: "assets/images/ready/BuildingsAndVillas.jpg",
    description: "A portfolio of premium residential villas executed with high-quality Omani materials.",
    descriptionAr: "مجموعة من الفلل السكنية الفاخرة التي تم تنفيذها باستخدام مواد عمانية عالية الجودة.",
    owner: "Private Clients",
    ownerAr: "عملاء من القطاع الخاص",
  ),
  Project(
    title: "Marbat Mosque",
    titleAr: "جامع مرباط",
    location: "Mirbat",
    status: "Complete",
    category: "Religious",
    imagePath: "assets/images/ready/MarbatMosque.png",
    description: "Completion of the Marbat central mosque featuring intricate stone masonry.",
    descriptionAr: "إكمال جامع مرباط المركزي الذي يتميز بأعمال البناء الحجري المعقدة.",
    owner: "Ministry of Endowments and Religious Affairs",
    ownerAr: "وزارة الأوقاف والشؤون الدينية",
  ),
  Project(
    title: "Al-Azz Mosque",
    titleAr: "جامع العز",
    location: "Oman",
    status: "Complete",
    category: "Religious",
    imagePath: "assets/images/ready/Al-AzzMosque.jpg",
    description: "Civil construction of the Al-Azz religious complex delivered to architectural tradition.",
    descriptionAr: "الأعمال الإنشائية المدنية لمجمع العز الديني المنفذ وفقاً للتقاليد المعمارية.",
    owner: "Ministry of Endowments and Religious Affairs",
    ownerAr: "وزارة الأوقاف والشؤون الدينية",
  ),
  Project(
    title: "Radar System",
    titleAr: "نظام الرادار",
    location: "Oman",
    status: "Complete",
    category: "Technology",
    imagePath: "assets/images/ready/Picture3.jpg",
    description: "Technical site preparation for radar systems used in national aerospace safety.",
    descriptionAr: "التجهيز الفني للموقع لأنظمة الرادار المستخدمة في سلامة الطيران الوطني.",
    owner: "Salalah Airport",
    ownerAr: "مطار صلالة",
  ),
];

final List<ServiceItem> services = [
  ServiceItem(
    title: "General Contracting",
    titleAr: "المقاولات العامة",
    subtitle: "Foundations to Delivery",
    subtitleAr: "من الأساسات حتى التسليم",
    icon: Icons.architecture_rounded,
    description: "Comprehensive general contracting services from planning and foundation to final handover using state-of-the-art technologies.",
    descriptionAr: "خدمات المقاولات العامة الشاملة من التخطيط والأساسات حتى التسليم النهائي باستخدام أحدث التقنيات.",
  ),
  ServiceItem(
    title: "Civil & Infrastructure",
    titleAr: "الأعمال المدنية والبنية التحتية",
    subtitle: "Building for the Future",
    subtitleAr: "بناء المستقبل",
    icon: Icons.add_road_rounded,
    description: "Comprehensive solutions for road networks, excavation, water, and wastewater infrastructure in Oman.",
    descriptionAr: "حلول شاملة لشبكات الطرق، الحفريات، المياه، وبنية الصرف الصحي التحتية في سلطنة عمان.",
  ),
  ServiceItem(
    title: "MEP Installations",
    titleAr: "التركيبات الكهروميكانيكية",
    subtitle: "Smart & Safe Systems",
    subtitleAr: "أنظمة ذكية وآمنة",
    icon: Icons.electrical_services_rounded,
    description: "Integrated solutions for electrical, mechanical, and plumbing works in accordance with international standards.",
    descriptionAr: "حلول متكاملة للأعمال الكهربائية والميكانيكية والسباكة وفقاً للمعايير الدولية.",
  ),
  ServiceItem(
    title: "Project Management",
    titleAr: "إدارة المشاريع",
    subtitle: "Vision to Reality",
    subtitleAr: "من الرؤية إلى الواقع",
    icon: Icons.assignment_turned_in_rounded,
    description: "Planning and management services including scheduling, cost management, and quality control.",
    descriptionAr: "خدمات التخطيط والإدارة بما في ذلك الجدولة الزمنية، إدارة التكاليف، ومراقبة الجودة.",
  ),
  ServiceItem(
    title: "Specialized Projects",
    titleAr: "المشاريع المتخصصة",
    subtitle: "Flexible Adaptability",
    subtitleAr: "مرونة وقابلية للتكيف",
    icon: Icons.domain_rounded,
    description: "Customized solutions for specialized sectors including airports, schools, and security facilities.",
    descriptionAr: "حلول مخصصة للقطاعات المتخصصة بما في ذلك المطارات، المدارس، والمنشآت الأمنية.",
  ),
];