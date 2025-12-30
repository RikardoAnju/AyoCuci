import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/allTransactionReportPage.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  bool isLaporanTransaksiExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea memastikan konten tidak tertutup notch/status bar
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),

              // const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSummaryGrid(),
              ),

              // const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
              _buildMenuSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin:
              Alignment.centerLeft, // Horizontal sesuai desain Linear di Figma
          end: Alignment.centerRight,
          colors: [
            Color(0xFFF4593B), // Stop 0%
            Color(0xFFFF2900), // Stop 0% (tumpuk untuk ketajaman)
            Color(0xFFFFDD55), // Stop 50% (Kuning cerah di tengah)
            Color(0xFFCE2A0A), // Stop 100% (Merah gelap di ujung kanan)
          ],
          stops: [0.0, 0.0, 0.5, 1.0], // Menyesuaikan persentase di Figma
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dotenv.env['APP_NAME'] ?? 'Edobi',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Indonesia, Jakarta Selatan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          // Circle Logo Putih
          Container(
            height: 55,
            width: 55,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.grid_view_rounded,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryGrid() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.05,
            ), // Menggunakan withValues sesuai saran Anda
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'LAPORAN HARI INI',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFF4593B),
              fontSize: 14,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            // 1.0 = Persegi Sempurna. 0.9 = Sedikit lebih tinggi (mirip di Figma)
            childAspectRatio: 0.9,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              _buildSummaryBox('Omset', 'assets/icons/omset.png'),
              _buildSummaryBox('Pendapatan', 'assets/icons/pendapatan.png'),
              _buildSummaryBox('Pengeluaran', 'assets/icons/pengeluaran.png'),
              _buildSummaryBox(
                'Transaksi Masuk',
                'assets/icons/transaksi_masuk.png',
              ),
              _buildSummaryBox(
                'Pesanan Selesai',
                'assets/icons/pesanan_selesai.png',
              ),
              _buildSummaryBox(
                'Pesanan Batal',
                'assets/icons/pesanan_batal.png',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox(String title, String assetPath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ukuran ikon disesuaikan agar tidak memenuhi kotak
                Image.asset(
                  assetPath,
                  width: 40,
                  height: 40,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.insert_chart,
                    color: Colors.red,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          // Bagian Bawah: Aksen warna Light Pink
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFFFEBE8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11),
              ),
            ),
            child: const Text(
              'RP 0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        // ... bagian header "Laporan" tetap sama ...
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildExpansionTile(
                'Laporan Transaksi',
                'Semua data transaksi',
                'assets/icons/laporan_transaksi.png',
                [
                  'Semua Data Transaksi',
                  'Ringkasan Transaksi Per Layanan',
                  'Transaksi Diambil Customer',
                  'Semua Transaksi Batal',
                ],
              ),
              _buildExpansionTile(
                'Laporan Keuangan',
                'Laporan Omset, pendapatan, dan Pengeluaran',
                'assets/icons/laporan_keuangan.png',
                [],
                key: _keuanganKey, // Kirim key
              ),
              _buildExpansionTile(
                'Laporan Pelanggan',
                'Ringkasan, Pertumbuhan, dan Detail Pelanggan',
                'assets/icons/laporan_pelanggan.png',
                [
                  'Ringkasan Pelanggan',
                  'Pertumbuhan Pelanggan',
                  'Detail Pelanggan',
                  'Top Customer',
                ],
                key: _pelangganKey, // Kirim key
              ),
              const SizedBox(
                height: 100,
              ), // Beri space lebih di bawah agar bisa scroll maksimal
            ],
          ),
        ),
      ],
    );
  }

  // Tambahkan GlobalKey untuk masing-masing menu agar bisa di-scroll otomatis
  final GlobalKey _pelangganKey = GlobalKey();
  final GlobalKey _keuanganKey = GlobalKey();

  Widget _buildExpansionTile(
    String title,
    String subtitle,
    String assetIcon,
    List<String> subMenus, {
    GlobalKey? key,
  }) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          // Icon lingkaran chevron di kanan (Laporan Utama)
          trailing: const Icon(
            Icons.expand_circle_down_outlined,
            color: Colors.black,
            size: 24,
          ),
          onExpansionChanged: (isExpanded) {
            if (isExpanded && key != null) {
              Future.delayed(const Duration(milliseconds: 300), () {
                Scrollable.ensureVisible(
                  key.currentContext!,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              });
            }
          },
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEBE8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              assetIcon,
              width: 22,
              height: 22,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.assignment_outlined,
                color: Color(0xFFF4593B),
                size: 22,
              ),
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          // BAGIAN ANAK (Sub-menu)
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: subMenus.map((menu) {
                  return Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFEEEEEE),
                      ), // Border tipis sesuai mockup
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      title: Text(
                        menu,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black87,
                        ),
                      ),
                      // TRAILING DIHAPUS agar sesuai image_c21b6b.png
                      trailing: null,
                      onTap: () {
                        // Logika navigasi ke halaman spesifik
                        if (menu == 'Semua Data Transaksi') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AllTransactionReportPage(),
                            ),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
