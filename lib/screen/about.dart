import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'KELOMPOK 26 GACOR ABISSSSSSSSSSS',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Anggota Kelompok',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Daftar Anggota dengan Gambar
            Expanded(
              child: ListView(
                children: [
                  _buildMemberCard(
                    name: 'Muhammad Ahib Ibrilli',
                    nim: '21120122140149',
                    imageUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
                  ),
                  _buildMemberCard(
                    name: 'Akhila Zahra',
                    nim: '21120122120005',
                    imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
                  ),
                  _buildMemberCard(
                    name: 'Reyhan Zidany',
                    nim: '21120122',
                    imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg',
                  ),
                  _buildMemberCard(
                    name: 'Aditya Lutfian',
                    nim: '21120122',
                    imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat card member dengan style dan gambar
  Widget _buildMemberCard({
    required String name,
    required String imageUrl,
    required String nim,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          nim,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
