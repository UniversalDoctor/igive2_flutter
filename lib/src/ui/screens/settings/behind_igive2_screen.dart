// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class BehindIgive2Screen extends StatelessWidget {

//   final Completer<WebViewController> _controller = Completer<WebViewController>();

//   static const String routeName = '/behind';
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       body: SafeArea(
//         child: WebView(
//           initialUrl: 'https://www.universaldoctor.com/behind-igive2-ledger',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController){
//             _controller.complete(webViewController);
//           },
//         ),
//       ),
//       floatingActionButton: FutureBuilder<WebViewController>(
//         future: _controller.future,
//         builder: (BuildContext context, AsyncSnapshot<WebViewController> controller){
//           if(controller.hasData){
//             return FloatingActionButton(
//               backgroundColor: Colors.red[300],
//               child: Icon(Icons.close,),
//               onPressed: (){
//                 Navigator.pop(context);
//               },
//             );
//           }
//           return SizedBox();
//         },
//       ),
//     );
//   }
// }