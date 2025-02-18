import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';

final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);

class ThemeSwitcherScaffold extends StatefulWidget {
  const ThemeSwitcherScaffold({
    super.key,
    this.title,
    required this.body,
  });

  final Widget? title;
  final Widget body;

  @override
  State<ThemeSwitcherScaffold> createState() => _ThemeSwitcherScaffoldState();
}

class _ThemeSwitcherScaffoldState extends State<ThemeSwitcherScaffold>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _radiusAnimation;
  final screenshotController = ScreenshotController();

  Uint8List? _image1;
  ui.Image? _image2;
  Brightness? _statusBarIconBrighness;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    //TODO: Calculate current devices max radius based on the device sizes
    _radiusAnimation = Tween<double>(begin: 0.0, end: 1000.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   // Get screen size
  //   final size = MediaQuery.of(context).size;

  //   // Calculate maximum radius needed to cover the screen
  //   // from the theme toggle button position (top-right)
  //   final buttonPosition =
  //       Offset(size.width - 20, 80); 

  //   // Calculate distances to all corners
  //   final topLeft = buttonPosition.distance;
  //   final topRight = (buttonPosition - Offset(size.width, 0)).distance;
  //   final bottomLeft = (buttonPosition - Offset(0, size.height)).distance;
  //   final bottomRight =
  //       (buttonPosition - Offset(size.width, size.height)).distance;

  //   // Use the maximum distance as radius
  //   final maxRadius = [topLeft, topRight, bottomLeft, bottomRight]
  //       .reduce((max, dist) => dist > max ? dist : max);

  //   // Update the animation tween
  //   _radiusAnimation = Tween<double>(
  //     begin: 0.0,
  //     end: maxRadius,
  //   ).animate(
  //     CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
  //   );
  // }

  void _handleThemeIconPressed() async {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    final currentBrightness = isDarkTheme ? Brightness.light : Brightness.dark;

    //Update the device status bar so to match the screenshot while switching
    _statusBarIconBrighness = currentBrightness;

    //Capture the first widget image that will be used as overlay
    _image1 = await screenshotController.capture();
    setState(() {});

    //Wait for 40MS before changing the theme
    //to avoid Jank issue
    //tried less than 33MS but still janky
    //you can tried time that works well
    await Future.delayed(const Duration(milliseconds: 50));

    //Switch the current theme using ValueNotifier
    themeNotifier.value = isDarkTheme ? ThemeMode.light : ThemeMode.dark;

    // Tried 200MS but the theme is still switching
    // So i think 250MS works well here
    // you can edit this to time that works well
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() {
      _statusBarIconBrighness = currentBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
    });

    //Capture the second widget image that will be used as overlay for the circle
    _image2 = await screenshotController.captureAsUiImage();

    //Start the circle/radius animation
    _animationController.forward();

    //Delay for the radius/circle animation to complete
    await Future.delayed(const Duration(milliseconds: 600));

    //This clears the images and animation
    setState(() {
      _image1 = null;
      _image2 = null;
    });

    //This reset the animation back to zero
    _animationController.reset();

    //update the device statua bar color to match the current theme
    setState(() {
      _statusBarIconBrighness = currentBrightness == Brightness.light
          ? Brightness.dark
          : Brightness.light;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final page = ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (context, themeMode, child) {
          return Scaffold(
            appBar: widget.title != null
                ? AppBar(
                    title: widget.title,
                    actions: [
                      IconButton(
                        icon: themeMode == ThemeMode.dark
                            ? const Icon(Icons.light_mode)
                            : const Icon(
                                Icons.dark_mode,
                              ),
                        onPressed: _handleThemeIconPressed,
                      ),
                    ],
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarIconBrightness: _statusBarIconBrighness,
                    ),
                  )
                : null,
            body: widget.body,
          );
        });
    return Stack(
      children: [
        Screenshot(
          controller: screenshotController,
          child: page,
        ),
        if (_image1 != null) Image.memory(_image1!),
        if (_image2 != null)
          Align(
            alignment: Alignment.topRight,
            child: ClipOval(
              clipper: CircleClipper(_radiusAnimation.value),
              child: ShaderMask(
                blendMode: BlendMode.dstATop,
                shaderCallback: (bounds) {
                  return ImageShader(
                    _image2!,
                    TileMode.clamp,
                    TileMode.clamp,
                    Matrix4.identity().storage,
                  );
                },
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  CircleClipper(this.radius);
  final double radius;
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => true;

  @override
  ui.Rect getClip(ui.Size size) {
    return Rect.fromCircle(center: Offset(size.width - 20, 80), radius: radius);
  }
}
