import 'package:flutter/material.dart';
import 'huruf_isyarat_page.dart';
import 'kosakata_isyarat_page.dart';
import 'features/ar/screens/ar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Tunarungu',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF7F2EC), // krem
      ),
      home: const DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0
          ? _buildHomePage()
          : ArScreen(
              selectedObject: 'Buku',
              kosakataData: kosakataData,
              initialIndex: 0,
              showAppBar: false,
              onBack: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.view_in_ar), label: 'AR'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4ECDC4),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF4ECDC4),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Mari belajar huruf isyarat dan kosakata dengan cara yang menyenangkan',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).push(_createRoute(const HurufIsyaratPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Mulai Belajar',
                      style: TextStyle(
                        color: Color(0xFF4ECDC4),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Quick Access Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Quick Access',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF343A40),
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _QuickAccessCard(
                      icon: Icons.sign_language,
                      title: 'Huruf Isyarat',
                      onTap: () {
                        Navigator.of(
                          context,
                        ).push(_createRoute(const HurufIsyaratPage()));
                      },
                    ),
                    _QuickAccessCard(
                      icon: Icons.menu_book,
                      title: 'Kosakata',
                      onTap: () {
                        Navigator.of(
                          context,
                        ).push(_createRoute(const KosakataIsyaratPage()));
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

PageRouteBuilder _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(
        begin: begin,
        end: end,
      ).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF4ECDC4)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF343A40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
