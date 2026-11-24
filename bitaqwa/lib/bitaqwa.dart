import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const BitaqwaApp());
}

class BitaqwaApp extends StatelessWidget {
  const BitaqwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitaqwa App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE28B66),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 1. SPLASH SCREEN (ANIMATED OPEN APP)
// -----------------------------------------------------------------------------
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE28B66),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.mosque, size: 100, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Bitaqwa App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 2. HOME SCREEN (Gambar 1)
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitaqwa App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Banner (Sun & Greeting)
            Container(
              width: double.infinity,
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFFD3EBFA),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 40,
                    child: Icon(Icons.wb_sunny, size: 70, color: Colors.amber[400]),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: const Text(
                        'Assalamualaikum Fulan',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Navigation Menu Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEE8F66),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.front_hand,
                      label: 'Doa-doa',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DoaScreen())),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.calculate,
                      label: 'Zakat',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ZakatScreen())),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.access_time_filled,
                      label: 'Jadwal Sholat',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const JadwalSholatScreen())),
                    ),
                    _buildMenuItem(
                      context,
                      icon: Icons.podcasts,
                      label: 'Video Kajian',
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoKajianScreen())),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Inspirasi Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Inspirasi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildInspirasiCard(),
                  const SizedBox(height: 12),
                  _buildInspirasiCard(),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xFF635674),
            child: Icon(icon, color: Colors.orange[200], size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget _buildInspirasiCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF38475B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: const [
          Text(
            'TAHAJUD',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
          ),
          SizedBox(height: 10),
          Text(
            '"Dan pada sebagian malam hari bertahajudlah kamu sebagai suatu ibadah tambahan bagimu, mudah-mudahan Tuhanmu mengangkat kamu ke tempat yang terpuji."',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
          ),
          SizedBox(height: 6),
          Text(
            '(QS. Al-Isra : 79)',
            style: TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 3. KALKULATOR ZAKAT SCREEN (Gambar 2)
// -----------------------------------------------------------------------------
class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  final TextEditingController _hartaController = TextEditingController();
  double _totalHarta = 0;
  double _zakatDikeluarkan = 0;

  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  void _hitungZakat() {
    double harta = double.tryParse(_hartaController.text.replaceAll('.', '')) ?? 0;
    setState(() {
      _totalHarta = harta;
      _zakatDikeluarkan = harta * 0.025; // Zakat 2.5%
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zakat'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Banner Illustration Placeholder
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E5E5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.volunteer_activism, size: 80, color: Color(0xFF38475B)),
            ),
            const SizedBox(height: 20),
            // Input Box Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0EDED),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Harta',
                    style: TextStyle(color: Color(0xFFE28B66), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _hartaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Masukkan Total Harta',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xFFE28B66)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _hitungZakat,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEE8F66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('OK', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Card Total Uang
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFDB807B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Total Uang', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    _currencyFormat.format(_totalHarta),
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Card Zakat Dikeluarkan
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFA676BA),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Text('Zakat Dikeluarkan', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    _currencyFormat.format(_zakatDikeluarkan),
                    style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 4. JADWAL SHOLAT SCREEN (Gambar 3)
// -----------------------------------------------------------------------------
class JadwalSholatScreen extends StatelessWidget {
  const JadwalSholatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Header Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFF6B8797),
              ),
              child: Column(
                children: const [
                  Text(
                    'Selasa, 15 September',
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text('Dzuhur', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  SizedBox(height: 4),
                  Text(
                    '11:31',
                    style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.orangeAccent, size: 16),
                      SizedBox(width: 4),
                      Text('Karanganyar', style: TextStyle(color: Colors.white, fontSize: 13)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Schedule List Container
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                ),
                child: Column(
                  children: [
                    _buildSholatItem('Subuh', '04:12'),
                    const Divider(height: 1),
                    _buildSholatItem('Dzuhur', '11:31'),
                    const Divider(height: 1),
                    _buildSholatItem('Ashar', '14:45'),
                    const Divider(height: 1),
                    _buildSholatItem('Maghrib', '17:33'),
                    const Divider(height: 1),
                    _buildSholatItem('Isya', '18:42'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSholatItem(String name, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          Row(
            children: [
              Text(time, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(width: 10),
              const Icon(Icons.access_alarm, color: Colors.orangeAccent, size: 20),
            ],
          )
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5. VIDEO KAJIAN SCREEN & DETAIL PLAYER (Gambar 4 & 5)
// -----------------------------------------------------------------------------
class VideoKajian {
  final String title;
  final String ustadz;
  final String youtubeId;
  final String description;

  VideoKajian({
    required this.title,
    required this.ustadz,
    required this.youtubeId,
    required this.description,
  });
}

class VideoKajianScreen extends StatelessWidget {
  const VideoKajianScreen({super.key});

  // Tautan YouTube Yufid TV sesuai permintaan
  static final List<VideoKajian> videoList = [
    VideoKajian(
      youtubeId: 'MMJTQsCTjhI',
      title: 'Berbakti kepada Orang Tua',
      ustadz: 'Ustadz Khalid Basalamah',
      description:
          'Orang tua adalah pintu surga kita, maka maksimalkanlah untuk mengejar ridha Allah Subhanahu Wa Ta\'ala selama orang tua kita masih hidup. Berbuat baiklah kepada kedua orang tua, dan jangan pernah berperilaku buruk kepada mereka. Berbakti kepada orang tua termasuk amalan yang paling Allah cintai setelah salat pada waktunya. Raihlah kedua orang tuamu, jadikanlah mereka sebagai jalan untuk meraih surga dan mendapatkan ridha Allah Subhanahu Wa Ta\'ala. Amin.',
    ),
    VideoKajian(
      youtubeId: '-BE0LSTdKmc',
      title: 'Bentuk Syukur',
      ustadz: 'Ustadz Dr. Firanda Andirja, M.A.',
      description:
          'Rasa syukur merupakan landasan utama kebahagiaan seorang hamba. Ungkapkan kebaikan Allah dengan lisan dan amalan nyata sehari-hari.',
    ),
    VideoKajian(
      youtubeId: 'yRMSFkpAkOM',
      title: 'Tujuan Hidup',
      ustadz: 'Yufid TV',
      description:
          'Memahami makna hakiki dari keberadaan kita di dunia ini sesuai ajaran Al-Qur\'an dan Sunnah.',
    ),
    VideoKajian(
      youtubeId: 'LVNW6oaGbnA',
      title: 'Amalan Penghapus Dosa',
      ustadz: 'Yufid TV',
      description:
          'Penjelasan amalan harian ringan yang memiliki keutamaan luar biasa menghapuskan kesalahan dan dosa.',
    ),
    VideoKajian(
      youtubeId: 'LO_eX_n7mtQ',
      title: 'Kunci Ketenangan Hati',
      ustadz: 'Yufid TV',
      description:
          'Bagaimana mengingat Allah (dzikrullah) mampu memberikan kedamaian sejati di tengah ujian kehidupan.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Kajian'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          final item = videoList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailVideoKajianScreen(video: item),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thumbnail Image
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          'https://img.youtube.com/vi/${item.youtubeId}/hqdefault.jpg',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white70,
                        child: Icon(Icons.play_arrow, size: 36, color: Colors.orange),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.ustadz, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          item.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailVideoKajianScreen extends StatefulWidget {
  final VideoKajian video;
  const DetailVideoKajianScreen({super.key, required this.video});

  @override
  State<DetailVideoKajianScreen> createState() => _DetailVideoKajianScreenState();
}

class _DetailVideoKajianScreenState extends State<DetailVideoKajianScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.orangeAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.ustadz,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.video.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.video.description,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 6. DOA-DOA CATEGORY & LIST SCREEN (Gambar 6 & 7)
// -----------------------------------------------------------------------------
class DoaCategory {
  final String title;
  final IconData icon;

  DoaCategory({required this.title, required this.icon});
}

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  static final List<DoaCategory> categories = [
    DoaCategory(title: 'Pagi & Malam', icon: Icons.wb_twilight),
    DoaCategory(title: 'Rumah', icon: Icons.home),
    DoaCategory(title: 'Makanan &\nMinuman', icon: Icons.restaurant),
    DoaCategory(title: 'Perjalanan', icon: Icons.flight_takeoff),
    DoaCategory(title: 'Sholat', icon: Icons.accessibility_new),
    DoaCategory(title: 'Etika Baik', icon: Icons.thumb_up),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doa-doa'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Banner Illustration
            Container(
              height: 160,
              width: double.infinity,
              color: const Color(0xFFD3EBFA),
              child: const Center(
                child: Icon(Icons.wb_sunny, size: 80, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 16),
            // Category Grid View
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ListDoaScreen(categoryTitle: cat.title.replaceAll('\n', ' ')),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFFE5D5F0),
                          child: Icon(cat.icon, color: Colors.indigo, size: 28),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ListDoaScreen extends StatelessWidget {
  final String categoryTitle;
  const ListDoaScreen({super.key, required this.categoryTitle});

  static final List<String> listDoa = [
    "Do'a Sebelum Tidur",
    "Do'a Bangun Tidur",
    "Do'a Apabila Ada Yang Menakutkan Dalam Tidur",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: listDoa.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFFD3EBFA),
                  child: Icon(Icons.brightness_3, color: Color(0xFF38475B), size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    listDoa[index],
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}