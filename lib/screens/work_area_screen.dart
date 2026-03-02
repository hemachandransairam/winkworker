import 'package:flutter/material.dart';
import 'package:wink_worker/screens/availability_screen.dart';
import 'package:wink_worker/services/supabase_service.dart';

class WorkAreaScreen extends StatefulWidget {
  const WorkAreaScreen({super.key});

  @override
  State<WorkAreaScreen> createState() => _WorkAreaScreenState();
}

class _WorkAreaScreenState extends State<WorkAreaScreen> {
  final Set<String> _selectedAreas = {};

  final List<Map<String, dynamic>> _options = [
    {'title': 'Premium Wash', 'icon': Icons.directions_car_filled_outlined},
    {'title': 'Exterior Wash', 'icon': Icons.local_car_wash_outlined},
    {'title': 'Interior Cleaning', 'icon': Icons.cleaning_services_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 48),
                        const Text(
                          "Select Your Work Area",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "We need a few more details to get you started",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 48),
                        ..._options
                            .map((option) => _buildOptionCard(option))
                            .toList(),
                        const Spacer(),
                        const SizedBox(height: 48),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed:
                                _selectedAreas.isEmpty
                                    ? null
                                    : () {
                                      SupabaseService().updateData({
                                        'work_areas': _selectedAreas.toList(),
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => AvailabilityScreen(
                                                selectedAreas: _selectedAreas,
                                              ),
                                        ),
                                      );
                                    },
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
                                fontWeight: FontWeight.w600,
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

  Widget _buildOptionCard(Map<String, dynamic> option) {
    bool isSelected = _selectedAreas.contains(option['title']);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedAreas.remove(option['title']);
          } else {
            _selectedAreas.add(option['title']);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                option['icon'],
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                option['title'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFFE5E7EB),
                  width: 2,
                ),
              ),
              child:
                  isSelected
                      ? Center(
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B82F6),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
