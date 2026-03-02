import 'package:flutter/material.dart';

class WorkDetailsScreen extends StatefulWidget {
  const WorkDetailsScreen({super.key});

  @override
  State<WorkDetailsScreen> createState() => _WorkDetailsScreenState();
}

class _WorkDetailsScreenState extends State<WorkDetailsScreen> {
  final TextEditingController _empIdController = TextEditingController(
    text: "WNK-2024-085",
  );
  final TextEditingController _joinDateController = TextEditingController(
    text: "15-01-2024",
  );

  String _employmentType = "Full-time";
  String _serviceZone = "Downtown Mumbai";
  String _travelDistance = "10 km";

  final List<String> _specializations = [
    "Basic Exterior Wash",
    "Premium Wash",
    "Deluxe Detail",
    "Interior Deep Clean",
    "Wax & Polish",
    "Engine Cleaning",
  ];

  final Set<String> _selectedSpecs = {
    "Basic Exterior Wash",
    "Premium Wash",
    "Deluxe Detail",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
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
                          "Work Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

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
                child: Column(
                  children: [
                    const SizedBox(height: 24),

                    // Employment Info
                    _buildSectionCard(
                      title: "Employment Information",
                      icon: Icons.badge_outlined,
                      children: [
                        _buildField("Employee ID", _empIdController),
                        _buildField("Join Date", _joinDateController),
                        _buildDropdown(
                          "Employment Type",
                          _employmentType,
                          ["Full-time", "Part-time"],
                          (val) {
                            setState(() => _employmentType = val!);
                          },
                        ),
                        _buildField(
                          "Department",
                          TextEditingController(text: "Mobile Wash Services"),
                        ),
                      ],
                    ),

                    // Service Area
                    _buildSectionCard(
                      title: "Service Area",
                      icon: Icons.location_on_outlined,
                      children: [
                        _buildDropdown(
                          "Primary Service Zone",
                          _serviceZone,
                          ["Downtown Mumbai", "Bandra", "Andheri", "Juhu"],
                          (val) {
                            setState(() => _serviceZone = val!);
                          },
                        ),
                        _buildDropdown(
                          "Maximum Travel Distance",
                          _travelDistance,
                          ["5 km", "10 km", "20 km", "No Limit"],
                          (val) {
                            setState(() => _travelDistance = val!);
                          },
                        ),
                      ],
                    ),

                    // Specializations
                    _buildSectionCard(
                      title: "Service Specializations",
                      icon: Icons.settings_outlined,
                      children:
                          _specializations.map((spec) {
                            return CheckboxListTile(
                              title: Text(
                                spec,
                                style: const TextStyle(fontSize: 14),
                              ),
                              value: _selectedSpecs.contains(spec),
                              onChanged: (val) {
                                setState(() {
                                  if (val!) {
                                    _selectedSpecs.add(spec);
                                  } else {
                                    _selectedSpecs.remove(spec);
                                  }
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              contentPadding: EdgeInsets.zero,
                              activeColor: const Color(0xFF1E6AFB),
                            );
                          }).toList(),
                    ),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          Row(
            children: [
              Icon(icon, color: const Color(0xFF1E6AFB), size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
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
            readOnly: true,
            style: const TextStyle(fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF8FAFC),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                items:
                    items
                        .map(
                          (String val) =>
                              DropdownMenuItem(value: val, child: Text(val)),
                        )
                        .toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
