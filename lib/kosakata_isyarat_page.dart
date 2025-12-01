import 'package:flutter/material.dart';
import 'kosakata_detail_page.dart';
import 'features/ar/screens/ar_screen.dart';

class KosakataIsyaratPage extends StatelessWidget {
  const KosakataIsyaratPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> kosakataData = [
      {
        'nama': 'Buku',
        'deskripsi':
            'Buku adalah teman belajar yang seru! Dengan buku, kita bisa membaca cerita dan belajar hal baru setiap hari.',
        'pathGif': 'assets/gif/buku.gif',
        'pathGlb': 'assets/glb/buku.glb',
        'imagePath': 'assets/images/buku.png',
        'color': const Color(0xFF4ECDC4),
      },
      {
        'nama': 'Bola',
        'deskripsi':
            'Bola adalah mainan bulat yang bisa kita lempar, tendang, dan mainkan bersama teman. Bermain bola itu menyenangkan!',
        'pathGif': 'assets/gif/bola.gif',
        'pathGlb': 'assets/glb/bola.glb',
        'imagePath': 'assets/images/bola.png',
        'color': const Color(0xFF45B7B8),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4ECDC4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Kosakata Isyarat',
          style: TextStyle(
            color: Color(0xFF343A40),
            fontWeight: FontWeight.w600,
            fontSize: 20,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            const Text(
              'Belajar Kosakata',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF343A40),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Pilih Kosakata untuk melihat isyarat, deskripsi, dan model AR',
              style: TextStyle(fontSize: 16, color: Color(0xFF6C757D)),
            ),
            const SizedBox(height: 40),

            // Kosakata Items
            Expanded(
              child: ListView.builder(
                itemCount: kosakataData.length,
                itemBuilder: (context, index) {
                  final data = kosakataData[index];
                  return _KosakataItem(
                    data: data,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => KosakataDetailPage(
                            nama: data['nama'],
                            deskripsi: data['deskripsi'],
                            pathGif: data['pathGif'],
                            pathGlb: data['pathGlb'],
                          ),
                        ),
                      );
                    },
                    onArTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ArScreen(
                            selectedObject: data['nama'],
                            kosakataData: kosakataData,
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KosakataItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback onArTap;

  const _KosakataItem({
    required this.data,
    required this.onTap,
    required this.onArTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Object Name Label
          Text(
            data['nama'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: data['color'],
            ),
          ),
          const SizedBox(height: 12),

          // Image and Video Row
          Row(
            children: [
              // Object Image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(data['imagePath'], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Sign Video
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.asset(data['pathGif'], fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Object Explanation Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
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
                        color: data['color'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.sign_language,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Isyarat untuk "${data['nama']}"',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF343A40),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  data['deskripsi'],
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF6C757D),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // AR Button Row
          Row(
            children: [
              // AR Button
              Expanded(
                flex: 2,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [data['color'], data['color'].withOpacity(0.8)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: data['color'].withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onArTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.view_in_ar,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Lihat dalam AR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Arrow Button
              // Container(
              //   width: 56,
              //   height: 56,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: data['color'], width: 2),
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              //   child: IconButton(
              //     onPressed: onTap,
              //     icon: Icon(Icons.arrow_forward, color: data['color']),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
