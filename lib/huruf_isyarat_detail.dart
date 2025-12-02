import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HurufIsyaratDetailPage extends StatelessWidget {
  final String huruf;
  final String label;
  final String isyaratMediaPath; // bisa gif/video
  final String objectImagePath;
  final VoidCallback? onRefresh;

  const HurufIsyaratDetailPage({
    Key? key,
    required this.huruf,
    required this.label,
    required this.isyaratMediaPath,
    required this.objectImagePath,
    this.onRefresh,
  }) : super(key: key);

  Future<void> _speak(String text) async {
    final FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('id-ID');
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF4ECDC4)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              huruf,
              style: TextStyle(
                color: const Color(0xFF343A40),
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 24 : 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.volume_up, color: Color(0xFF4ECDC4)),
                onPressed: () => _speak(label),
                tooltip: 'Dengarkan',
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Hero Section with Letter and Sign Language
                Container(
                  width: double.infinity,
                  height: isTablet ? 300 : 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                        const Color(0xFF45B7B8).withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      // Large Letter
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            huruf,
                            style: TextStyle(
                              fontSize: isTablet ? 120 : 80,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF343A40),
                            ),
                          ),
                        ),
                      ),
                      // Sign Language GIF
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            width: isTablet ? 180 : 140,
                            height: isTablet ? 180 : 140,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                isyaratMediaPath,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Section
                Padding(
                  padding: EdgeInsets.all(isTablet ? 32 : 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Word Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF4ECDC4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.volume_up,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Kata untuk "$huruf"',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF343A40),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              label,
                              style: TextStyle(
                                fontSize: isTablet ? 20 : 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4ECDC4),
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap icon speaker di atas untuk mendengarkan pengucapan',
                              style: TextStyle(
                                fontSize: isTablet ? 12 : 10,
                                color: const Color(0xFF6C757D),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Object Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF45B7B8),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Objek Terkait',
                                  style: TextStyle(
                                    fontSize: isTablet ? 18 : 16,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF343A40),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Container(
                                width: isTablet ? 200 : 150,
                                height: isTablet ? 200 : 150,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    objectImagePath,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Action Buttons
                      Row(
                        children: [
                          // Practice Button
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: const Color(0xFF4ECDC4),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // TODO: Implement practice mode
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Mode latihan akan segera hadir',
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.play_circle_outline,
                                        color: const Color(0xFF4ECDC4),
                                        size: isTablet ? 24 : 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Latihan',
                                        style: TextStyle(
                                          color: const Color(0xFF4ECDC4),
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTablet ? 16 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Repeat Button
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF4ECDC4),
                                    Color(0xFF45B7B8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF4ECDC4,
                                    ).withValues(alpha: 0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => _speak(label),
                                  borderRadius: BorderRadius.circular(16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.replay,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Ulangi',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: isTablet ? 16 : 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Tips Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(
                              0xFF4ECDC4,
                            ).withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb_outline,
                                  color: const Color(0xFF4ECDC4),
                                  size: isTablet ? 20 : 18,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Tips Belajar',
                                  style: TextStyle(
                                    fontSize: isTablet ? 16 : 14,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF4ECDC4),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '• Perhatikan gerakan tangan dengan seksama\n• Praktikkan isyarat secara berulang\n• Dengarkan pengucapan untuk pemahaman\n• Hubungkan huruf dengan objek terkait',
                              style: TextStyle(
                                fontSize: isTablet ? 14 : 12,
                                color: const Color(0xFF6C757D),
                                height: 1.4,
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
        );
      },
    );
  }
}
