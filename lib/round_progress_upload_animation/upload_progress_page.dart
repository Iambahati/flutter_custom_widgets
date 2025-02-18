import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'round_progress_upload_widget.dart';

class UploadProgressPage extends StatefulWidget {
  static const String routeName = '/round-progress-upload-animation';
  const UploadProgressPage({super.key});

  @override
  State<UploadProgressPage> createState() => _UploadProgressPageState();
}

class _UploadProgressPageState extends State<UploadProgressPage> {
  double _progress = 0.0;
  bool _isUploading = false;

  Future<void> _simulateUpload() async {
    setState(() {
      _isUploading = true;
      _progress = 0.0;
    });

    // Simulate upload progress
    for (var i = 0; i <= 100; i++) {
      if (!mounted) return;
      
      await Future.delayed(const Duration(milliseconds: 50));
      setState(() {
        _progress = i / 100;
      });
    }

    // Simulate network delay after completion
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;

    setState(() {
      _isUploading = false;
      _progress = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Progress Animation'),
      ),
      body: Center(
        child: RoundProgressUploadAnimation(
          radius: 100,
          progress: _progress,
          color: Colors.blue,
          child: _UserProfileAvatarWidget(
            onTap: _isUploading ? null : _simulateUpload,
          ),
        ),
      ),
    );
  }
}


class _UserProfileAvatarWidget extends StatelessWidget {
  const _UserProfileAvatarWidget({
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: Colors.grey.shade200,
          child: const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/img3.jpg'),
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(2, 4),
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(2.0),
                child: Icon(Iconsax.camera, color: Colors.black),
              ),
            ),
          ),
        ),
      ],
    );
  }
}