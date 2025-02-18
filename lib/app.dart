import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/core/core.dart';
import 'package:iconsax/iconsax.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('Flutter Animations'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(AboutPage.route()),
            icon: Icon(
              Iconsax.info_circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          
          children: const [
            AppTextDivider(text: 'Latest'),
             AppElevatedButton(
                text: "Tarrot Scroll",
                icon:  Icon(Iconsax.coin),
                onPressed: () =>
                    Navigator.of(context).push(TarotScrollPage.route()),
              ),
          ],
          ),
      )
    );
  }
}