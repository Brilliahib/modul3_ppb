import 'package:flutter/material.dart';
import 'package:mod3_kel26/widget/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<String> imageUrls = [
    'https://blogger.googleusercontent.com/img/a/AVvXsEiLlTJgS0sRn_4kalc7ttORk4aRqEqc2TDtVB5BxOHLiauxVbOqbAhke2FT7C0BjEWOhu3ST3kjRkmzIGg_mO1ADhsHJYrY7wMzw_nhZMt8gJbMLOrbw5WXhTRyw96Fz41d0q8czdW1DfhpkJQWbRQveEYGU27oM5te4i_4v2ecwv_IFKgXFUquNl8WKjs',
    'https://i.pinimg.com/736x/c9/e3/b9/c9e3b988e19c206d6118335499d8c197.jpg',
    'https://i.pinimg.com/736x/5d/86/de/5d86de8e1474c7727d0ef7a221efe97e.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  void nextPage() {
    if (currentPage < imageUrls.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NavigationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              );
            },
          ),
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.black54, // Background color for contrast
              child: const Text(
                'Welcome to MangaApp!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: Row(
              children: List.generate(imageUrls.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                  width: currentPage == index ? 12.0 : 8.0,
                  height: currentPage == index ? 12.0 : 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: ElevatedButton(
              onPressed: nextPage,
              child: Text(
                  currentPage == imageUrls.length - 1 ? 'Get Started' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
