import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/profile_screen_widget.dart';
import '../../../core/widgets/user_card.dart';
import '../models/user_model.dart';

class NearbyScreen extends StatelessWidget {
  NearbyScreen({super.key});

  final List<UserModel> mockUsers = [
    const UserModel(
      name: "Ama",
      age: 24,
      location: "Accra",
      imageUrl: "assets/images/home1.png",
      latitude: 5.5593,
      longitude: -0.1974,
    ),
    const UserModel(
      name: "Ella",
      age: 28,
      location: "Kumasi",
      imageUrl: "assets/images/home2.png",
      latitude: 6.6886,
      longitude: -1.6244,
    ),
    const UserModel(
      name: "Akosua",
      age: 22,
      location: "Takoradi",
      imageUrl: "assets/images/home3.png",
      latitude: 4.9046,
      longitude: -1.7590,
    ),
    const UserModel(
      name: "Akua",
      age: 30,
      location: "Sunyani",
      imageUrl: "assets/images/home1.png",
      latitude: 7.3397,
      longitude: -2.3268,
    ),
    const UserModel(
      name: "Abena",
      age: 25,
      location: "Tamale",
      imageUrl: "assets/images/home2.png",
      latitude: 9.4071,
      longitude: -0.8539,
    ),
    const UserModel(
      name: "Angela",
      age: 27,
      location: "Ho",
      imageUrl: "assets/images/home3.png",
      latitude: 6.6000,
      longitude: 0.4700,
    ),
  ];

  static const LatLng currentPosition = LatLng(5.6037, -0.1870); // Accra

  void _navigateToProfile(BuildContext context, UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          name: user.name,
          age: user.age,
          location: user.location,
          bio:
              'Hi, I\'m ${user.name} from ${user.location}. Looking to connect!',
          photo: user.imageUrl,
          userId: '',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("See Who's Nearby"),
        backgroundColor: AppColors.primaryRed,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: currentPosition,
                crs: const Epsg3857(),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentPosition,
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      child: const Icon(Icons.my_location, color: Colors.blue),
                    ),
                    ...mockUsers.map(
                      (user) => Marker(
                        point: LatLng(user.latitude, user.longitude),
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () => _navigateToProfile(context, user),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(user.imageUrl),
                            radius: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: mockUsers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (_, index) {
                final user = mockUsers[index];
                return UserCard(
                  user: user,
                  onTap: () => _navigateToProfile(context, user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
