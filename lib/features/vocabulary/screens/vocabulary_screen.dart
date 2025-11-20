import 'package:flutter/material.dart';
import '../../../huruf_isyarat_detail.dart';
import '../../navigation/main_navigation.dart';

class VocabularyScreen extends StatelessWidget {
  const VocabularyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> huruf = List.generate(
      26,
      (i) => String.fromCharCode(65 + i),
    );

    // Data untuk huruf isyarat
    final Map<String, Map<String, String>> hurufData = {
      'A': {
        'label': 'A untuk Apel',
        'isyaratMediaPath': 'assets/gif/a_isyarat.gif',
        'objectImagePath': 'assets/images/apel.png',
      },
      'B': {
        'label': 'B untuk Buku',
        'isyaratMediaPath': 'assets/gif/b_isyarat.gif',
        'objectImagePath': 'assets/images/buku.png',
      },
      'C': {
        'label': 'C untuk Cacing',
        'isyaratMediaPath': 'assets/gif/c_isyarat.gif',
        'objectImagePath': 'assets/images/cacing.png',
      },
      'D': {
        'label': 'D untuk Dadu',
        'isyaratMediaPath': 'assets/gif/d_isyarat.gif',
        'objectImagePath': 'assets/images/dadu.png',
      },
      'E': {
        'label': 'E untuk Elang',
        'isyaratMediaPath': 'assets/gif/e_isyarat.gif',
        'objectImagePath': 'assets/images/elang.png',
      },
      'F': {
        'label': 'F untuk Foto',
        'isyaratMediaPath': 'assets/gif/f_isyarat.gif',
        'objectImagePath': 'assets/images/foto.png',
      },
      'G': {
        'label': 'G untuk Gigi',
        'isyaratMediaPath': 'assets/gif/g_isyarat.gif',
        'objectImagePath': 'assets/images/gigi.png',
      },
      'H': {
        'label': 'H untuk Hati',
        'isyaratMediaPath': 'assets/gif/h_isyarat.gif',
        'objectImagePath': 'assets/images/hati.png',
      },
      'I': {
        'label': 'I untuk Ikan',
        'isyaratMediaPath': 'assets/gif/i_isyarat.gif',
        'objectImagePath': 'assets/images/ikan.png',
      },
      'J': {
        'label': 'J untuk Jari',
        'isyaratMediaPath': 'assets/gif/j_isyarat.gif',
        'objectImagePath': 'assets/images/jari.png',
      },
      'K': {
        'label': 'K untuk Kaki',
        'isyaratMediaPath': 'assets/gif/k_isyarat.gif',
        'objectImagePath': 'assets/images/kaki.png',
      },
      'L': {
        'label': 'L untuk Lumba-lumba',
        'isyaratMediaPath': 'assets/gif/l_isyarat.gif',
        'objectImagePath': 'assets/images/lumba.png',
      },
      'M': {
        'label': 'M untuk Mobil',
        'isyaratMediaPath': 'assets/gif/m_isyarat.gif',
        'objectImagePath': 'assets/images/mobil.png',
      },
      'N': {
        'label': 'N untuk Nasi',
        'isyaratMediaPath': 'assets/gif/n_isyarat.gif',
        'objectImagePath': 'assets/images/nasi.png',
      },
      'O': {
        'label': 'O untuk Ombak',
        'isyaratMediaPath': 'assets/gif/o_isyarat.gif',
        'objectImagePath': 'assets/images/ombak.png',
      },
      'P': {
        'label': 'P untuk Pelangi',
        'isyaratMediaPath': 'assets/gif/p_isyarat.gif',
        'objectImagePath': 'assets/images/pelangi.png',
      },
      'Q': {
        'label': 'Q untuk Quiz',
        'isyaratMediaPath': 'assets/gif/q_isyarat.gif',
        'objectImagePath': 'assets/images/quiz.png',
      },
      'R': {
        'label': 'R untuk Rumah',
        'isyaratMediaPath': 'assets/gif/r_isyarat.gif',
        'objectImagePath': 'assets/images/rumah.png',
      },
      'S': {
        'label': 'S untuk Sapu',
        'isyaratMediaPath': 'assets/gif/s_isyarat.gif',
        'objectImagePath': 'assets/images/sapu.png',
      },
      'T': {
        'label': 'T untuk Topi',
        'isyaratMediaPath': 'assets/gif/t_isyarat.gif',
        'objectImagePath': 'assets/images/topi.png',
      },
      'U': {
        'label': 'U untuk Ular',
        'isyaratMediaPath': 'assets/gif/u_isyarat.gif',
        'objectImagePath': 'assets/images/ular.png',
      },
      'V': {
        'label': 'V untuk Vase',
        'isyaratMediaPath': 'assets/gif/v_isyarat.gif',
        'objectImagePath': 'assets/images/vas.png',
      },
      'W': {
        'label': 'W untuk Wajah',
        'isyaratMediaPath': 'assets/gif/w_isyarat.gif',
        'objectImagePath': 'assets/images/wajah.png',
      },
      'X': {
        'label': 'X untuk Xylophone',
        'isyaratMediaPath': 'assets/gif/x_isyarat.gif',
        'objectImagePath': 'assets/images/xylophone.png',
      },
      'Y': {
        'label': 'Y untuk Yogurt',
        'isyaratMediaPath': 'assets/gif/y_isyarat.gif',
        'objectImagePath': 'assets/images/yogurt.png',
      },
      'Z': {
        'label': 'Z untuk Zebra',
        'isyaratMediaPath': 'assets/gif/z_isyarat.gif',
        'objectImagePath': 'assets/images/zebra.png',
      },
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final crossAxisCount = isTablet ? 4 : 2;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF4ECDC4)),
              onPressed: () {
                MainNavigation.of(context)?.switchTab(0);
              },
            ),
            title: Text(
              'Huruf Isyarat',
              style: TextStyle(
                color: const Color(0xFF343A40),
                fontWeight: FontWeight.w600,
                fontSize: isTablet ? 24 : 20,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF4ECDC4)),
                onPressed: () {
                  // TODO: Implement search functionality
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                    Text(
                      'Belajar Huruf A-Z',
                      style: TextStyle(
                        fontSize: isTablet ? 28 : 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF343A40),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pilih huruf untuk melihat isyarat dan objek terkait',
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: const Color(0xFF6C757D),
                      ),
                    ),
                  ],
                ),
              ),

              // Grid Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: huruf.length,
                    itemBuilder: (context, index) {
                      final h = huruf[index];
                      final data = hurufData[h];

                      return _LetterCard(
                        letter: h,
                        data: data,
                        onTap: () {
                          final letterData =
                              data ??
                              {
                                'label': '$h untuk ...',
                                'isyaratMediaPath': 'assets/gif/default.gif',
                                'objectImagePath': 'assets/images/default.png',
                              };
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HurufIsyaratDetailPage(
                                huruf: h,
                                label: letterData['label']!,
                                isyaratMediaPath:
                                    letterData['isyaratMediaPath']!,
                                objectImagePath: letterData['objectImagePath']!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LetterCard extends StatelessWidget {
  final String letter;
  final Map<String, String>? data;
  final VoidCallback onTap;

  const _LetterCard({
    required this.letter,
    required this.data,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF4ECDC4).withValues(alpha: 0.1),
                const Color(0xFF45B7B8).withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Sign Language GIF
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: data != null && data!['isyaratMediaPath'] != null
                      ? Image.asset(
                          data!['isyaratMediaPath']!,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: const Color(0xFFF8F9FA),
                          child: const Icon(
                            Icons.sign_language,
                            color: Color(0xFF4ECDC4),
                            size: 32,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 12),

              // Letter
              Text(
                letter,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF343A40),
                ),
              ),

              const SizedBox(height: 4),

              // Label
              Text(
                data?['label'] ?? '$letter untuk ...',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 8),

              // Arrow Icon
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4ECDC4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
