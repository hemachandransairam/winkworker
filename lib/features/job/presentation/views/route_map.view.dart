import 'package:flutter/material.dart';
import 'package:wink_worker/features/job/presentation/views/before_service.view.dart';

class RouteMapScreen extends StatelessWidget {
  final String destinationAddress;

  const RouteMapScreen({super.key, required this.destinationAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE2E8F0),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 80, color: Color(0xFF94A3B8)),
                  SizedBox(height: 16),
                  Text(
                    "Simulated Map View",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top Header Info
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xFF2563EB),
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Destination",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                destinationAddress,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1F2937),
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
            ),
          ),

          // Bottom Button
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to Scan QR (Need to implement ScanQrScreen next)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScanQrScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF030D21),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: const Text(
                  "I've Reached",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 60,
            left: 20,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF030D21)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Scan QR Screen
class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Back Button
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
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

            const Spacer(flex: 1),

            // Instructions text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "Place the QR inside the box\nor upload the QR image",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1F2937),
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 60),

            // QR Scanner Area with Blue Corners
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // The actual QR image placeholder
                  const Icon(
                    Icons.qr_code_2,
                    size: 200,
                    color: Color(0xFF1F2937),
                  ),

                  // Blue Corners
                  SizedBox(
                    width: 260,
                    height: 260,
                    child: Stack(
                      children: [
                        // Top Left
                        _buildCorner(
                          top: 0,
                          left: 0,
                          isTop: true,
                          isLeft: true,
                        ),
                        // Top Right
                        _buildCorner(
                          top: 0,
                          right: 0,
                          isTop: true,
                          isLeft: false,
                        ),
                        // Bottom Left
                        _buildCorner(
                          bottom: 0,
                          left: 0,
                          isTop: false,
                          isLeft: true,
                        ),
                        // Bottom Right
                        _buildCorner(
                          bottom: 0,
                          right: 0,
                          isTop: false,
                          isLeft: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // Upload Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Navigate to Before Service screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BeforeServiceScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.file_upload_outlined,
                    color: Color(0xFF1F2937),
                  ),
                  label: const Text(
                    "Upload Photo",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F5F9),
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
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

  Widget _buildCorner({
    double? top,
    double? left,
    double? right,
    double? bottom,
    required bool isTop,
    required bool isLeft,
  }) {
    const double length = 40.0;
    const double thickness = 4.0;
    const Color color = Color(0xFF3B82F6);

    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        crossAxisAlignment:
            isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (isTop) ...[
            Container(width: length, height: thickness, color: color),
            Container(
              width: thickness,
              height: length - thickness,
              color: color,
            ),
          ] else ...[
            Container(
              width: thickness,
              height: length - thickness,
              color: color,
            ),
            Container(width: length, height: thickness, color: color),
          ],
        ],
      ),
    );
  }
}

