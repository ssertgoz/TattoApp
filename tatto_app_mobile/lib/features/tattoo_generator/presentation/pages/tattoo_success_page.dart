import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import '../../../../main.dart';

class TattooSuccessPage extends StatelessWidget {
  const TattooSuccessPage({super.key});

  Future<void> _openGallery() async {
    if (Platform.isIOS) {
      await launchUrl(Uri.parse('photos-redirect://'));
    } else if (Platform.isAndroid) {
      final intent = Uri.parse('content://media/internal/images/media');
      if (await canLaunchUrl(intent)) {
        await launchUrl(intent);
      } else {
        // Fallback to view all images
        await launchUrl(
          Uri.parse('content://media/external/images/media'),
          mode: LaunchMode.externalApplication,
        );
      }
    }
    Future.delayed(Duration(seconds: 2), () {
      navigatorKey.currentState?.pop();
      navigatorKey.currentState?.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFFFF4B55),
                size: 64,
              ),
              const SizedBox(height: 24),
              const Text(
                'Saved to Gallery',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your tattoo has been saved to your gallery.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white24),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: _openGallery,
                      child: const Text(
                        'View in Gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF4B55),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        navigatorKey.currentState?.pop();
                        navigatorKey.currentState?.pop();
                      },
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
