import 'package:flutter/material.dart';
import '../widget/navigation.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> teamMembers = [
    {
      'Nama': 'Muhammad Ahib Ibrilli',
      'NIM': '21120122140149',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Gambar latar belakang dengan skala setengah halaman dan opacity 0.5
          Positioned.fill(
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                    image: NetworkImage(
                      'https://wallpapercg.com/media/ts_2x/25320.webp',
                    ),
                  ),
                  color:
                      const Color.fromARGB(255, 255, 252, 252).withOpacity(0.5),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/119148205?v=4',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                for (var member in teamMembers) ...[
                  Column(
                    children: [
                      Text(
                        member['Nama'] ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        member['NIM'] ?? 'No NIM',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      // Tambahkan bottomNavigationBar untuk navbar jika diperlukan
    );
  }
}
