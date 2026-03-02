import 'package:flutter/material.dart';
import 'package:wink_worker/screens/details_screen.dart';
import 'package:wink_worker/services/supabase_service.dart';

class ServicePreferenceScreen extends StatefulWidget {
  final bool isPartTime;
  final Set<String> selectedAreas;
  const ServicePreferenceScreen({
    super.key,
    required this.isPartTime,
    required this.selectedAreas,
  });

  @override
  State<ServicePreferenceScreen> createState() =>
      _ServicePreferenceScreenState();
}

class _ServicePreferenceScreenState extends State<ServicePreferenceScreen> {
  final Set<String> _selectedServices = {};

  final Map<String, List<String>> _areaToServices = {
    'Premium Wash': [
      'Basic Wash',
      'Deep Clean',
      'Interior Detailing',
      'Exterior Detailing',
      'Wax & Polish',
      'Engine Cleaning',
    ],
    'Exterior Wash': [
      'Basic Wash',
      'Exterior Detailing',
      'Wax & Polish',
      'Engine Cleaning',
    ],
    'Interior Cleaning': ['Deep Clean', 'Interior Detailing', 'Basic Wash'],
  };

  late final List<String> _filteredServices;

  @override
  void initState() {
    super.initState();
    final Set<String> services = {};
    for (var area in widget.selectedAreas) {
      if (_areaToServices.containsKey(area)) {
        services.addAll(_areaToServices[area]!);
      }
    }
    _filteredServices = services.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        const Text(
                          "Select Your Service/Work Type Preference",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2D2D2D),
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Select the services you're comfortable with",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            alignment: WrapAlignment.center,
                            children:
                                _filteredServices
                                    .map(
                                      (service) => _buildServiceCard(service),
                                    )
                                    .toList(),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 48),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed:
                                _selectedServices.isEmpty
                                    ? null
                                    : () {
                                      SupabaseService().updateData({
                                        'services': _selectedServices.toList(),
                                      });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  const DetailsScreen(),
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

  Widget _buildServiceCard(String title) {
    bool isSelected = _selectedServices.contains(title);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedServices.remove(title);
          } else {
            _selectedServices.add(title);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: (MediaQuery.of(context).size.width - 60) / 2,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF3B82F6) : const Color(0xFFF3F4F6),
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.blue.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            else
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color:
                  isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF4B5563),
            ),
          ),
        ),
      ),
    );
  }
}
