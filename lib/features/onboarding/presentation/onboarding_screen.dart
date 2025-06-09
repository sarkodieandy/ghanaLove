import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const OnboardingPage(
      title: AppStrings.onboardingTitle1,
      image: 'assets/images/1.png',
      showLanguageSelector: true,
    ),
    const OnboardingPage(
      title: AppStrings.onboardingTitle2,
      image: 'assets/images/2.png',
    ),
    const OnboardingPage(
      title: AppStrings.onboardingTitle3,
      image: 'assets/images/3.png',
      showMobileMoneyIcons: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skipOnboarding() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) => _pages[index],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _skipOnboarding,
                    child: Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _pages.length,
                    effect: WormEffect(
                      dotHeight: 2,
                      dotWidth: 5,
                      activeDotColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  CustomButton(
                    text: _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                    onPressed: _nextPage,
                    width: 100,
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

class OnboardingPage extends StatelessWidget {
  final String title;
  final String image;
  final bool showLanguageSelector;
  final bool showMobileMoneyIcons;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.image,
    this.showLanguageSelector = false,
    this.showMobileMoneyIcons = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, height: 300, fit: BoxFit.contain),
          const SizedBox(height: 32),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          if (showLanguageSelector) ...[
            // const LanguageSelector(),
            const SizedBox(height: 16),
          ],
          if (showMobileMoneyIcons) ...[
            const MobileMoneyIcons(),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class MobileMoneyIcons extends StatelessWidget {
  const MobileMoneyIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/mtn.png', height: 40),
        const SizedBox(width: 16),
        Image.asset('assets/images/tigo.png', height: 40),
        const SizedBox(width: 16),
        Image.asset('assets/images/vodafone.png', height: 40),
      ],
    );
  }
}
