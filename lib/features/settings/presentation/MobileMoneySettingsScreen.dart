import 'package:flutter/material.dart';

class MobileMoneySettingsScreen extends StatefulWidget {
  const MobileMoneySettingsScreen({super.key});

  @override
  State<MobileMoneySettingsScreen> createState() =>
      _MobileMoneySettingsScreenState();
}

class _MobileMoneySettingsScreenState extends State<MobileMoneySettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _momoNumberController = TextEditingController();
  String _selectedProvider = 'MTN';
  bool _isLoading = false;

  final List<String> _providers = ['MTN', 'Vodafone', 'AirtelTigo'];

  void _saveSettings() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mobile Money settings updated!')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  void dispose() {
    _momoNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Money Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _momoNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'MoMo Number',
                  hintText: 'Enter your mobile number',
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your MoMo number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedProvider,
                decoration: InputDecoration(
                  labelText: 'Select Provider',
                  prefixIcon: const Icon(Icons.account_balance_wallet),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _providers.map((provider) {
                  return DropdownMenuItem(
                    value: provider,
                    child: Text(provider),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedProvider = value!);
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text('Save Settings'),
                  onPressed: _isLoading ? null : _saveSettings,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
