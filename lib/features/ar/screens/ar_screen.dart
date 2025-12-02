import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:io' show Platform;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/animation_data.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;
import 'package:ar_flutter_plugin_updated/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin_updated/datatypes/node_types.dart';
import 'package:ar_flutter_plugin_updated/models/ar_node.dart';
import 'package:ar_flutter_plugin_updated/widgets/ar_view.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin_updated/managers/ar_location_manager.dart';

class ArScreen extends StatefulWidget {
  final String selectedObject;
  final List<Map<String, dynamic>>? kosakataData;
  final int? initialIndex;
  final bool showAppBar;
  final VoidCallback? onBack;

  const ArScreen({
    Key? key,
    required this.selectedObject,
    this.kosakataData,
    this.initialIndex,
    this.showAppBar = true,
    this.onBack,
  }) : super(key: key);

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> with TickerProviderStateMixin {
  late int currentIndex;
  late AnimationController _animationController;
  bool _isAnimationMode = false;
  bool _isPlaying = false;
  bool _isARMode = false;

  // AR Variables
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARNode? modelNode;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex ?? 0;
    // Sesuaikan durasi dengan animation_data (4 detik untuk BUKU animation)
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    arSessionManager?.dispose();
    super.dispose();
  }

  Future<String> getLocalAssetPath(String asset) async {
    final byteData = await rootBundle.load(asset);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${asset.split('/').last}');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  void onARViewCreated(
    ARSessionManager sessionManager,
    ARObjectManager objectManager,
    ARAnchorManager anchorManager,
    ARLocationManager locationManager,
    String pathGlb,
  ) async {
    arSessionManager = sessionManager;
    arObjectManager = objectManager;
    await arSessionManager?.onInitialize(
      showAnimatedGuide: false,
      handlePans: true,
      handleRotation: true,
    );
    await arObjectManager?.onInitialize();

    // Copy asset ke file system
    final localPath = await getLocalAssetPath(pathGlb);
    modelNode = ARNode(
      type: NodeType.webGLB,
      uri: localPath,
      scale: vector_math.Vector3(0.7, 0.7, 0.7),
      position: vector_math.Vector3(0.0, 0.0, -1.0),
      rotation: vector_math.Vector4(1.0, 0.0, 0.0, 0.0),
    );
    if (modelNode != null) {
      await arObjectManager?.addNode(modelNode!);
    }
  }

  void _previousItem() {
    if (widget.kosakataData != null && currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  void _nextItem() {
    if (widget.kosakataData != null &&
        currentIndex < widget.kosakataData!.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  String _getCurrentObjectName() {
    if (widget.kosakataData != null &&
        currentIndex < widget.kosakataData!.length) {
      return widget.kosakataData![currentIndex]['nama'] ??
          widget.selectedObject;
    }
    return widget.selectedObject;
  }

  StickFigurePose _getInterpolatedPose(double animationValue) {
    // Gunakan animation_data untuk mendapatkan pose
    final keyFrames = BukuAnimation.bukuAnimation.keyFrames;
    final totalDuration = BukuAnimation.bukuAnimation.duration.inMilliseconds;
    final currentTime = animationValue * totalDuration;

    // Cari keyframe yang sesuai
    StickFigurePose? pose1;
    StickFigurePose? pose2;
    double t = 0.0;

    for (int i = 0; i < keyFrames.length - 1; i++) {
      final frame1Time = keyFrames[i].timestamp.inMilliseconds;
      final frame2Time = keyFrames[i + 1].timestamp.inMilliseconds;

      if (currentTime >= frame1Time && currentTime <= frame2Time) {
        pose1 = keyFrames[i].pose;
        pose2 = keyFrames[i + 1].pose;
        final frameDuration = frame2Time - frame1Time;
        if (frameDuration > 0) {
          t = (currentTime - frame1Time) / frameDuration;
        }
        break;
      }
    }

    // Jika tidak ada keyframe match, gunakan keyframe pertama dan terakhir
    if (pose1 == null || pose2 == null) {
      pose1 = keyFrames.first.pose;
      pose2 = keyFrames.last.pose;
    }

    // Interpolasi antara dua pose
    return _interpolatePose(pose1, pose2, t);
  }

  StickFigurePose _interpolatePose(
    StickFigurePose pose1,
    StickFigurePose pose2,
    double t,
  ) {
    vector_math.Vector3 lerpVector(
      vector_math.Vector3 a,
      vector_math.Vector3 b,
      double t,
    ) {
      return vector_math.Vector3(
        a.x + (b.x - a.x) * t,
        a.y + (b.y - a.y) * t,
        a.z + (b.z - a.z) * t,
      );
    }

    return StickFigurePose(
      head: lerpVector(pose1.head, pose2.head, t),
      leftShoulder: lerpVector(pose1.leftShoulder, pose2.leftShoulder, t),
      rightShoulder: lerpVector(pose1.rightShoulder, pose2.rightShoulder, t),
      leftElbow: lerpVector(pose1.leftElbow, pose2.leftElbow, t),
      rightElbow: lerpVector(pose1.rightElbow, pose2.rightElbow, t),
      leftWrist: lerpVector(pose1.leftWrist, pose2.leftWrist, t),
      rightWrist: lerpVector(pose1.rightWrist, pose2.rightWrist, t),
      leftHip: lerpVector(pose1.leftHip, pose2.leftHip, t),
      rightHip: lerpVector(pose1.rightHip, pose2.rightHip, t),
      leftKnee: lerpVector(pose1.leftKnee, pose2.leftKnee, t),
      rightKnee: lerpVector(pose1.rightKnee, pose2.rightKnee, t),
      leftAnkle: lerpVector(pose1.leftAnkle, pose2.leftAnkle, t),
      rightAnkle: lerpVector(pose1.rightAnkle, pose2.rightAnkle, t),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentObject = _getCurrentObjectName();
    final isPrevEnabled = widget.kosakataData != null && currentIndex > 0;
    final isNextEnabled =
        widget.kosakataData != null &&
        currentIndex < (widget.kosakataData?.length ?? 0) - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.showAppBar
          ? AppBar(
              backgroundColor: const Color(0xFF4ECDC4),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: const Text(
                'Mode AR',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: _buildArMode(currentObject, isPrevEnabled, isNextEnabled),
    );
  }

  Widget _buildArMode(
    String currentObject,
    bool isPrevEnabled,
    bool isNextEnabled,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Info Section - More compact
          Container(
            color: const Color(0xFF2C2C2C),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button on Left
                if (!widget.showAppBar)
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (_isAnimationMode) {
                        setState(() {
                          _isAnimationMode = false;
                          _isPlaying = false;
                          _animationController.stop();
                        });
                      } else {
                        // Call onBack callback if provided
                        if (widget.onBack != null) {
                          widget.onBack!();
                        } else if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  )
                else
                  const SizedBox(width: 48),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Mode AR untuk Belajar Bahasa Isyarat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Objek: $currentObject',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4ECDC4),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Placeholder for symmetry
                const SizedBox(width: 48),
              ],
            ),
          ),

          // Animation Area with Stick Figure or Camera Icon or AR View
          Container(
            color: const Color(0xFF6C6C6C),
            width: double.infinity,
            height: 300,
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (_isARMode && Platform.isAndroid)
                  // AR View
                  Expanded(
                    child: ARView(
                      onARViewCreated:
                          (
                            sessionManager,
                            objectManager,
                            anchorManager,
                            locationManager,
                          ) {
                            final modelPath =
                                widget.kosakataData != null &&
                                    currentIndex < widget.kosakataData!.length
                                ? widget.kosakataData![currentIndex]['pathGlb']
                                : null;
                            if (modelPath != null && modelPath.isNotEmpty) {
                              onARViewCreated(
                                sessionManager,
                                objectManager,
                                anchorManager,
                                locationManager,
                                modelPath,
                              );
                            }
                          },
                    ),
                  )
                else if (_isAnimationMode)
                  // Stick Figure Animation
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            final pose = _getInterpolatedPose(
                              _animationController.value,
                            );
                            return CustomPaint(
                              painter: StickFigurePainter(
                                animationValue: _animationController.value,
                                pose: pose,
                              ),
                              size: const Size(200, 200),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                else
                  // Camera Icon
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4ECDC4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Ketuk kamera untuk memulai AR',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Info Box
          Container(
            color: const Color(0xFF6C6C6C),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2196F3),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(
                    Icons.accessibility,
                    color: Colors.white,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: const Text(
                      'Atau gunakan tombol "Animasi Isyarat" untuk melihat gerakan bahasa isyarat',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Area
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Object Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.book,
                          color: Colors.black54,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentObject,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Benda untuk membaca dan menulis',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Buttons Grid - Smaller size
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 3.0,
                  children: [
                    _ArButton(
                      label: _isARMode ? 'Tutup AR' : 'Mulai AR',
                      backgroundColor: _isARMode
                          ? const Color(0xFFEF5350)
                          : const Color(0xFF4ECDC4),
                      textColor: Colors.white,
                      onTap: () {
                        // Get the model path from kosakataData
                        String? modelPath;
                        if (widget.kosakataData != null &&
                            currentIndex < widget.kosakataData!.length) {
                          modelPath =
                              widget.kosakataData![currentIndex]['pathGlb'];
                        }

                        if (_isARMode) {
                          // Close AR mode
                          setState(() {
                            _isARMode = false;
                            if (modelNode != null) {
                              arObjectManager?.removeNode(modelNode!);
                            }
                          });
                        } else if (modelPath != null && modelPath.isNotEmpty) {
                          // Start AR mode
                          if (Platform.isAndroid) {
                            setState(() {
                              _isARMode = true;
                              _isAnimationMode = false;
                              _isPlaying = false;
                              _animationController.stop();
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Fitur AR hanya tersedia di Android',
                                ),
                                backgroundColor: Color(0xFFEF5350),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Model 3D tidak tersedia untuk objek ini',
                              ),
                              backgroundColor: Color(0xFFEF5350),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                    _ArButton(
                      label: _isPlaying ? 'Hentikan Animasi' : 'Mulai Animasi',
                      backgroundColor: _isPlaying
                          ? const Color(0xFFEF5350)
                          : const Color(0xFF2196F3),
                      textColor: Colors.white,
                      onTap: () {
                        setState(() {
                          if (_isPlaying) {
                            // Stop animation and hide stickman
                            _animationController.stop();
                            _isPlaying = false;
                            _isAnimationMode = false;
                          } else {
                            // Start animation and show stickman
                            _isAnimationMode = true;
                            _animationController.repeat(reverse: true);
                            _isPlaying = true;
                          }
                        });
                      },
                    ),
                    _ArButton(
                      label: 'Sebelumnya',
                      backgroundColor: Colors.white,
                      textColor: isPrevEnabled
                          ? Colors.black54
                          : Colors.grey[400]!,
                      borderColor: Colors.grey[300],
                      onTap: isPrevEnabled ? _previousItem : null,
                    ),
                    _ArButton(
                      label: 'Selanjutnya',
                      backgroundColor: const Color(0xFF4ECDC4),
                      textColor: Colors.white,
                      onTap: isNextEnabled ? _nextItem : null,
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Sign Language Section
                Row(
                  children: [
                    const Icon(
                      Icons.sign_language,
                      color: Color(0xFF4ECDC4),
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Bahasa Isyarat',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Lihat gerakan untuk "$currentObject"',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ArButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback? onTap;

  const _ArButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: borderColor != null
                ? Border.all(color: borderColor!)
                : null,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StickFigurePainter extends CustomPainter {
  final double animationValue;
  final StickFigurePose? pose;

  StickFigurePainter({required this.animationValue, this.pose});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4ECDC4)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final headPaint = Paint()
      ..color = const Color(0xFF4ECDC4)
      ..style = PaintingStyle.fill;

    // Gunakan pose dari animation_data jika tersedia
    if (pose != null) {
      _drawPose(canvas, size, paint, headPaint);
    } else {
      // Fallback ke animasi sederhana
      _drawSimpleAnimation(canvas, size, paint, headPaint);
    }
  }

  void _drawPose(Canvas canvas, Size size, Paint paint, Paint headPaint) {
    final scaleX = size.width / 4;
    final scaleY = size.height / 4;
    final offsetX = size.width / 2;
    final offsetY = size.height / 2;

    // Helper function untuk convert Vector3 ke offset
    Offset _toOffset(vector_math.Vector3 pos) {
      return Offset(offsetX + (pos.x * scaleX), offsetY - (pos.y * scaleY));
    }

    // Head
    final headPos = _toOffset(pose!.head);
    canvas.drawCircle(headPos, 10, headPaint);

    // Torso (dari shoulder ke hip)
    final leftShoulderPos = _toOffset(pose!.leftShoulder);
    final rightShoulderPos = _toOffset(pose!.rightShoulder);
    final leftHipPos = _toOffset(pose!.leftHip);
    final rightHipPos = _toOffset(pose!.rightHip);

    // Draw spine/torso
    canvas.drawLine(
      Offset(
        (leftShoulderPos.dx + rightShoulderPos.dx) / 2,
        (leftShoulderPos.dy + rightShoulderPos.dy) / 2,
      ),
      Offset(
        (leftHipPos.dx + rightHipPos.dx) / 2,
        (leftHipPos.dy + rightHipPos.dy) / 2,
      ),
      paint,
    );

    // Left arm
    final leftElbowPos = _toOffset(pose!.leftElbow);
    final leftWristPos = _toOffset(pose!.leftWrist);
    canvas.drawLine(leftShoulderPos, leftElbowPos, paint);
    canvas.drawLine(leftElbowPos, leftWristPos, paint);

    // Right arm
    final rightElbowPos = _toOffset(pose!.rightElbow);
    final rightWristPos = _toOffset(pose!.rightWrist);
    canvas.drawLine(rightShoulderPos, rightElbowPos, paint);
    canvas.drawLine(rightElbowPos, rightWristPos, paint);

    // Left leg
    final leftKneePos = _toOffset(pose!.leftKnee);
    final leftAnklePos = _toOffset(pose!.leftAnkle);
    canvas.drawLine(leftHipPos, leftKneePos, paint);
    canvas.drawLine(leftKneePos, leftAnklePos, paint);

    // Right leg
    final rightKneePos = _toOffset(pose!.rightKnee);
    final rightAnklePos = _toOffset(pose!.rightAnkle);
    canvas.drawLine(rightHipPos, rightKneePos, paint);
    canvas.drawLine(rightKneePos, rightAnklePos, paint);

    // Joints
    final jointPaint = Paint()
      ..color = const Color(0xFF4ECDC4)
      ..style = PaintingStyle.fill;

    for (final pos in [
      leftShoulderPos,
      rightShoulderPos,
      leftElbowPos,
      rightElbowPos,
      leftWristPos,
      rightWristPos,
      leftHipPos,
      rightHipPos,
      leftKneePos,
      rightKneePos,
      leftAnklePos,
      rightAnklePos,
    ]) {
      canvas.drawCircle(pos, 3, jointPaint);
    }
  }

  void _drawSimpleAnimation(
    Canvas canvas,
    Size size,
    Paint paint,
    Paint headPaint,
  ) {
    final centerX = size.width / 2;
    final baseY = size.height * 0.1;

    // Head
    canvas.drawCircle(Offset(centerX, baseY), 15, headPaint);

    // Neck and Body
    canvas.drawLine(
      Offset(centerX, baseY + 15),
      Offset(centerX, baseY + 50),
      paint,
    );

    // Arms animated
    final armRotation = animationValue * math.pi * 2;
    final armLength = 30.0;

    canvas.drawLine(
      Offset(centerX, baseY + 25),
      Offset(
        centerX + armLength * math.cos(armRotation),
        baseY + 25 + armLength * math.sin(armRotation),
      ),
      paint,
    );

    canvas.drawLine(
      Offset(centerX, baseY + 25),
      Offset(
        centerX - armLength * math.cos(armRotation),
        baseY + 25 + armLength * math.sin(armRotation),
      ),
      paint,
    );

    // Body to Hips
    canvas.drawLine(
      Offset(centerX, baseY + 50),
      Offset(centerX, baseY + 80),
      paint,
    );

    // Left Leg
    canvas.drawLine(
      Offset(centerX, baseY + 80),
      Offset(centerX - 20, baseY + 130),
      paint,
    );

    // Right Leg
    canvas.drawLine(
      Offset(centerX, baseY + 80),
      Offset(centerX + 20, baseY + 130),
      paint,
    );

    // Feet joints
    final footRadius = 4.0;
    canvas.drawCircle(Offset(centerX - 20, baseY + 130), footRadius, paint);
    canvas.drawCircle(Offset(centerX + 20, baseY + 130), footRadius, paint);
    canvas.drawCircle(Offset(centerX, baseY + 80), footRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
