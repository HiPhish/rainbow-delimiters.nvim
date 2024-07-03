import 'package:flutter/material.dart';

class ExampleWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String id;

  const WidgetItem({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final data = {['field'] = "<value>"};
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => context.go('/example/$id'),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Expanded(
                child: Image(
                  image: AssetImage('assets/image.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(subtitle),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
