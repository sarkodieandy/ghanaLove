import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/plan_item.dart';
import '../../../core/widgets/premium_benefit.dart';

class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _benefitsAnimation;
  late Animation<double> _plansAnimation;
  late Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.95, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.3, curve: Curves.easeOut),
      ),
    );

    _benefitsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.6, curve: Curves.easeInOut),
      ),
    );

    _plansAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.easeInOut),
      ),
    );

    _buttonAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goBackToHome(BuildContext context) {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => _goBackToHome(context),
        ),
        title: FadeTransition(
          opacity: _opacityAnimation,
          child: Text(
            'GhanaLove Premium',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Card(
                elevation: 4,
                color: theme.cardColor, // ✅ Dark/light mode
                margin: const EdgeInsets.only(bottom: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        'Unlock All Features',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      PremiumBenefit(
                        icon: Icons.favorite,
                        text: AppStrings.unlimitedSwipes,
                        animation: _benefitsAnimation,
                      ),
                      PremiumBenefit(
                        icon: Icons.visibility,
                        text: AppStrings.seeLikes,
                        animation: _benefitsAnimation,
                      ),
                      PremiumBenefit(
                        icon: Icons.block,
                        text: AppStrings.adFree,
                        animation: _benefitsAnimation,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _plansAnimation,
              child: SlideTransition(
                position:
                    Tween<Offset>(
                      begin: const Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _plansAnimation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Your Plan',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 2,
                      color: theme.cardColor, // ✅ Fix card background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            PlanItem(
                              duration: '1 Month',
                              price: 'GHS 20',
                              perMonth: 'GHS 20/month',
                              isPopular: false,
                              animation: _plansAnimation,
                            ),
                            const Divider(height: 24),
                            PlanItem(
                              duration: '3 Months',
                              price: 'GHS 50',
                              perMonth: 'GHS 17/month',
                              isPopular: true,
                              animation: _plansAnimation,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeTransition(
              opacity: _buttonAnimation,
              child: ScaleTransition(
                scale: _buttonAnimation,
                child: Center(
                  child: CustomButton(
                    text: AppStrings.upgradeNow,
                    onPressed: () {
                      context.push('/transaction');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
