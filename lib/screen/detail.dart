import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mod3_kel26/screen/chapter.dart';

class MangaDetailPage extends StatefulWidget {
  final String mangaId;
  final String mangaTitle;

  const MangaDetailPage({
    super.key,
    required this.mangaId,
    required this.mangaTitle,
  });

  @override
  _MangaDetailPageState createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  List<dynamic> chapterList = [];

  @override
  void initState() {
    super.initState();
    fetchChapters(widget.mangaId);
  }

  Future<void> fetchChapters(String mangaId) async {
    final response =
        await http.get(Uri.parse('https://api.mangadex.org/chapter'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> chapters = data['data'] ?? [];

      setState(() {
        chapterList = chapters.map((chapter) {
          return {
            'id': chapter['id'],
            'title': chapter['attributes']['title'].isNotEmpty
                ? chapter['attributes']['title']
                : 'No Title',
            'volume': chapter['attributes']['volume'] ?? 'No Volume',
            'chapter': chapter['attributes']['chapter'] ?? 'No Chapter',
          };
        }).toList();
      });
    } else {
      throw Exception('Failed to load chapters');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mangaTitle),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chapters:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            chapterList.isEmpty
                ? const Text('No chapters available')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: chapterList.length,
                    itemBuilder: (context, index) {
                      final chapterTitle =
                          chapterList[index]['title'] ?? 'No Title';
                      final chapterVolume = chapterList[index]['volume'];
                      final chapterNumber = chapterList[index]['chapter'];
                      final chapterId = chapterList[index]['id'];

                      return ListTile(
                        title: Text(chapterTitle),
                        subtitle: chapterVolume != null
                            ? Text(
                                'Volume: $chapterVolume, Chapter: $chapterNumber')
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChapterDetailPage(chapterId: chapterId),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
