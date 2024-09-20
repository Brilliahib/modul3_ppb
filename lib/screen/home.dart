import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> mangaList = [];
  int offset = 0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('https://api.mangadex.org/manga'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mangaData = data['data'] ?? [];
      setState(() {
        mangaList.addAll(List<Map<String, dynamic>>.from(mangaData));
      });
    } else {
      throw Exception('Failed to load manga');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hello, Brilliahib!',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: mangaList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(), // Biarkan scroll
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: mangaList.length,
              itemBuilder: (context, index) {
                final mangaAttributes = mangaList[index]['attributes'];
                final mangaTitle = mangaAttributes['title']['en'] ?? 'No Title';
                final mangaAltTitle = mangaAttributes['altTitles'].isNotEmpty &&
                        mangaAttributes['altTitles'][0].containsKey('ja')
                    ? mangaAttributes['altTitles'][0]['ja']
                    : 'No Alt Title';
                final description = mangaAttributes['description']['en'] ??
                    'No description available';
                final year = mangaAttributes['year'] != null
                    ? int.tryParse(mangaAttributes['year'].toString()) ?? 0
                    : 0; // Menggunakan int
                final originalLanguage =
                    mangaAttributes['originalLanguage'] ?? 'Unknown';

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MangaDetailPage(
                          mangaTitle: mangaTitle,
                          mangaAltTitle: mangaAltTitle,
                          description: description,
                          year: year,
                          originalLanguage: originalLanguage,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mangaTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                                height:
                                    8.0), // Jarak antara title dan alt title
                            Text(
                              mangaAltTitle,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
