import 'package:flutter/material.dart';

class MangaDetailPage extends StatelessWidget {
  final String mangaTitle;
  final String mangaAltTitle;
  final String description;
  final int year;
  final String originalLanguage;

  const MangaDetailPage({
    super.key,
    required this.mangaTitle,
    required this.mangaAltTitle,
    required this.description,
    required this.year,
    required this.originalLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mangaTitle),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mangaAltTitle,
              style: const TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Description:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(description),
            const SizedBox(height: 16),
            Text(
              'Tahun:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(year.toString()),
            const SizedBox(height: 16),
            Text(
              'Original Language:',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(originalLanguage),
          ],
        ),
      ),
    );
  }
}
