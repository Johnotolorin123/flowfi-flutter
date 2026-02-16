import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/primary_button.dart';
import '../auth/welcome_screen.dart';

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({Key? key}) : super(key: key);

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      image: 'assets/images/onboarding_1.png',
      title: 'Save your money\nconveniently.',
      subtitle: 'Get 5% cash back for each transaction an spend it easily.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_2.png',
      title: 'Save your money for\nfree and get rewards.',
      subtitle: 'Get the most secure payment app ever and enjoy it.',
    ),
    OnboardingData(
      image: 'assets/images/onboarding_3.png',
      title: 'Enjoy commission-free\nstock trading.',
      subtitle: 'Online investing has never been easier than it is right now.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Logo at top
            Image.asset(
              'assets/images/logo.png',
              width: 56,
              height: 56,
            ),

            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Bottom section - Dots and Button in SAME ROW
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Dot indicators (left side)
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(index),
                    ),
                  ),

                  // Button (right side)
                  PrimaryButton(
                    label: _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    width: 153,
                    height: 72,
                    maskAsset: 'assets/images/button_mask.png',
                    showArrow: _currentPage != _pages.length - 1,
                    onTap: () {
                      if (_currentPage == _pages.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          Image.asset(
            data.image,
            height: 220,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 60),

          // Title - Bold blue text
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              data.title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF5B67F6),
                height: 1.2,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Subtitle - Purple smaller text
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              data.subtitle,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: const Color(0xFF9B6BFF),
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 8),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5B67F6) : const Color(0xFFD0D5DD),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
