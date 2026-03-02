import 'package:flutter/material.dart';
import 'package:wink_worker/screens/personal_details_screen.dart';
import 'package:wink_worker/screens/documents_upload_screen.dart';
import 'package:wink_worker/screens/bank_details_screen.dart';
import 'package:wink_worker/screens/review_submit_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final Set<String> _completedSections = {};

  final List<Map<String, dynamic>> _sections = [
    {
      'title': 'Personal Details',
      'subtitle': 'Name, Photo, Vehicle Info',
      'icon': Icons.person_outline,
      'color': const Color(0xFF3B82F6),
    },
    {
      'title': 'Documents Upload',
      'subtitle': 'ID Proof, License, Selfie',
      'icon': Icons.insert_drive_file_outlined,
      'color': const Color(0xFF10B981),
    },
    {
      'title': 'Bank Details',
      'subtitle': 'Account Information',
      'icon': Icons.credit_card_outlined,
      'color': const Color(0xFFA855F7),
    },
  ];

  @override
  Widget build(BuildContext context) {
    bool isAllFinished = _completedSections.length == _sections.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFFF3F4F6),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xFF000D26),
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          "Complete Your Profile",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "We need a few more details to get you started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 40),
                        for (
                          int index = 0;
                          index < _sections.length;
                          index++
                        ) ...[
                          _buildSectionCard(
                            _sections[index],
                            _completedSections.contains(
                              _sections[index]['title'],
                            ),
                            index > 0 &&
                                !_completedSections.contains(
                                  _sections[index - 1]['title'],
                                ),
                          ),
                        ],
                        const Spacer(),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed:
                                isAllFinished
                                    ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const ReviewSubmitScreen(),
                                        ),
                                      );
                                    }
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF000D26),
                              disabledBackgroundColor: const Color(0xFFE5E7EB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    Map<String, dynamic> section,
    bool isCompleted,
    bool isLocked,
  ) {
    String title = section['title'] as String;
    Color sectionColor =
        isCompleted ? const Color(0xFF10B981) : (section['color'] as Color);

    return Opacity(
      opacity: isLocked ? 0.5 : 1.0,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (!isLocked)
              const BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap:
                isLocked
                    ? null
                    : () {
                      Widget? nextScreen;
                      if (title == 'Personal Details') {
                        nextScreen = const PersonalDetailsScreen();
                      } else if (title == 'Documents Upload') {
                        nextScreen = const DocumentsUploadScreen();
                      } else if (title == 'Bank Details') {
                        nextScreen = const BankDetailsScreen();
                      }

                      if (nextScreen != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => nextScreen!),
                        ).then((value) {
                          if (value == true) {
                            setState(() {
                              _completedSections.add(title);
                            });
                          }
                        });
                      }
                    },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color:
                      isCompleted
                          ? const Color(0xFF10B981)
                          : (!isLocked
                              ? const Color(0x4D3B82F6)
                              : const Color(0xFFF3F4F6)),
                  width: !isLocked ? 1.5 : 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isLocked ? const Color(0xFFE5E7EB) : sectionColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCompleted ? Icons.check : (section['icon'] as IconData),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                isLocked
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          section['subtitle'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            color:
                                isLocked
                                    ? const Color(0xFFD1D5DB)
                                    : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isCompleted
                        ? Icons.check_circle
                        : (isLocked ? Icons.lock_outline : Icons.arrow_forward),
                    color:
                        isCompleted
                            ? const Color(0xFF10B981)
                            : (isLocked
                                ? const Color(0xFFD1D5DB)
                                : const Color(0xFF3B82F6)),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
