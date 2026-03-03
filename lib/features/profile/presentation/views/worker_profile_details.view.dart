import 'package:flutter/material.dart';
import 'package:wink_worker/core/network/supabase_service.dart';

class WorkerProfileDetailsScreen extends StatefulWidget {
  const WorkerProfileDetailsScreen({super.key});

  @override
  State<WorkerProfileDetailsScreen> createState() =>
      _WorkerProfileDetailsScreenState();
}

class _WorkerProfileDetailsScreenState
    extends State<WorkerProfileDetailsScreen> {
  bool _isLoading = true;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    final phone = SupabaseService().currentUserPhone;
    if (phone == null) {
      setState(() => _isLoading = false);
      return;
    }

    final data = await SupabaseService().getWorkerData(phone);
    if (data != null) {
      setState(() {
        _nameController.text = data['full_name'] ?? '';
        _emailController.text = data['email'] ?? 'david.martinez@example.com';
        _phoneController.text = data['phone_number'] ?? '';
        _dobController.text = data['dob'] ?? '15-05-1990';
        _addressController.text = data['address'] ?? '456 Oak Avenue';
        _cityController.text = data['city'] ?? 'Los Angeles';
        _stateController.text = data['state'] ?? 'CA';
        _zipController.text = data['zip_code'] ?? '90001';
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFF1E6AFB)),
        ),
        backgroundColor: Colors.white,
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            // Top Navy Section (Matched with Home Page)
            Stack(
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFF030D21),
                    image: DecorationImage(
                      image: AssetImage('assets/loginbg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    children: [
                      // Custom AppBar
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const Text(
                              "Personal Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: _saveDetails,
                              child: const Text(
                                "SAVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Main Content Section (Matched with Home Page)
            Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      // Basic Information Card
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("Basic Information"),
                            const SizedBox(height: 20),
                            _buildInputField(
                              label: "Full Name",
                              controller: _nameController,
                              icon: Icons.person_outline,
                            ),
                            _buildInputField(
                              label: "Email",
                              controller: _emailController,
                              icon: Icons.mail_outline,
                            ),
                            _buildInputField(
                              label: "Phone Number",
                              controller: _phoneController,
                              icon: Icons.phone_outlined,
                            ),
                            _buildInputField(
                              label: "Date of Birth",
                              controller: _dobController,
                              icon: Icons.calendar_today_outlined,
                              isDate: true,
                            ),
                          ],
                        ),
                      ),

                      // Address Information Card
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSectionTitle("Address Information"),
                            const SizedBox(height: 20),
                            _buildInputField(
                              label: "Street Address",
                              controller: _addressController,
                              icon: Icons.location_on_outlined,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildInputField(
                                    label: "City",
                                    controller: _cityController,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildInputField(
                                    label: "State",
                                    controller: _stateController,
                                  ),
                                ),
                              ],
                            ),
                            _buildInputField(
                              label: "ZIP Code",
                              controller: _zipController,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _saveDetails,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF030D21),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Save Details",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveDetails() async {
    final phone = SupabaseService().currentUserPhone;
    if (phone == null) return;

    setState(() => _isLoading = true);

    try {
      await SupabaseService().updateWorkerData(phone, {
        'full_name': _nameController.text,
        'email': _emailController.text,
        'phone_number': _phoneController.text,
        'dob': _dobController.text,
        'address': _addressController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'zip_code': _zipController.text,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Details saved successfully!")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error saving details: $e")));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    bool isDate = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            readOnly: isDate,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF334155),
            ),
            decoration: InputDecoration(
              prefixIcon:
                  icon != null
                      ? Icon(icon, color: const Color(0xFF94A3B8), size: 20)
                      : null,
              suffixIcon:
                  isDate
                      ? const Icon(
                        Icons.calendar_month,
                        color: Color(0xFF94A3B8),
                        size: 20,
                      )
                      : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF1E6AFB),
                  width: 1.5,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

