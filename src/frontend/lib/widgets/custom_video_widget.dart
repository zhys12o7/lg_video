import 'package:flutter/material.dart';

class CustomVideoWidget extends StatelessWidget {
  const CustomVideoWidget({
    super.key,
    this.thumbnail,
    this.onPlay,
    this.width,
    this.height,
  });

  final ImageProvider? thumbnail;
  final VoidCallback? onPlay;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double targetWidth = width ?? MediaQuery.of(context).size.width;
    final double targetHeight = height ?? targetWidth / (16 / 9);

    return SizedBox(
      width: targetWidth,
      height: targetHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.black.withOpacity(0.2),
              child: thumbnail != null
                  ? Image(
                      image: thumbnail!,
                      fit: BoxFit.cover,
                    )
                  : const Center(
                      child: Icon(
                        Icons.videocam_rounded,
                        size: 64,
                        color: Colors.white70,
                      ),
                    ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.25),
                      Colors.transparent,
                      Colors.black.withOpacity(0.35),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: FilledButton.tonalIcon(
                onPressed: onPlay,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('재생'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

