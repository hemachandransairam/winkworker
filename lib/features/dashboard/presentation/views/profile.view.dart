import 'dart:io';
import 'package:flutter/material.dart';
import 'package:wink_worker/core/network/supabase_service.dart';
import 'package:wink_worker/features/profile/presentation/views/worker_profile_details.view.dart';
import 'package:wink_worker/features/auth/presentation/views/phone_number.view.dart';
import 'package:wink_worker/features/profile/presentation/views/payment_details.view.dart';
import 'package:wink_worker/features/profile/presentation/views/work_details.view.dart';
import 'package:wink_worker/features/profile/presentation/views/leave_application.view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic>? _workerData;
  bool _isLoading = true;

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
        _workerData = data;
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
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
        backgroundColor: Color(0xFF061633),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/loginbg.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar (Custom layout style same as before)
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
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Text(
                          "My Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 48), // Spacer to balance
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Profile Card with Stats
                  _buildProfileHeaderCard(),

                  const SizedBox(height: 24),

                  // Content Section (White with rounded top)
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),

                        // Achievements Section
                        _buildAchievementsSection(),

                        const SizedBox(height: 32),

                        // Menu List
                        _buildMenuTile(
                          icon: Icons.person_outline,
                          color: const Color(0xFF1E6AFB),
                          title: "Personal Details",
                          subtitle: "Name, email, phone number",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) =>
                                        const WorkerProfileDetailsScreen(),
                              ),
                            );
                          },
                        ),
                        _buildMenuTile(
                          icon: Icons.attach_money,
                          color: const Color(0xFF22C55E),
                          title: "Payment Details",
                          subtitle: "Bank account, tax info",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const PaymentDetailsScreen(),
                              ),
                            );
                          },
                        ),
                        _buildMenuTile(
                          icon: Icons.work_outline,
                          color: const Color(0xFFA855F7),
                          title: "Work Details",
                          subtitle: "Employee ID, Department",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WorkDetailsScreen(),
                              ),
                            );
                          },
                        ),
                        _buildMenuTile(
                          icon: Icons.description_outlined,
                          color: const Color(0xFFF97316),
                          title: "Leave Application",
                          subtitle: "Apply for leave",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => const LeaveApplicationScreen(),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                        _buildMenuTile(
                          icon: Icons.logout,
                          color: const Color(0xFFEF4444),
                          title: "Logout",
                          subtitle: "Sign out of your account",
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFEE2E2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.logout,
                                            color: Color(0xFFEF4444),
                                            size: 32,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          "Logout",
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF1F2937),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          "Are you sure you want to log out of your account?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                        const SizedBox(height: 28),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                onPressed:
                                                    () => Navigator.pop(
                                                      dialogContext,
                                                    ),
                                                style: OutlinedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  side: const BorderSide(
                                                    color: Color(0xFFE5E7EB),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF4B5563),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.pop(dialogContext);
                                                  await SupabaseService()
                                                      .logout();
                                                  if (mounted) {
                                                    Navigator.of(
                                                      context,
                                                    ).pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                        builder:
                                                            (context) =>
                                                                const PhoneNumberScreen(),
                                                      ),
                                                      (route) => false,
                                                    );
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xFFEF4444,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        vertical: 14,
                                                      ),
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Logout",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
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
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeaderCard() {
    final photoUrl = _workerData?['profile_photo_url'];
    final name = _workerData?['full_name'] ?? 'Worker';
    final createdAt = _workerData?['created_at'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image:
                        photoUrl != null
                            ? DecorationImage(
                              image:
                                  photoUrl.startsWith('http')
                                      ? NetworkImage(photoUrl) as ImageProvider
                                      : FileImage(File(photoUrl)),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      photoUrl == null
                          ? const Icon(
                            Icons.person_outline,
                            color: Color(0xFF1E6AFB),
                            size: 40,
                          )
                          : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Employee ID: EMP-2024",
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                      Text(
                        _formatDate(createdAt),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatBox("156", "Jobs Done"),
                _buildStatBox("4.8", "Rating"),
                _buildStatBox("98%", "Success"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatBox(String value, String label) {
    return Container(
      width: (MediaQuery.of(context).size.width - 88) / 3,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Icon(Icons.military_tech_outlined, color: Color(0xFF1E6AFB)),
              SizedBox(width: 8),
              Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildAchievementChip(
                Icons.emoji_events_outlined,
                "Top Rated",
                const Color(0xFFFACC15),
              ),
              _buildAchievementChip(
                Icons.access_time,
                "On Time",
                const Color(0xFF1E6AFB),
              ),
              _buildAchievementChip(
                Icons.workspace_premium_outlined,
                "100 Jobs",
                const Color(0xFF4ADE80),
              ),
              _buildAchievementChip(
                Icons.explore_outlined,
                "Explorer",
                const Color(0xFFA855F7),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementChip(IconData icon, String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFFCBD5E1),
        ),
        onTap: onTap,
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "Member since 2024";
    try {
      final date = DateTime.parse(dateStr);
      List<String> months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      return "Member since ${months[date.month - 1]} ${date.year}";
    } catch (e) {
      return "Member since 2024";
    }
  }
}
