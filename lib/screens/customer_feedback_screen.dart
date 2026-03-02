import 'package:flutter/material.dart';
import 'package:wink_worker/screens/main_navigation_screen.dart';

class CustomerFeedbackScreen extends StatefulWidget {
  final int totalAmount;
  const CustomerFeedbackScreen({super.key, required this.totalAmount});

  @override
  State<CustomerFeedbackScreen> createState() => _CustomerFeedbackScreenState();
}

class _CustomerFeedbackScreenState extends State<CustomerFeedbackScreen> {
  int _rating = 5;
  final List<String> _feedbackOptions = [
    "Friendly",
    "Clear Instructions",
    "Easy to reach",
    "Friendly",
  ];
  final Set<String> _selectedFeedback = {"Friendly"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFC7C7CC,
      ), // Darker grey background to highlight ticket
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 60,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Main Ticket Body
                          ClipPath(
                            clipper: TicketClipper(),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 24,
                              ),
                              child: Column(
                                children: [
                                  // Medal with Purple Ribbon
                                  Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        bottom: -20,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Transform.rotate(
                                              angle: 0.5,
                                              child: Container(
                                                width: 25,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFC084FC,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 15),
                                            Transform.rotate(
                                              angle: -0.5,
                                              child: Container(
                                                width: 25,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFC084FC,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 50,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFBBF24),
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 24),

                                  const Text(
                                    "Great Work !",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    "How would you rate this customer?",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Perforation Line
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Row(
                                      children: List.generate(
                                        25,
                                        (index) => Expanded(
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                              horizontal: 3,
                                            ),
                                            height: 1.5,
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Customer Info Row
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: const Color(0xFFF3F4F6),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFF1F2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Color(0xFF1F2937),
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "Customer",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF9CA3AF),
                                              ),
                                            ),
                                            const Text(
                                              "John Smith",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF1F2937),
                                              ),
                                            ),
                                            const Text(
                                              "Order #1",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xFF9CA3AF),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  const Text(
                                    "RATE YOUR EXPERIENCE",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      color: Color(0xFF9CA3AF),
                                    ),
                                  ),
                                  const SizedBox(height: 8),

                                  // Stars
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(5, (index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        child: Icon(
                                          index < _rating
                                              ? Icons.star
                                              : Icons.star_border,
                                          color: const Color(0xFFFBBF24),
                                          size: 36,
                                        ),
                                      );
                                    }),
                                  ),

                                  const SizedBox(height: 20),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "QUICK FEEDBACK",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 12,
                                        children:
                                            _feedbackOptions.map((option) {
                                              bool isSelected =
                                                  _selectedFeedback.contains(
                                                    option,
                                                  );
                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (isSelected) {
                                                      _selectedFeedback.remove(
                                                        option,
                                                      );
                                                    } else {
                                                      _selectedFeedback.add(
                                                        option,
                                                      );
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 24,
                                                        vertical: 12,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        isSelected
                                                            ? const Color(
                                                              0xFFEFF6FF,
                                                            )
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                    border: Border.all(
                                                      color:
                                                          isSelected
                                                              ? const Color(
                                                                0xFF3B82F6,
                                                              )
                                                              : const Color(
                                                                0xFFE5E7EB,
                                                              ),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    option,
                                                    style: TextStyle(
                                                      color: const Color(
                                                        0xFF1F2937,
                                                      ),
                                                      fontWeight:
                                                          isSelected
                                                              ? FontWeight.w600
                                                              : FontWeight
                                                                  .normal,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),

                                      const SizedBox(height: 16),

                                      const Text(
                                        "ADDITIONAL COMMENTS",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFE5E7EB),
                                          ),
                                        ),
                                        child: const TextField(
                                          maxLines: 2,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Share more about your experience...",
                                            hintStyle: TextStyle(
                                              color: Color(0xFFD1D5DB),
                                              fontSize: 13,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 16),

                                      // Payment Status Card
                                      Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF0FFF4),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: const Color(0xFFDCFCE7),
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "₹${widget.totalAmount}",
                                                  style: const TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF10B981),
                                                  ),
                                                ),
                                                const Text(
                                                  "Payment Confirmed",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF10B981),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: const BoxDecoration(
                                                color: Color(0xFFDCFCE7),
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.thumb_up,
                                                color: Color(0xFF16A34A),
                                                size: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 20),

                                      // Submit Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 60,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        const MainNavigationScreen(),
                                              ),
                                              (route) => false,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF030D21,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text(
                                            "Submit Rating",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
}

class TicketClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // Roughly 0.22 to 0.24
    double punchHeight = size.height * 0.23;
    double punchRadius = 16.0;

    path.lineTo(0, punchHeight - punchRadius);
    path.arcToPoint(
      Offset(0, punchHeight + punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: true,
    );
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, punchHeight + punchRadius);
    path.arcToPoint(
      Offset(size.width, punchHeight - punchRadius),
      radius: Radius.circular(punchRadius),
      clockwise: true,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
