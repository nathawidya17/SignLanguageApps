import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;
import '../models/animation_data.dart';

class StickFigureRenderer extends StatefulWidget {
  final StickFigurePose pose;
  final double scale;
  final Color color;
  final bool showLabels;

  const StickFigureRenderer({
    super.key,
    required this.pose,
    this.scale = 1.0,
    this.color = Colors.teal,
    this.showLabels = false,
  });

  @override
  State<StickFigureRenderer> createState() => _StickFigureRendererState();
}

class _StickFigureRendererState extends State<StickFigureRenderer> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300 * widget.scale, 400 * widget.scale),
      painter: StickFigurePainter(
        pose: widget.pose,
        color: widget.color,
        showLabels: widget.showLabels,
      ),
    );
  }
}

class StickFigurePainter extends CustomPainter {
  final StickFigurePose pose;
  final Color color;
  final bool showLabels;

  StickFigurePainter({
    required this.pose,
    required this.color,
    required this.showLabels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final jointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Convert 3D coordinates to 2D screen coordinates
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = 50.0;

    // Helper function to convert 3D to 2D
    Offset convertTo2D(vector_math.Vector3 point) {
      return Offset(
        centerX + point.x * scale,
        centerY - point.y * scale, // Invert Y for screen coordinates
      );
    }

    // Draw joints
    final joints = [
      ('Head', pose.head),
      ('L Shoulder', pose.leftShoulder),
      ('R Shoulder', pose.rightShoulder),
      ('L Elbow', pose.leftElbow),
      ('R Elbow', pose.rightElbow),
      ('L Wrist', pose.leftWrist),
      ('R Wrist', pose.rightWrist),
      ('L Hip', pose.leftHip),
      ('R Hip', pose.rightHip),
      ('L Knee', pose.leftKnee),
      ('R Knee', pose.rightKnee),
      ('L Ankle', pose.leftAnkle),
      ('R Ankle', pose.rightAnkle),
    ];

    // Draw joints
    for (final joint in joints) {
      final position = convertTo2D(joint.$2);
      canvas.drawCircle(position, 4, jointPaint);

      if (showLabels) {
        final textSpan = TextSpan(
          text: joint.$1,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(position.dx - textPainter.width / 2, position.dy - 15),
        );
      }
    }

    // Draw bones (connections between joints)
    final bones = [
      // Head to shoulders
      (pose.head, pose.leftShoulder),
      (pose.head, pose.rightShoulder),

      // Shoulders to elbows
      (pose.leftShoulder, pose.leftElbow),
      (pose.rightShoulder, pose.rightElbow),

      // Elbows to wrists
      (pose.leftElbow, pose.leftWrist),
      (pose.rightElbow, pose.rightWrist),

      // Shoulders to hips
      (pose.leftShoulder, pose.leftHip),
      (pose.rightShoulder, pose.rightHip),

      // Hips to knees
      (pose.leftHip, pose.leftKnee),
      (pose.rightHip, pose.rightKnee),

      // Knees to ankles
      (pose.leftKnee, pose.leftAnkle),
      (pose.rightKnee, pose.rightAnkle),
    ];

    for (final bone in bones) {
      final start = convertTo2D(bone.$1);
      final end = convertTo2D(bone.$2);
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AnimatedStickFigure extends StatefulWidget {
  final SignLanguageAnimation animation;
  final bool isPlaying;
  final VoidCallback? onAnimationComplete;

  const AnimatedStickFigure({
    super.key,
    required this.animation,
    this.isPlaying = false,
    this.onAnimationComplete,
  });

  @override
  State<AnimatedStickFigure> createState() => _AnimatedStickFigureState();
}

class _AnimatedStickFigureState extends State<AnimatedStickFigure>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentFrameIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animation.duration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addListener(() {
      _updateCurrentFrame();
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAnimationComplete?.call();
      }
    });

    // Start animation immediately if isPlaying is true
    if (widget.isPlaying) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
      });
    }
  }

  void _updateCurrentFrame() {
    final progress = _animation.value;
    final totalFrames = widget.animation.keyFrames.length - 1;
    final frameProgress = progress * totalFrames;
    final frameIndex = frameProgress.floor();

    if (frameIndex != _currentFrameIndex) {
      setState(() {
        _currentFrameIndex = frameIndex;
      });
    }
  }

  @override
  void didUpdateWidget(AnimatedStickFigure oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.forward();
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_currentFrameIndex >= widget.animation.keyFrames.length) {
      return const SizedBox.shrink();
    }

    final currentFrame = widget.animation.keyFrames[_currentFrameIndex];

    // Auto-start animation if isPlaying is true
    if (widget.isPlaying && !_controller.isAnimating) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _controller.forward();
      });
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200, // Fixed height to prevent overflow
            child: StickFigureRenderer(
              pose: currentFrame.pose,
              scale: 0.8, // Smaller scale
              color: Colors.teal,
              showLabels: false,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentFrame.instruction,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Text(
                  currentFrame.description,
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
