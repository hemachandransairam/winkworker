import 'package:flutter/material.dart';
import 'package:wink_worker/services/supabase_service.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AadharUploadScreen extends StatefulWidget {
  const AadharUploadScreen({super.key});

  @override
  State<AadharUploadScreen> createState() => _AadharUploadScreenState();
}

class _AadharUploadScreenState extends State<AadharUploadScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageWithSource(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error picking image: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isUploaded = _imageFile != null;
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
                        const SizedBox(height: 40),
                        const Text(
                          "ID Proof Upload",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Upload a clear photo of your ID Proof",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        const SizedBox(height: 40),
                        GestureDetector(
                          onTap:
                              () => _pickImageWithSource(ImageSource.gallery),
                          child: CustomPaint(
                            painter: DashedBorderPainter(
                              color:
                                  isUploaded
                                      ? const Color(0xFF10B981)
                                      : const Color(0xFFD1D5DB),
                              strokeWidth: 1.5,
                              gap: 6,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                image:
                                    isUploaded
                                        ? DecorationImage(
                                          image: FileImage(_imageFile!),
                                          fit: BoxFit.cover,
                                        )
                                        : null,
                              ),
                              child:
                                  isUploaded
                                      ? Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.check_circle,
                                            size: 48,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                      : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.camera_alt_outlined,
                                            size: 48,
                                            color: Color(0xFF9CA3AF),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            "Click to Upload ID Proof",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF1F2937),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          const Text(
                                            "PNG, JPG up to 5MB",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF9CA3AF),
                                            ),
                                          ),
                                        ],
                                      ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed:
                                isUploaded
                                    ? () {
                                      SupabaseService().updateData({
                                        'aadhar_url': _imageFile!.path,
                                      });
                                      Navigator.pop(context, true);
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
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedBorderPainter({
    this.color = Colors.grey,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            const Radius.circular(16),
          ),
        );

    final Path dashPath = Path();
    for (PathMetric pathMetric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
