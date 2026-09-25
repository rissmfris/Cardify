import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const CardifyApp());
}

class CardifyApp extends StatelessWidget {
  const CardifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        fontFamily: 'Sans-Serif',
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// 1. SPLASH SCREEN
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer 2 detik untuk berpindah otomatis ke OnboardingScreen
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Warna latar belakang splash
      body: Center(
        // Menampilkan Logo PNG
        child: Image.asset(
          'assets/logocardify.png', // Path/lokasi file logo Anda
          width: 180,        // Sesuaikan lebar logo yang diinginkan
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

// ==========================================
// WRAPPER ONBOARDING (PAGEVIEW 1 - 5)
// ==========================================
class OnboardingScreen extends StatefulWidget {
  final int initialPage;

  const OnboardingScreen({
    super.key,
    this.initialPage = 0,
  });
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;

@override
void initState() {
  super.initState();
  _pageController = PageController(
    initialPage: widget.initialPage,
  );
}
  int _selectedLanguageIndex = 0; // 0: Indonesia, 1: English

  // Fungsi Navigasi Langsung ke Halaman Autentikasi (Skip)
  void _navigateToAuth() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthenticationPage()),
    );
  }

  // Fungsi Pindah Halaman Onboarding
  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Mematikan swipe manual agar alur sesuai tombol
        children: [
          // 2. Onboarding 1 (Welcome)
          _buildOnboarding1(),
          // 3. Onboarding 2 (Bahasa)
          _buildOnboarding2(),
          // 4. Onboarding 3
          _buildOnboarding3(),
          // 5. Onboarding 4
          _buildOnboarding4(),
          // 6. Onboarding 5
          _buildOnboarding5(),
        ],
      ),
    );
  }

  // ------------------------------------------
  // 2. ONBOARDING 1: WELCOME
  // ------------------------------------------
  Widget _buildOnboarding1() {
    return Container(
      color: const Color(0xFF1E1E1E), // Warna latar bawah gelap
      child: Column(
        children: [
          // Header Gambar Air
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundImg.png'), // Ganti dengan gambar lokal/network
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
            ),
          ),
          // Konten Teks & Tombol
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Welcome to Cardify',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Organize your class schedule as best as possible with us.',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const Spacer(),
                  // Tombol Get Started
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _nextPage,
                      child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tombol Skip
                  Center(
                    child: TextButton(
                      onPressed: _navigateToAuth,
                      child: const Text('Skip', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------
  // 3. ONBOARDING 2: PILIH BAHASA
  // ------------------------------------------
  Widget _buildOnboarding2() {
    return SafeArea(
      child: Column(
        children: [
          // Gambar Header
          Container(
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundImg.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Select Language', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text(
                  'Choose the language that you want.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 24),
                // Pilihan Bahasa 1: Indonesia
                _buildLanguageOption(
                  index: 0,
                  title: 'Bahasa Indonesia',
                  flagAsset: 'assets/iconbahasaindonesia.jpg',
                ),
                const SizedBox(height: 12),
                // Pilihan Bahasa 2: English
                _buildLanguageOption(
                  index: 1,
                  title: 'English (UK)',
                  flagAsset: 'assets/iconbahasauk.jpg',
                  
                ),
              ],
            ),
          ),
          const Spacer(),
          // Navigasi Bawah (Back & Next)
          _buildBottomNavButtons(
            onBack: _previousPage,
            onNext: _nextPage,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({required int index, required String title, required String flagAsset}) {
    bool isSelected = _selectedLanguageIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedLanguageIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.black : Colors.transparent, width: 1.5),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10)],
          
        ),
        
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: AssetImage(flagAsset),
              
            ),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            
          ],
        ),
      ),
    );
  }

  // ------------------------------------------
  // 4. ONBOARDING 3: WHAT IS CARD GROUP & CARD?
  // ------------------------------------------
  Widget _buildOnboarding3() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkipHeader(),
            const Text('What is Card\nGroup & Card?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Sub-Fitur 1
            const Text('Card?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Cards are a feature for storing your tasks, ranging from task names, group card names, deadlines, urgency levels, task attachment files, descriptions, and progress statuses.', 
            style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            

            Image.asset(
              'assets/imgcard.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            
            // _buildCardPreview('Community Card', 'Bandung Book Party\nKomunitas Kicau Mania', 'IMPORTANT', Colors.amber),
            const SizedBox(height: 2),
            // Sub-Fitur 2
            const Text('Card Group?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Group Cards are a feature where all your cards are stored.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Image.asset(
              'assets/imgcardgroup.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            // _buildCardPreview('Academic Card', 'Nirmana\nIlustrasi\nArsitektur Komputer', 'URGENT', Colors.red, isDark: true),
            // const Spacer(),
            _buildBottomNavButtons(onBack: _previousPage, onNext: _nextPage),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------
  // 5. ONBOARDING 4: HOW TO CARD GROUP?
  // ------------------------------------------
  Widget _buildOnboarding4() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkipHeader(),
            const Text('How to Card Group?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Fitur 1: Add Card Group
            const Text('Add Card Group?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Fill in the card group name, enter the required category, press "Add Category" to add it, and select the card group color.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Image.asset(
              'assets/imgaddcardgroup.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 10),
            // Fitur 2: Edit Card Group
            const Text('Edit Card Group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Select a card group to edit its details, category, and color, but you cannot change the name.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 2),
            Image.asset(
              'assets/imgeditcardgroup.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
            const Spacer(),
            _buildBottomNavButtons(onBack: _previousPage, onNext: _nextPage),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------
  // 6. ONBOARDING 5: HOW TO CARD
  // ------------------------------------------
  Widget _buildOnboarding5() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSkipHeader(),
            const Text('How to Card', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Fitur 1: Add & Edit Card
            const Text('Add & Edit Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('You can add your task name, select a category, add a task deadline, attach a file, and add a task description.', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/imgaddcard.png',
                    height: 150,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                // const SizedBox(width: 8),
                // Expanded(
                //   child: Image.asset(
                //     'assets/imgeditcardgroup.png',
                //     height: 150,
                //     fit: BoxFit.contain,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            // Fitur 2: Finish Your Card
            const Text('Finish Your Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Text('Click on the card to mark it as finished', style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 8),
            Image.asset(
              'assets/imgfinishcard.png',
              width: double.infinity,
              height: 150,
              fit: BoxFit.contain,
              alignment: Alignment.centerLeft,
            ),
           
            const Spacer(),
            _buildBottomNavButtons(onBack: _previousPage, onNext: _navigateToAuth),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Tombol Skip di Kanan Atas
  Widget _buildSkipHeader() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: _navigateToAuth,
        child: const Text('Skip', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  // Helper Widget: Image Container
  // Widget _buildImageHolder(String path) {
  //   return Container(
  //     height: 120,
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.grey[300],
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(16),
  //       child: Container(color: Colors.teal.shade200), // Placeholder pengganti gambar
  //     ),
  //   );
  // }

  // Helper Widget: Preview Card untuk Onboarding 3
  // Widget _buildCardPreview(String title, String subtitle, String tag, Color tagColor, {bool isDark = false}) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: isDark ? const Color(0xFF222222) : Colors.white,
  //       borderRadius: BorderRadius.circular(16),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(title, style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //               decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(8)),
  //               child: Text(tag, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
  //             )
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Text(subtitle, style: TextStyle(color: isDark ? Colors.grey : Colors.black54, fontSize: 12)),
  //       ],
  //     ),
  //   );
  // }

  // Helper Widget: Tombol Navigation (Back & Next)
  Widget _buildBottomNavButtons({required VoidCallback onBack, required VoidCallback onNext}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onBack,
              child: const Text('Back', style: TextStyle(color: Colors.black)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                
                backgroundColor: const Color(0xFF222222),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onNext,
              child: const Text('Next', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. AUTHENTICATION PAGE
// ==========================================
class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const OnboardingScreen(initialPage: 4),
          ),
        );
      },
    ),
  ),
  body: Column(
        children: [
          // Header Gambar
          Expanded(
            flex: 5,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('backgroundImg.png'), // Ganti dengan gambar lokal/network
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Bagian Bawah Pilihan Sign In / Sign Up
          Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.all(24),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Welcome,', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  const Text('Choose of how you want to step in.', style: TextStyle(color: Colors.grey)),
                  const Spacer(),
                  // Tombol Sign In
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF222222),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                      child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Tombol Sign Up
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        // Fitur Sign Up (Dapat ditambahkan sesuai kebutuhan)
                      },
                      child: const Text('Sign Up', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 8. SIGN IN PAGE
// ==========================================
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Controller Form Login
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Sign In', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Username / Email
            const Text('Username/email', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                hintText: 'Insert Username/email',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            // Input Password
            const Text('Password', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                hintText: 'Insert Password',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                ),
              ),
            ),
            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot Password?', style: TextStyle(color: Colors.black54, fontSize: 12)),
              ),
            ),
            const SizedBox(height: 12),
            // Tombol Sign In
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF222222),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // Tambahkan logika autentikasi di sini
                },
                child: const Text('Sign In', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            // Alternatif Sign Up
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {},
                child: const Text("Didn't have any account? Sign Up", style: TextStyle(color: Colors.black, fontSize: 12)),
              ),
            ),
            const SizedBox(height: 24),
            // Login Google Option
            const Center(child: Text('Or Sign In With', style: TextStyle(color: Colors.grey, fontSize: 12))),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.g_mobiledata, size: 24, color: Colors.red), // Placeholder Icon Google
                label: const Text('Google', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}