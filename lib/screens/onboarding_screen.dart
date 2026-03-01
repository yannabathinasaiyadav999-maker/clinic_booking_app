import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      backgroundImageUrl: 'https://images.unsplash.com/photo-1536046795584-76a4e8c5db65?w=800&h=1200&fit=crop',
      title: 'Welcome to MediCare',
      quote: 'Your Health, Our Priority.',
      description: 'Experience world-class healthcare with our trusted network of medical professionals.',
      icon: Icons.local_hospital,
    ),
    OnboardingPage(
      backgroundImageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800&h=1200&fit=crop',
      title: 'Seamless Appointments',
      quote: 'Book Appointments Anytime, Anywhere.',
      description: 'Schedule your doctor visits instantly with our intuitive booking system.',
      icon: Icons.calendar_month,
    ),
    OnboardingPage(
      backgroundImageUrl: 'https://images.unsplash.com/photo-1582719508461-905c673771fd?w=800&h=1200&fit=crop',
      title: 'Quality Healthcare',
      quote: 'Quality Care at Your Fingertips.',
      description: 'Access top-rated clinics and doctors in your area with real-time availability.',
      icon: Icons.health_and_safety,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoAnimationController.forward();
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToLogin();
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: Stack(
        children: [
          // PageView with background images
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPageWidget(
                page: _pages[index],
                logoAnimation: _logoAnimationController,
                textAnimation: _textAnimationController,
              );
            },
          ),

          // Skip Button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing20),
                child: TextButton(
                  onPressed: _skipToEnd,
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing16,
                      vertical: AppTheme.spacing8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: AppTheme.body2.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom controls
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Page Indicator
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
                          height: AppTheme.spacing8,
                          width: _currentPage == index ? AppTheme.spacing32 : AppTheme.spacing8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacing32),

                    // Next/Get Started Button
                    PrimaryButton(
                      text: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                      onPressed: _nextPage,
                      backgroundColor: Colors.white,
                      textColor: AppTheme.medicalBlue,
                      icon: _currentPage == _pages.length - 1
                          ? const Icon(Icons.arrow_forward, size: 20)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPage page;
  final AnimationController logoAnimation;
  final AnimationController textAnimation;

  const OnboardingPageWidget({
    super.key,
    required this.page,
    required this.logoAnimation,
    required this.textAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.network(
          page.backgroundImageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: const Center(
                child: Icon(
                  Icons.local_hospital,
                  size: 100,
                  color: AppTheme.textOnPrimary,
                ),
              ),
            );
          },
        ),

        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.2),
                Colors.black.withOpacity(0.8),
              ],
            ),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacing32,
              vertical: AppTheme.spacing48,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Icon with animation
                AnimatedBuilder(
                  animation: logoAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: logoAnimation.value,
                      child: FadeTransition(
                        opacity: logoAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(AppTheme.radiusXXLarge),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            page.icon,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppTheme.spacing40),

                // Title with animation
                AnimatedBuilder(
                  animation: textAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: textAnimation,
                      child: Text(
                        page.title,
                        style: AppTheme.headline2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppTheme.spacing24),

                // Quote with animation
                AnimatedBuilder(
                  animation: textAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: textAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing24,
                          vertical: AppTheme.spacing16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          page.quote,
                          style: AppTheme.headline5.copyWith(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppTheme.spacing24),

                // Description with animation
                AnimatedBuilder(
                  animation: textAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: textAnimation,
                      child: Text(
                        page.description,
                        style: AppTheme.body1.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OnboardingPage {
  final String backgroundImageUrl;
  final String title;
  final String quote;
  final String description;
  final IconData icon;

  OnboardingPage({
    required this.backgroundImageUrl,
    required this.title,
    required this.quote,
    required this.description,
    required this.icon,
  });
}
