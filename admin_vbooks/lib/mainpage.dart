import 'package:admin_vbooks/components/custommainbutton.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Action for back button
          },
        ),
        title: const Text('Title'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              icon: Icons.book,
              text: 'Sản phẩm ',
              onPressed: () {
                // Action for button
              },
            )
          ],
        ),
      ),
    );
  }
}
