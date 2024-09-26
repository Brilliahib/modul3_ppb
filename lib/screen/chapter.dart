import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChapterDetailPage extends StatefulWidget {
  final String chapterId;

  const ChapterDetailPage({super.key, required this.chapterId});

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  Map<String, dynamic>? chapterData;
  late String baseUrl;

  @override
  void initState() {
    super.initState();
    fetchChapterDetails(widget.chapterId);
  }

  Future<void> fetchChapterDetails(String chapterId) async {
    final response = await http
        .get(Uri.parse('https://api.mangadex.org/at-home/server/$chapterId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        chapterData = data;
        baseUrl = data['baseUrl']; // Store baseUrl for image loading
      });
    } else {
      throw Exception('Failed to load chapter details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter Details'),
        backgroundColor: const Color.fromARGB(255, 13, 105, 225),
      ),
      body: chapterData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chapter ID: ${chapterData!['chapter']['hash']}'),
                  const SizedBox(height: 16),
                  const Text('Images:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  // Displaying chapter images
                  Column(
                    children: (chapterData!['chapter']['data'] as List)
                        .map<Widget>((image) {
                      // Construct full URL with baseUrl and chapter hash
                      final imageUrl =
                          '$baseUrl/data/${chapterData!['chapter']['hash']}/$image';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Image.network(imageUrl),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}
