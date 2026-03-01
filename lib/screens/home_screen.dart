import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../core/widgets/common_widgets.dart';
import '../providers/auth_provider.dart';
import '../models/user_model.dart';

/// Modern Home screen with bottom navigation
/// Shows personalized welcome message and main app functionality
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: AppTheme.headline5,
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTheme.body1,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTheme.body2.copyWith(color: AppTheme.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(authNotifierProvider.notifier).logout();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text(
                'Logout',
                style: AppTheme.body2.copyWith(color: AppTheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return FadeTransition(
            opacity: _fadeAnimation,
            child: _currentIndex == 0
                ? _buildHomeContent(context, ref, currentUser)
                : _currentIndex == 1
                    ? _buildAppointmentsContent()
                    : _currentIndex == 2
                        ? _buildProfileContent(context, ref, currentUser)
                        : _buildSettingsContent(),
          );
        },
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  /// Builds the main home content
  Widget _buildHomeContent(BuildContext context, WidgetRef ref, UserModel? currentUser) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Welcome Section
          if (currentUser != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing24),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.medicalBlue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // User Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                        child: Center(
                          child: Text(
                            _getInitials(currentUser.fullName),
                            style: AppTheme.headline4.copyWith(
                              color: AppTheme.textOnPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing16),
                      // User Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome, ${currentUser.fullName}!',
                              style: AppTheme.headline4.copyWith(
                                color: AppTheme.textOnPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacing4),
                            Text(
                              currentUser.email,
                              style: AppTheme.body2.copyWith(
                                color: AppTheme.textOnPrimary.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Logout Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                        ),
                        child: IconButton(
                          onPressed: () => _showLogoutDialog(context, ref),
                          icon: const Icon(Icons.logout, color: AppTheme.textOnPrimary),
                          tooltip: 'Logout',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'User ID: ${currentUser.id}',
                    style: AppTheme.caption.copyWith(
                      color: AppTheme.textOnPrimary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            )
          else
            // Fallback welcome for non-authenticated users
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.medicalBlue, AppTheme.medicalBlueDark],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.medicalBlue.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person,
                    size: 40,
                    color: AppTheme.textOnPrimary,
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'Welcome!',
                    style: AppTheme.headline4.copyWith(
                      color: AppTheme.textOnPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'Please log in to access your account',
                    style: AppTheme.body2.copyWith(
                      color: AppTheme.textOnPrimary.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: AppTheme.spacing32),

          // Quick Actions Section
          Text(
            'Quick Actions',
            style: AppTheme.headline4.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),

          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.calendar_today,
                  title: 'Book Appointment',
                  subtitle: 'Schedule with doctors',
                  color: AppTheme.medicalBlue,
                  onTap: () {
                    Navigator.of(context).pushNamed('/consultant-selection');
                  },
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.history,
                  title: 'My Appointments',
                  subtitle: 'View booking history',
                  color: AppTheme.softTeal,
                  onTap: () {
                    // TODO: Navigate to appointments
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacing16),

          Row(
            children: [
              Expanded(
                child: _buildActionCard(
                  icon: Icons.medical_services,
                  title: 'Find Doctors',
                  subtitle: 'Browse specialists',
                  color: AppTheme.warning,
                  onTap: () {
                    Navigator.of(context).pushNamed('/consultant-selection');
                  },
                ),
              ),
              const SizedBox(width: AppTheme.spacing16),
              Expanded(
                child: _buildActionCard(
                  icon: Icons.medication,
                  title: 'Medicines',
                  subtitle: 'Order medicines',
                  color: AppTheme.success,
                  onTap: () {
                    // TODO: Navigate to medicines
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacing32),

          // Features Section
          Text(
            'Health Services',
            style: AppTheme.headline4.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppTheme.spacing20),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: AppTheme.spacing16,
            crossAxisSpacing: AppTheme.spacing16,
            childAspectRatio: 1.0,
            children: [
              _buildFeatureCard(
                icon: Icons.video_call,
                title: 'Video Consultation',
                subtitle: 'Connect with doctors online',
                color: AppTheme.medicalBlue,
              ),
              _buildFeatureCard(
                icon: Icons.local_pharmacy,
                title: 'Find Pharmacy',
                subtitle: 'Locate nearby pharmacies',
                color: AppTheme.softTeal,
              ),
              _buildFeatureCard(
                icon: Icons.science,
                title: 'Lab Tests',
                subtitle: 'Book diagnostic tests',
                color: AppTheme.warning,
              ),
              _buildFeatureCard(
                icon: Icons.health_and_safety,
                title: 'Health Records',
                subtitle: 'Access your medical history',
                color: AppTheme.success,
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds appointments content
  Widget _buildAppointmentsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.calendar_month,
            size: 80,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            'Appointments',
            style: AppTheme.headline3.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Your upcoming appointments will appear here',
            style: AppTheme.body2.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds profile content
  Widget _buildProfileContent(BuildContext context, WidgetRef ref, UserModel? currentUser) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing24),
      child: Column(
        children: [
          Text(
            'Profile',
            style: AppTheme.headline3.copyWith(
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacing32),
          
          if (currentUser != null) ...[
            // Profile Card
            Container(
              padding: const EdgeInsets.all(AppTheme.spacing24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceWhite,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(AppTheme.radiusXXLarge),
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(currentUser.fullName),
                        style: AppTheme.headline2.copyWith(
                          color: AppTheme.textOnPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacing24),
                  
                  // User Info
                  _buildProfileItem('Full Name', currentUser.fullName),
                  _buildProfileItem('Email', currentUser.email),
                  _buildProfileItem('User ID', currentUser.id.toString()),
                ],
              ),
            ),
          ] else ...[
            const EmptyState(
              title: 'Profile Not Available',
              subtitle: 'Please log in to view your profile information',
              icon: Icons.person_outline,
            ),
          ],
        ],
      ),
    );
  }

  /// Builds settings content
  Widget _buildSettingsContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.settings,
            size: 80,
            color: AppTheme.textSecondary,
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            'Settings',
            style: AppTheme.headline3.copyWith(
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'App settings and preferences will appear here',
            style: AppTheme.body2.copyWith(
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Builds action card for home screen
  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: AppTheme.elevationSmall,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing20),
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),
              SizedBox(height: AppTheme.spacing16),
              Text(
                title,
                style: AppTheme.subtitle1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppTheme.spacing4),
              Text(
                subtitle,
                style: AppTheme.body2.copyWith(
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds feature card
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      elevation: AppTheme.elevationSmall,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            SizedBox(height: AppTheme.spacing8),
            Text(
              title,
              style: AppTheme.subtitle2.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: AppTheme.spacing4),
            Text(
              subtitle,
              style: AppTheme.caption.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Builds profile item
  Widget _buildProfileItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: AppTheme.body2.copyWith(
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.body1.copyWith(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing24,
            vertical: AppTheme.spacing8,
          ),
          child: Row(
            children: [
              _buildNavItem(
                icon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              SizedBox(width: AppTheme.spacing32),
              _buildNavItem(
                icon: Icons.calendar_month,
                label: 'Appointments',
                index: 1,
              ),
              SizedBox(width: AppTheme.spacing32),
              _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                index: 2,
              ),
              SizedBox(width: AppTheme.spacing32),
              _buildNavItem(
                icon: Icons.settings,
                label: 'Settings',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds navigation item
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? AppTheme.medicalBlue : AppTheme.textSecondary,
          ),
          SizedBox(height: AppTheme.spacing4),
          Text(
            label,
            style: AppTheme.caption.copyWith(
              color: isSelected ? AppTheme.medicalBlue : AppTheme.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  /// Gets initials from full name
  String _getInitials(String fullName) {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty) return fullName[0].toUpperCase();
    if (parts.length >= 2) {
      return '${parts[0][0].toUpperCase()}${parts[1][0].toUpperCase()}';
    }
    return parts[0][0].toUpperCase();
  }
}
