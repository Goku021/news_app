import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:news_app/basic_structure.dart";
import "package:news_app/home_page.dart";
import "package:news_app/news_bloc.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Newss....",
      home: BlocProvider(
          create: (_) =>
              NewsBloc(ArticlesRepository())..add(FetchTopHeadlines()),
          child: HomePage()),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// final Uri _url = Uri.parse('https://flutter.dev');
//
// void main() => runApp(
//       const MaterialApp(
//         home: Material(
//           child: Center(
//             child: ElevatedButton(
//               onPressed: _launchUrl,
//               child: Text('Show Flutter homepage'),
//             ),
//           ),
//         ),
//       ),
//     );
//
// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }
