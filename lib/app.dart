import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/core/core.dart';
import 'package:iconsax/iconsax.dart';

import 'gen/assets.gen.dart';
import 'routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          title: const Text('Widget Explorations'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(25),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Center(
                    child: Text('Tap on a link to view the widget',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior: CustomScrollBehavior(),
                child: ListView.builder(
                  itemCount: routes.length,
                  itemBuilder: (context, index) {
                    final route = routes[index];
                    return Material(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          if (index == 0)
                            const Divider(
                              height: 1.0,
                              thickness: 0.8,
                            ),
                          ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => route.widget,
                              ),
                            ),
                            leading: Text("#${index + 1}",
                                style: Theme.of(context).textTheme.bodyMedium!),
                            title: Text(route.title,
                                style: Theme.of(context).textTheme.bodyMedium!),
                            trailing: const Icon(
                              size: 20.0,
                              Iconsax.arrow_right,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const _Footer(),
          ],
        )));
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 16,
            child: Assets.images.img2.image(fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Text(
            '©${DateTime.now().year} | bahati',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ],
      ),
    );
  }
}
