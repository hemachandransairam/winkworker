import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background Image (same as other pages)
          Positioned.fill(
            child: Image.asset('assets/loginbg.png', fit: BoxFit.cover),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Center(
                      child: Text(
                        "Earnings",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Total Earnings Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0x14FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0x1AFFFFFF)),
                      ),
                      child: const Column(
                        children: [
                          Text(
                            "Total Earnings",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xB3FFFFFF),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "₹24,500",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "This Month",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xB3FFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Stats Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        _buildMiniStat("₹2,500", "Today"),
                        const SizedBox(width: 12),
                        _buildMiniStat("₹12,800", "This Week"),
                        const SizedBox(width: 12),
                        _buildMiniStat("45", "Jobs Done"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // White Content Section
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            "Recent Transactions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 16),

                          _buildTransactionCard(
                            "Premium Wash - Ramesh",
                            "Today, 10:30 AM",
                            "₹2,000",
                            const Color(0xFF22C55E),
                          ),
                          _buildTransactionCard(
                            "Basic Wash - Suresh",
                            "Today, 8:00 AM",
                            "₹500",
                            const Color(0xFF22C55E),
                          ),
                          _buildTransactionCard(
                            "Deluxe Detail - Mandhana",
                            "Yesterday, 4:30 PM",
                            "₹3,500",
                            const Color(0xFF22C55E),
                          ),
                          _buildTransactionCard(
                            "Premium Wash - Kohli",
                            "Yesterday, 2:00 PM",
                            "₹2,000",
                            const Color(0xFF22C55E),
                          ),
                          _buildTransactionCard(
                            "Basic Wash - Rohit",
                            "Feb 24, 11:00 AM",
                            "₹500",
                            const Color(0xFF22C55E),
                          ),

                          const SizedBox(height: 24),

                          // Payout Section
                          const Text(
                            "Payout Summary",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                          const SizedBox(height: 16),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFF1F5F9),
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildPayoutRow(
                                  "Pending Payout",
                                  "₹4,500",
                                  const Color(0xFFF59E0B),
                                ),
                                const Divider(
                                  height: 24,
                                  color: Color(0xFFF1F5F9),
                                ),
                                _buildPayoutRow(
                                  "Last Payout",
                                  "₹12,000",
                                  const Color(0xFF22C55E),
                                ),
                                const Divider(
                                  height: 24,
                                  color: Color(0xFFF1F5F9),
                                ),
                                _buildPayoutRow(
                                  "Payout Date",
                                  "Mar 1, 2026",
                                  const Color(0xFF1E6AFB),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 100),
                        ],
                      ),
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

  static Widget _buildMiniStat(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0x14FFFFFF),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0x1AFFFFFF)),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildTransactionCard(
    String title,
    String subtitle,
    String amount,
    Color amountColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: amountColor.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.currency_rupee, color: amountColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "+ $amount",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPayoutRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
