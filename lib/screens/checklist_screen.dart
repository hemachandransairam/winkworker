import 'package:flutter/material.dart';
import 'package:wink_worker/screens/after_service_screen.dart';

class ChecklistScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? additionalServices;
  const ChecklistScreen({super.key, this.additionalServices});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final List<ChecklistItem> _items = [
    ChecklistItem(title: "Pre-wash inspection", isCompleted: true),
    ChecklistItem(title: "Outside Foam Wash"),
    ChecklistItem(title: "Tyre Polishing"),
    ChecklistItem(title: "Interior Mat Cleaning"),
    ChecklistItem(title: "Final Inspection"),
  ];

  double get _progress =>
      _items.where((item) => item.isCompleted).length / _items.length;
  int get _completedCount => _items.where((item) => item.isCompleted).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header with Back Button
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1F5F9),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF0F172A),
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Work Progress Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Work Progress",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              Text(
                                "$_completedCount/${_items.length} Steps",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF3B82F6),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                "${(_progress * 100).toInt()}%",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    // Base Line
                                    Container(
                                      height: 6,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE2E8F0),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    ),
                                    // Progress Line
                                    LayoutBuilder(
                                      builder: (context, constraints) {
                                        return Container(
                                          height: 6,
                                          width:
                                              constraints.maxWidth * _progress,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF0F172A),
                                            borderRadius: BorderRadius.circular(
                                              3,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    // Dots on the progress bar
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: List.generate(_items.length, (
                                        index,
                                      ) {
                                        bool isMarked =
                                            (index / (_items.length - 1)) <=
                                            _progress;
                                        return Container(
                                          width:
                                              index ==
                                                          (_progress *
                                                                  (_items.length -
                                                                      1))
                                                              .toInt() &&
                                                      _progress > 0
                                                  ? 16
                                                  : 8,
                                          height:
                                              index ==
                                                          (_progress *
                                                                  (_items.length -
                                                                      1))
                                                              .toInt() &&
                                                      _progress > 0
                                                  ? 16
                                                  : 8,
                                          decoration: BoxDecoration(
                                            color:
                                                isMarked
                                                    ? const Color(0xFF0F172A)
                                                    : const Color(0xFFCBD5E1),
                                            shape: BoxShape.circle,
                                            border:
                                                index ==
                                                            (_progress *
                                                                    (_items.length -
                                                                        1))
                                                                .toInt() &&
                                                        _progress > 0
                                                    ? Border.all(
                                                      color: Colors.white,
                                                      width: 2,
                                                    )
                                                    : null,
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Service Checklist Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Service Checklist",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _items.length,
                            separatorBuilder:
                                (context, index) => const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              final item = _items[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    item.isCompleted = !item.isCompleted;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color:
                                        item.isCompleted
                                            ? const Color(0xFFF0FDF4)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color:
                                          item.isCompleted
                                              ? const Color(0xFFBBF7D0)
                                              : const Color(0xFFE2E8F0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border:
                                              item.isCompleted
                                                  ? null
                                                  : Border.all(
                                                    color: const Color(
                                                      0xFF94A3B8,
                                                    ),
                                                    width: 2,
                                                  ),
                                        ),
                                        child:
                                            item.isCompleted
                                                ? const Icon(
                                                  Icons.check_circle,
                                                  color: Color(0xFF22C55E),
                                                  size: 24,
                                                )
                                                : null,
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              item.isCompleted
                                                  ? const Color(0xFF16A34A)
                                                  : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Proceed Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed:
                      _progress == 1.0
                          ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => AfterServiceScreen(
                                      additionalServices:
                                          widget.additionalServices,
                                    ),
                              ),
                            );
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF030D21),
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChecklistItem {
  final String title;
  bool isCompleted;

  ChecklistItem({required this.title, this.isCompleted = false});
}
