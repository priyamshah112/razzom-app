import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razzom/accounts/screens/wrapper.dart';
import 'package:razzom/accounts/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}

// class Signup extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Razzom',
//           style: TextStyle(
//             color: Color(0xFFFFFFFF),
//             fontFamily: 'Bahnschrift',
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.8,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Color(0xFF0C1A24),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           child: ListView(
//             padding: EdgeInsets.all(10.0),
//             children: <Widget>[
//               TextFormField(
//                 style: TextStyle(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'Name',
//                   hintStyle: TextStyle(
//                     color: Color(0xFFFFFFFF),
//                   ),
//                   fillColor: Color(0xFF0C1A24),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 textInputAction: TextInputAction.next,
//               ),
//               TextFormField(
//                 style: TextStyle(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'Name',
//                   hintStyle: TextStyle(
//                     color: Color(0xFFFFFFFF),
//                   ),
//                   fillColor: Color(0xFF0C1A24),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 textInputAction: TextInputAction.next,
//               ),
//               TextFormField(
//                 style: TextStyle(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'Name',
//                   hintStyle: TextStyle(
//                     color: Color(0xFFFFFFFF),
//                   ),
//                   fillColor: Color(0xFF0C1A24),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Color(0xFF0C1A24),
//                     ),
//                     borderRadius: const BorderRadius.all(
//                       const Radius.circular(20.0),
//                     ),
//                   ),
//                 ),
//                 textInputAction: TextInputAction.next,
//               ),
//             ],
//           ),
//         ),
//       ),
//       // body: Container(
//       //   width: double.infinity,
//       //   child:
//       // child: Column(
//       //   children: [
//       //     Row(
//       //       children: [
//       //         Text(
//       //           'razzom.com',
//       //           textAlign: TextAlign.center,
//       //         ),
//       //       ],
//       //     ),
//       //     Row(
//       //       children: [
//       //         Text(
//       //           'Connect. Empower. Grow.',
//       //           textAlign: TextAlign.center,
//       //         )
//       //       ],
//       //     )
//       //   ],
//       // ),
//       // ),
//     );
//   }
// }
