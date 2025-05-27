import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';
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

  void _goBackToHome(BuildContext context) {
    context.go('/home');
  }

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

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
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
                margin: const EdgeInsets.only(bottom: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        Theme.of(context).colorScheme.primary.withOpacity(0.15),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Unlock All Features',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
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
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _PlanItem(
                              duration: '1 Month',
                              price: 'GHS 20',
                              perMonth: 'GHS 20/month',
                              isPopular: false,
                              animation: _plansAnimation,
                            ),
                            const Divider(height: 24),
                            _PlanItem(
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
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _plansAnimation,
              child: Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    _PaymentLogo(
                      asset: 'assets/images/mtn.png',
                      animation: _plansAnimation,
                    ),
                    _PaymentLogo(
                      asset: 'assets/images/tigo.png',
                      animation: _plansAnimation,
                    ),
                    _PaymentLogo(
                      asset: 'assets/images/vodafone.png',
                      animation: _plansAnimation,
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
                      context.push(
                        '/transaction',
                      ); // 👈 Navigate to TransactionScreen
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

class _PlanItem extends StatelessWidget {
  final String duration;
  final String price;
  final String perMonth;
  final bool isPopular;
  final Animation<double> animation;

  const _PlanItem({
    required this.duration,
    required this.price,
    required this.perMonth,
    required this.isPopular,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isPopular
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : null,
            border: isPopular
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 1.5,
                  )
                : null,
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          duration,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (isPopular) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Popular',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      perMonth,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                price,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentLogo extends StatelessWidget {
  final String asset;
  final Animation<double> animation;

  const _PaymentLogo({required this.asset, required this.animation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Image.asset(asset, height: 30),
        ),
      ),
    );
  }
}
