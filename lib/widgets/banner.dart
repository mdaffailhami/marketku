import 'package:flutter/material.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({
    super.key,
    required this.imageUrl,
    required this.text,
  });

  final String imageUrl;
  final String text;

  @override
  Widget build(BuildContext context) {
    double height = 146;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            color: Colors.black45,
            colorBlendMode: BlendMode.darken,
          ),
          SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      shadows: [
                        const Shadow(blurRadius: 1, offset: Offset(1.5, 1.5))
                      ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
