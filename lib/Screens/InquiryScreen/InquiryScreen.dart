import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../language_provider.dart';

// --- THEME ---
const Color brandTeal = Color(0xFF329EA6);
const Color brandSteel = Color(0xFF77797D);
const Color bgColor = Color(0xFFF8FAFB);

class InquiryScreen extends StatefulWidget {
  final String? initialService;
  const InquiryScreen({super.key, this.initialService});

  @override
  State<InquiryScreen> createState() => _InquiryScreenState();
}

class _InquiryScreenState extends State<InquiryScreen> {
  final _formKey = GlobalKey<FormState>();

  // 1. Controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();

  String? selectedService;
  bool _isSubmitting = false;

  // 2. Bilingual Service Options
  final List<Map<String, String>> serviceOptions = [
    {"en": "General Contracting", "ar": "المقاولات العامة"},
    {"en": "Civil & Infrastructure", "ar": "الهندسة المدنية والبنية التحتية"},
    {"en": "MEP Installations", "ar": "تركيبات الميكانيك والكهرباء"},
    {"en": "Project Management", "ar": "إدارة المشاريع"},
    {"en": "Specialized Projects", "ar": "المشاريع المتخصصة"},
    {"en": "Logistics & Transport", "ar": "الخدمات اللوجستية والنقل"}
  ];

  @override
  void initState() {
    super.initState();
    selectedService = widget.initialService;
  }

  // 3. Logic to handle the submission
  Future<void> _handleSubmission(bool isAr) async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);

      // Simulate network delay (API Call)
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isSubmitting = false);

      // Show Success Dialog
      if (!mounted) return;
      _showSuccessDialog(context, isAr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final langProvider = Provider.of<LanguageProvider>(context);
    final bool isAr = langProvider.currentLocale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context, isAr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              _buildHeader(isAr),
              const SizedBox(height: 32),

              _buildSectionLabel(isAr ? "تفاصيل الخدمة" : "Service Details", isAr),
              _buildDropdown(isAr),

              const SizedBox(height: 20),

              _buildSectionLabel(isAr ? "معلومات التواصل" : "Contact Information", isAr),
              _buildTextField(
                controller: _nameController,
                label: isAr ? "الاسم الكامل" : "Full Name",
                icon: Icons.person_outline_rounded,
                hint: isAr ? "مثال: بلال تنوير" : "e.g. Bilal Tanveer",
                isAr: isAr,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _contactController,
                label: isAr ? "البريد أو الهاتف" : "Email or Phone",
                icon: Icons.alternate_email_rounded,
                hint: "contact@company.com",
                isAr: isAr,
              ),

              const SizedBox(height: 20),

              _buildSectionLabel(isAr ? "نطاق المشروع" : "Project Scope", isAr),
              _buildTextField(
                controller: _requirementsController,
                label: isAr ? "المتطلبات" : "Requirements",
                icon: Icons.edit_note_rounded,
                maxLines: 4,
                hint: isAr ? "صف مشروعك وموقعك..." : "Briefly describe your timeline and location...",
                isAr: isAr,
              ),

              const SizedBox(height: 40),
              _buildSubmitButton(isAr),

              const SizedBox(height: 24),
              _buildFooter(isAr),
            ],
          ),
        ),
      ),
    );
  }

  // --- COMPONENT WIDGETS ---

  AppBar _buildAppBar(BuildContext context, bool isAr) {
    return AppBar(
      backgroundColor: bgColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false, // Custom back button
      actions: isAr ? [_buildBackButton(context)] : null,
      leading: !isAr ? _buildBackButton(context) : null,
      title: Text(
        isAr ? "استفسار عن مشروع" : "Project Inquiry",
        style: const TextStyle(color: Color(0xFF1A1A1A), fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: IconButton(
        icon: const Icon(Icons.chevron_left_rounded, color: brandTeal, size: 28),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildHeader(bool isAr) {
    return Column(
      crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          isAr ? "لنعمل معاً" : "Let's Build Together",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: brandTeal.withOpacity(0.9), letterSpacing: -0.5),
        ),
        const SizedBox(height: 8),
        Text(
          isAr ? "أرسل تفاصيلك وسيتواصل معك مستشارونا خلال ٢٤ ساعة." : "Submit your details and our consultants will reach out within 24 hours.",
          textAlign: isAr ? TextAlign.right : TextAlign.left,
          style: const TextStyle(color: brandSteel, fontSize: 15, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text, bool isAr) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(fontWeight: FontWeight.w800, color: brandSteel, fontSize: 12, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildDropdown(bool isAr) {
    return Container(
      decoration: _cardDecoration(),
      child: DropdownButtonFormField<String>(
        value: selectedService,
        validator: (value) => value == null ? (isAr ? "يرجى اختيار خدمة" : "Select a service") : null,
        icon: const Icon(Icons.keyboard_arrow_down_rounded, color: brandTeal),
        decoration: _inputDecoration(Icons.business_center_outlined),
        items: serviceOptions.map((opt) => DropdownMenuItem(
            value: opt['en'],
            child: Text(isAr ? opt['ar']! : opt['en']!)
        )).toList(),
        onChanged: (val) => setState(() => selectedService = val),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    required String hint,
    required bool isAr
  }) {
    return Container(
      decoration: _cardDecoration(),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        textAlign: isAr ? TextAlign.right : TextAlign.left,
        validator: (value) => value!.isEmpty ? (isAr ? "هذا الحقل مطلوب" : "Required") : null,
        decoration: _inputDecoration(icon).copyWith(
          hintText: hint,
          labelText: label,
          labelStyle: const TextStyle(color: brandSteel, fontSize: 14),
          alignLabelWithHint: true,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(bool isAr) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [brandTeal, Color(0xFF268289)]),
        boxShadow: [
          BoxShadow(color: brandTeal.withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 6)),
        ],
      ),
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : () => _handleSubmission(isAr),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: _isSubmitting
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
          isAr ? "إرسال الطلب" : "Send Inquiry",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFooter(bool isAr) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user_outlined, size: 14, color: brandSteel),
          const SizedBox(width: 8),
          Text(
            isAr ? "إرسال مشفر بالكامل" : "End-to-end encrypted submission",
            style: const TextStyle(color: brandSteel, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context, bool isAr) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Icon(Icons.check_circle_rounded, color: brandTeal, size: 60),
        content: Text(
          isAr ? "تم إرسال طلبك بنجاح. سنتصل بك قريباً." : "Your inquiry has been sent successfully. We will contact you soon.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Back to previous screen
            },
            child: Text(isAr ? "موافق" : "OK", style: const TextStyle(color: brandTeal, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // --- STYLING HELPERS ---
  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 4))],
    );
  }

  InputDecoration _inputDecoration(IconData icon) {
    return InputDecoration(
      prefixIcon: Icon(icon, color: brandTeal, size: 22),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
    );
  }
}