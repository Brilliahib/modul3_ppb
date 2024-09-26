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
  final int limit = 20;

  @override
  void initState() {
    super.initState();
    fetchData(offset);
  }

  Future<void> fetchData(int newOffset) async {
    final response = await http.get(Uri.parse(
        'https://api.mangadex.org/manga?offset=$newOffset&limit=$limit'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> mangaData = data['data'] ?? [];
      setState(() {
        mangaList.addAll(List<Map<String, dynamic>>.from(mangaData));
        offset += limit;
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
        ),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: mangaList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: mangaList.length,
                    itemBuilder: (context, index) {
                      final mangaAttributes = mangaList[index]['attributes'];
                      final mangaTitle =
                          mangaAttributes['title']['en'] ?? 'No Title';
                      final mangaId = mangaList[index]['id'];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MangaDetailPage(
                                mangaId: mangaId,
                                mangaTitle: mangaTitle,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                mangaTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchData(offset);
                  },
                  child: const Text('Load More'),
                ),
              ],
            ),
    );
  }
}
