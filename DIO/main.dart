import 'package:depi/ExpenseTracker/home_Screen.dart';
import 'package:depi/ExpenseTracker/sqflite.dart';
import 'package:depi/burger.dart';
import 'package:depi/cartModel.dart';
import 'package:depi/cart_Cubit.dart';
import 'package:depi/catalog_Screen.dart';
import 'package:depi/categories.dart';
import 'package:depi/db/HiveDB.dart';
import 'package:depi/db/hive_adapter/hive_Adapter.dart';
import 'package:depi/db/hive_adapter/home_Page.dart';
import 'package:depi/dio/home_Screen.dart';
import 'package:depi/gestureLayout.dart';
import 'package:depi/home_Page.dart';
import 'package:depi/layout.dart';
import 'package:depi/login.dart';
import 'package:depi/musicPlayer.dart';
import 'package:depi/photoGallary.dart';
import 'package:depi/products.dart';
import 'package:depi/profile.dart';
import 'package:depi/profileCard.dart';
import 'package:depi/provider_Ex.dart';
import 'package:depi/services/services_Helper.dart';
import 'package:depi/services/services_Helper_Dio.dart';
import 'package:depi/small_App/advanced_Bottom_Navbar.dart';
import 'package:depi/swap_Puzzle.dart';
import 'package:depi/taskTracker.dart';
import 'package:depi/transformGesture.dart';
import 'package:depi/wishlistModel.dart';
import 'package:depi/wishlist_Cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  //تتحط لو هتضيف اي حاجه قبل runapp
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesHelperDio.getItems();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized(); // lazem a7otha lw hst5dm 7aga abl el runApp
//   await SqliteDatabase.initDatabase(); // lazem ttnfz 2bl el runApp
//   runApp(
//     // MultiBlocProvider(
//     //   providers: [
//     //     BlocProvider<CartCubit>(
//     //       create: (context) => CartCubit(),
//     //     ),
//     //     BlocProvider<WishlistCubit>(
//     //       create: (context) => WishlistCubit(),
//     //     ),
//     //   ],
//     //   child: MyApp(),
//     // ),
//       const MyApp()
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData( colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
//       home:  HomeScreen(),
//     );
//   }
// }


// class _MyAppState extends State<MyApp> {
//   bool isDark = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       home: CatalogScreen(
//         // isDark: isDark,
//         // onThemeToggle: () {
//         //   setState(() {
//         //     isDark = !isDark;
//         //   });
//         // },
//       ),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int pid = 0;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setPid ();
//   }
//
//   void incrementPid() {
//     setState(() {
//       pid+=50;
//     });
//   }
//
//
//
//   void setPid  () async{
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     final int? Pid1 = prefs.getInt('Pid');
//     setState(() {
//       pid=Pid1??0;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Your Current Pid'),
//         backgroundColor: Colors.teal,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Column(
//
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('Maximum Pid:',style: TextStyle(fontSize: 30),),
//             Text(
//               '\$ $pid',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             // ElevatedButton(
//             //   onPressed: incrementPid,
//             //   child: Text('Increment Pid'),
//             //
//             // )
//             FloatingActionButton(onPressed: () async {
//               setState(()  {
//                 pid+=50;
//               });
//               final SharedPreferences prefs = await SharedPreferences.getInstance();
//               await prefs.setInt('Pid', pid);
//
//             },
//               child: const Icon(Icons.add),
//             )
//
//           ],
//
//         ),
//       ),
//
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
