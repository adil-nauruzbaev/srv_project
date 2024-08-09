import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductSearchDelegate extends SearchDelegate<Product?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final productList = ref.watch(productProvider);
      final results = productList.when(
        data: (products) => products
            .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
        loading: () => [],
        error: (err, stack) => [],
      );

      return ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          final product = results[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            leading: SizedBox(
              width: 60,
              height: 60,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
            onTap: () {
              close(context, product);
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
