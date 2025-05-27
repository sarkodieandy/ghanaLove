import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _momoController = TextEditingController();
  final _cardController = TextEditingController();
  bool _showSuccess = false;
  String _selectedMethod = 'momo'; // 'momo' or 'card'

  void _submitPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() => _showSuccess = false);

      Future.delayed(1.seconds, () {
        setState(() => _showSuccess = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Complete Payment',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSwitcher(
          duration: 500.ms,
          child: _showSuccess
              ? _buildSuccessState(theme)
              : _buildFormState(theme, colorScheme),
        ),
      ),
    );
  }

  Widget _buildSuccessState(ThemeData theme) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
              'assets/images/payment_success.png', // Replace with your success image
              height: 150,
            )
            .animate()
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.0, 1.0),
              curve: Curves.elasticOut,
            )
            .then(delay: 300.ms)
            .shake(),
        const SizedBox(height: 24),

        const SizedBox(height: 8),
        Text(
          'Your premium subscription is now active',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          icon: Image.asset(
            'assets/images/home.png', // Replace with home icon image
            width: 20,
            height: 20,
          ),
          label: const Text('Back to Home'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => context.go('/home'),
        ),
      ],
    );
  }

  Widget _buildFormState(ThemeData theme, ColorScheme colorScheme) {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Text(
            'Payment Method',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _PaymentMethodCard(
                  image: 'assets/images/momo.png',
                  title: 'Mobile Money',
                  isSelected: _selectedMethod == 'momo',
                  onTap: () => setState(() => _selectedMethod = 'momo'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PaymentMethodCard(
                  image: 'assets/images/card.png',
                  title: 'Credit Card',
                  isSelected: _selectedMethod == 'card',
                  onTap: () => setState(() => _selectedMethod = 'card'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          if (_selectedMethod == 'momo') ...[
            _buildInputField(
              theme,
              label: 'Mobile Money Number',
              hint: 'Enter your phone number',
              prefixImage: 'assets/images/phone_icon.png',
              controller: _momoController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your MoMo number' : null,
              keyboardType: TextInputType.phone,
            ),
          ] else ...[
            _buildInputField(
              theme,
              label: 'Card Number',
              hint: '1234 5678 9012 3456',
              prefixImage: 'assets/images/card.png',
              controller: _cardController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your card number' : null,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    theme,
                    label: 'Expiry Date',
                    hint: 'MM/YY',
                    prefixImage: 'assets/images/calender_icon.png',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter expiry date' : null,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildInputField(
                    theme,
                    label: 'CVV',
                    hint: '123',
                    prefixImage: 'assets/images/lock_icon.png',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter CVV' : null,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 32),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              shadowColor: colorScheme.primary.withOpacity(0.3),
            ),
            onPressed: _submitPayment,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/payment_icon.png',
                  width: 24,
                  height: 24,
                ),
                const SizedBox(width: 12),
                const Text('Pay Now'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/secure_icon.png',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 8),
              Text(
                'Secure payment encrypted',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    ThemeData theme, {
    required String label,
    required String hint,
    required String prefixImage,
    required FormFieldValidator<String>? validator,
    TextEditingController? controller,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(prefixImage, width: 20, height: 20),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodCard({
    required this.image,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.1)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            Image.asset(image, width: 40, height: 40, fit: BoxFit.contain),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
