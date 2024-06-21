import 'package:flutter/material.dart';

<<<<<<< HEAD
import 'mainpage.dart';

=======
>>>>>>> 881c6d18ed55779bfdb0d2eef41582093c69b5fc
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(home: Mainpage());
  }
}
=======
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Test!'),
        ),
      ),
    );
  }
}
>>>>>>> 881c6d18ed55779bfdb0d2eef41582093c69b5fc
