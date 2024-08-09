import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductCard extends ConsumerWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite = ref.watch(favoriteProvider).contains(product);

    return Card(
      child: ListTile(
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: () {
            if (isFavorite) {
              ref.read(favoriteProvider.notifier).removeFavorite(product);
            } else {
              ref.read(favoriteProvider.notifier).addFavorite(product);
            }
          },
        ),
      ),
    );
  }
}
