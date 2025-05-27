import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/custom_button.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final List<Map<String, dynamic>> _events = [
    {
      'title': 'Ghana Love Mixer',
      'date': 'Saturday, June 10',
      'location': 'Accra',
      'price': 'GHS 50',
      'image': 'assets/images/event1.png',
    },
    {
      'title': 'Cultural Dance Night',
      'date': 'Friday, June 16',
      'location': 'Kumasi',
      'price': 'GHS 30',
      'image': 'assets/images/event2.png',
    },
    {
      'title': 'Beach Hangout',
      'date': 'Sunday, June 18',
      'location': 'Cape Coast',
      'price': 'Free',
      'image': 'assets/images/event3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/home')),
        title: Text(
          AppStrings.upcomingEvents,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () {
              // Show filters
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _events.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    _events[index]['image'],
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _events[index]['title'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16),
                          const SizedBox(width: 8),
                          Text(_events[index]['date']),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 8),
                          Text(_events[index]['location']),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.monetization_on, size: 16),
                          const SizedBox(width: 8),
                          Text(_events[index]['price']),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: AppStrings.joinEvent,
                        onPressed: () {
                          // Join event logic
                        },
                      ),
                    ],
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
