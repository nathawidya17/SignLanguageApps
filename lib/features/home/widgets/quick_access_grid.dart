import 'package:flutter/material.dart';
import '../../../huruf_isyarat_page.dart';
import '../../../angka_isyarat_page.dart';
import '../../../kosakata_isyarat_page.dart';
import '../../../ar_viewer_page.dart';

import 'package:flutter/material.dart';
import '../../../features/navigation/main_navigation.dart';

class QuickAccessGrid extends StatelessWidget {
  final bool isTablet;
  const QuickAccessGrid({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isTablet ? 4 : 2,
      mainAxisSpacing: isTablet ? 24 : 16,
      crossAxisSpacing: isTablet ? 24 : 16,
      childAspectRatio: isTablet ? 1.2 : 1.15,
      children: [
        _QuickAccessCard(
          title: 'Huruf Isyarat',
          icon: Icons.sign_language,
          color: Theme.of(context).primaryColor,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const HurufIsyaratPage()),
            );
          },
        ),
        _QuickAccessCard(
          title: 'Angka Isyarat',
          icon: Icons.format_list_numbered,
          color: const Color(0xFF45B7B8),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AngkaIsyaratPage()),
            );
          },
        ),
        _QuickAccessCard(
          title: 'Kosakata',
          icon: Icons.book,
          color: const Color(0xFF96CEB4),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const KosakataIsyaratPage(),
              ),
            );
          },
        ),
        _QuickAccessCard(
          title: 'Mode AR',
          icon: Icons.view_in_ar,
          color: const Color(0xFF6C9BD1),
          onTap: () {
            // Untuk sementara tampilkan snackbar di web
            // Switch to AR tab
            MainNavigation.of(context)?.switchTab(1);
          },
        ),
      ],
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.title,
    required this.icon,
    required this.color,
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
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 28, color: color),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
