import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/cart_model.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('รายการในตะกร้า')),
      body: cart.items.isEmpty
          ? const Center(child: Text('ไม่มีสินค้าในตะกร้า'))
          : ListView.separated(
              itemCount: cart.items.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.network(
                    item.imageUrl,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                  title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                    onPressed: () => context.read<CartModel>().remove(item),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, -2))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ยอดรวม: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: cart.items.isEmpty
                  ? null
                  : () {
                      cart.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('สั่งซื้อสินค้าเรียบร้อย!')),
                      );
                      Navigator.pop(context);
                    },
              child: const Text('สั่งซื้อ'),
            ),
          ],
        ),
      ),
    );
  }
}