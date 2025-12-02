import 'package:vector_math/vector_math_64.dart' as vector_math;

class StickFigurePose {
  final vector_math.Vector3 head;
  final vector_math.Vector3 leftShoulder;
  final vector_math.Vector3 rightShoulder;
  final vector_math.Vector3 leftElbow;
  final vector_math.Vector3 rightElbow;
  final vector_math.Vector3 leftWrist;
  final vector_math.Vector3 rightWrist;
  final vector_math.Vector3 leftHip;
  final vector_math.Vector3 rightHip;
  final vector_math.Vector3 leftKnee;
  final vector_math.Vector3 rightKnee;
  final vector_math.Vector3 leftAnkle;
  final vector_math.Vector3 rightAnkle;

  const StickFigurePose({
    required this.head,
    required this.leftShoulder,
    required this.rightShoulder,
    required this.leftElbow,
    required this.rightElbow,
    required this.leftWrist,
    required this.rightWrist,
    required this.leftHip,
    required this.rightHip,
    required this.leftKnee,
    required this.rightKnee,
    required this.leftAnkle,
    required this.rightAnkle,
  });

  StickFigurePose copyWith({
    vector_math.Vector3? head,
    vector_math.Vector3? leftShoulder,
    vector_math.Vector3? rightShoulder,
    vector_math.Vector3? leftElbow,
    vector_math.Vector3? rightElbow,
    vector_math.Vector3? leftWrist,
    vector_math.Vector3? rightWrist,
    vector_math.Vector3? leftHip,
    vector_math.Vector3? rightHip,
    vector_math.Vector3? leftKnee,
    vector_math.Vector3? rightKnee,
    vector_math.Vector3? leftAnkle,
    vector_math.Vector3? rightAnkle,
  }) {
    return StickFigurePose(
      head: head ?? this.head,
      leftShoulder: leftShoulder ?? this.leftShoulder,
      rightShoulder: rightShoulder ?? this.rightShoulder,
      leftElbow: leftElbow ?? this.leftElbow,
      rightElbow: rightElbow ?? this.rightElbow,
      leftWrist: leftWrist ?? this.leftWrist,
      rightWrist: rightWrist ?? this.rightWrist,
      leftHip: leftHip ?? this.leftHip,
      rightHip: rightHip ?? this.rightHip,
      leftKnee: leftKnee ?? this.leftKnee,
      rightKnee: rightKnee ?? this.rightKnee,
      leftAnkle: leftAnkle ?? this.leftAnkle,
      rightAnkle: rightAnkle ?? this.rightAnkle,
    );
  }
}

class KeyFrame {
  final Duration timestamp;
  final StickFigurePose pose;
  final String instruction;
  final String description;

  const KeyFrame({
    required this.timestamp,
    required this.pose,
    required this.instruction,
    required this.description,
  });
}

class SignLanguageAnimation {
  final String word;
  final List<KeyFrame> keyFrames;
  final Duration duration;
  final String description;

  const SignLanguageAnimation({
    required this.word,
    required this.keyFrames,
    required this.duration,
    required this.description,
  });
}

// Animasi untuk kata "BUKU"
class BukuAnimation {
  static final StickFigurePose poseAwal = StickFigurePose(
    head: vector_math.Vector3(0.0, 1.8, 0.0),
    leftShoulder: vector_math.Vector3(-0.3, 1.5, 0.0),
    rightShoulder: vector_math.Vector3(0.3, 1.5, 0.0),
    leftElbow: vector_math.Vector3(-0.4, 1.2, 0.0),
    rightElbow: vector_math.Vector3(0.4, 1.2, 0.0),
    leftWrist: vector_math.Vector3(-0.5, 0.9, 0.0),
    rightWrist: vector_math.Vector3(0.5, 0.9, 0.0),
    leftHip: vector_math.Vector3(-0.2, 1.0, 0.0),
    rightHip: vector_math.Vector3(0.2, 1.0, 0.0),
    leftKnee: vector_math.Vector3(-0.2, 0.5, 0.0),
    rightKnee: vector_math.Vector3(0.2, 0.5, 0.0),
    leftAnkle: vector_math.Vector3(-0.2, 0.1, 0.0),
    rightAnkle: vector_math.Vector3(0.2, 0.1, 0.0),
  );

  // Gerakan 1: Rapatkan telapak tangan kiri dan kanan
  static final StickFigurePose rapatkanTangan = StickFigurePose(
    head: vector_math.Vector3(0.0, 1.8, 0.0),
    leftShoulder: vector_math.Vector3(-0.3, 1.5, 0.0),
    rightShoulder: vector_math.Vector3(0.3, 1.5, 0.0),
    leftElbow: vector_math.Vector3(-0.2, 1.3, 0.0), // Tangan kiri diangkat
    rightElbow: vector_math.Vector3(0.2, 1.3, 0.0), // Tangan kanan diangkat
    leftWrist: vector_math.Vector3(
      0.0,
      1.1,
      0.0,
    ), // Kedua tangan bertemu di tengah
    rightWrist: vector_math.Vector3(
      0.0,
      1.1,
      0.0,
    ), // Kedua tangan bertemu di tengah
    leftHip: vector_math.Vector3(-0.2, 1.0, 0.0),
    rightHip: vector_math.Vector3(0.2, 1.0, 0.0),
    leftKnee: vector_math.Vector3(-0.2, 0.5, 0.0),
    rightKnee: vector_math.Vector3(0.2, 0.5, 0.0),
    leftAnkle: vector_math.Vector3(-0.2, 0.1, 0.0),
    rightAnkle: vector_math.Vector3(0.2, 0.1, 0.0),
  );

  // Gerakan 2: Angkat setinggi dada
  static final StickFigurePose angkatSetinggiDada = StickFigurePose(
    head: vector_math.Vector3(0.0, 1.8, 0.0),
    leftShoulder: vector_math.Vector3(-0.3, 1.5, 0.0),
    rightShoulder: vector_math.Vector3(0.3, 1.5, 0.0),
    leftElbow: vector_math.Vector3(
      -0.2,
      1.4,
      0.0,
    ), // Tangan kiri diangkat lebih tinggi
    rightElbow: vector_math.Vector3(
      0.2,
      1.4,
      0.0,
    ), // Tangan kanan diangkat lebih tinggi
    leftWrist: vector_math.Vector3(
      0.0,
      1.5,
      0.0,
    ), // Kedua tangan diangkat setinggi dada
    rightWrist: vector_math.Vector3(
      0.0,
      1.5,
      0.0,
    ), // Kedua tangan diangkat setinggi dada
    leftHip: vector_math.Vector3(-0.2, 1.0, 0.0),
    rightHip: vector_math.Vector3(0.2, 1.0, 0.0),
    leftKnee: vector_math.Vector3(-0.2, 0.5, 0.0),
    rightKnee: vector_math.Vector3(0.2, 0.5, 0.0),
    leftAnkle: vector_math.Vector3(-0.2, 0.1, 0.0),
    rightAnkle: vector_math.Vector3(0.2, 0.1, 0.0),
  );

  // Gerakan 3: Gerakan membuka buku dengan 2 telapak tangan
  static final StickFigurePose gerakanMembukaBuku = StickFigurePose(
    head: vector_math.Vector3(0.0, 1.8, 0.0),
    leftShoulder: vector_math.Vector3(-0.3, 1.5, 0.0),
    rightShoulder: vector_math.Vector3(0.3, 1.5, 0.0),
    leftElbow: vector_math.Vector3(
      -0.3,
      1.4,
      0.0,
    ), // Tangan kiri bergerak ke kiri
    rightElbow: vector_math.Vector3(
      0.3,
      1.4,
      0.0,
    ), // Tangan kanan bergerak ke kanan
    leftWrist: vector_math.Vector3(
      -0.4,
      1.5,
      0.0,
    ), // Tangan kiri terbuka ke kiri
    rightWrist: vector_math.Vector3(
      0.4,
      1.5,
      0.0,
    ), // Tangan kanan terbuka ke kanan
    leftHip: vector_math.Vector3(-0.2, 1.0, 0.0),
    rightHip: vector_math.Vector3(0.2, 1.0, 0.0),
    leftKnee: vector_math.Vector3(-0.2, 0.5, 0.0),
    rightKnee: vector_math.Vector3(0.2, 0.5, 0.0),
    leftAnkle: vector_math.Vector3(-0.2, 0.1, 0.0),
    rightAnkle: vector_math.Vector3(0.2, 0.1, 0.0),
  );

  static final StickFigurePose poseAkhir = StickFigurePose(
    head: vector_math.Vector3(0.0, 1.8, 0.0),
    leftShoulder: vector_math.Vector3(-0.3, 1.5, 0.0),
    rightShoulder: vector_math.Vector3(0.3, 1.5, 0.0),
    leftElbow: vector_math.Vector3(-0.4, 1.2, 0.0),
    rightElbow: vector_math.Vector3(0.4, 1.2, 0.0),
    leftWrist: vector_math.Vector3(-0.5, 0.9, 0.0),
    rightWrist: vector_math.Vector3(0.5, 0.9, 0.0),
    leftHip: vector_math.Vector3(-0.2, 1.0, 0.0),
    rightHip: vector_math.Vector3(0.2, 1.0, 0.0),
    leftKnee: vector_math.Vector3(-0.2, 0.5, 0.0),
    rightKnee: vector_math.Vector3(0.2, 0.5, 0.0),
    leftAnkle: vector_math.Vector3(-0.2, 0.1, 0.0),
    rightAnkle: vector_math.Vector3(0.2, 0.1, 0.0),
  );

  static final SignLanguageAnimation bukuAnimation = SignLanguageAnimation(
    word: "BUKU",
    keyFrames: [
      KeyFrame(
        timestamp: Duration(seconds: 0),
        pose: poseAwal,
        instruction: "Posisi awal - berdiri tegak",
        description: "Mulai dari posisi berdiri normal",
      ),
      KeyFrame(
        timestamp: Duration(seconds: 1),
        pose: rapatkanTangan,
        instruction: "Rapatkan telapak tangan kiri dan kanan",
        description: "Kedua tangan bertemu di tengah",
      ),
      KeyFrame(
        timestamp: Duration(seconds: 2),
        pose: angkatSetinggiDada,
        instruction: "Angkat setinggi dada",
        description: "Kedua tangan diangkat setinggi dada",
      ),
      KeyFrame(
        timestamp: Duration(seconds: 3),
        pose: gerakanMembukaBuku,
        instruction: "Gerakan membuka buku dengan 2 telapak tangan",
        description: "Kedua tangan terbuka ke samping seperti membuka buku",
      ),
      KeyFrame(
        timestamp: Duration(seconds: 4),
        pose: poseAkhir,
        instruction: "Kembali ke posisi awal",
        description: "Selesai, kembali ke posisi normal",
      ),
    ],
    duration: Duration(seconds: 4),
    description: "Gerakan isyarat untuk kata 'BUKU'",
  );
}
