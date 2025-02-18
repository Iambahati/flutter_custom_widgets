import 'package:flutter/material.dart';
import 'package:flutter_custom_widgets/core/core.dart';

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
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
          title: const Text('Widget \nExplorations'),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Tap on a link to view the widget',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 40.0,
            ),
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
                              Icons.open_in_new,
                            ),
                          ),
                          Divider(
                            height: 1.0,
                            thickness: 0.8,
                            color: Colors.white.withOpacity(0.16),
                          ),
                          ListTile(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => route.widget,
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 16.0,
                              child:
                                  Assets.images.img2.image(fit: BoxFit.cover),
                            ),
                            title: Text(
                              '©${DateTime.now().year}  | bahati',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )));
  }
}
