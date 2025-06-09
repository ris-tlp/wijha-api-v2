import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wijha/screens/home/homeScreen.dart';
import 'package:wijha/screens/signUpIn/signUpIn.dart';
import 'package:wijha/widgets/loading.dart';
import '../../providers/authProvider.dart';

// class AuthChecker extends ConsumerWidget {
//   const AuthChecker({Key? key}) : super(key: key);
//
//   //  Notice here we aren't using stateless/statefull widget. Instead we are using
//   //  a custom widget that is a consumer of the state.
//   //  So if any data changes in the state, the widget will be updated.
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     //  now the build method takes a new paramaeter ScopeReader.
//     //  this object will be used to access the provider.
//
//     //  now the following variable contains an asyncValue so now we can use .when method
//     //  to imply the condition
//     final _authState = ref.watch(authStateProvider);
//     return _authState?.when(
//         data: (data) {
//           if (data != null) return const HomeScreen();
//           return const SignUpIn();
//         },
//         loading: () => const Loading(),
//         error: (e, trace) => SignUpIn()); // ErrorScreen(e, trace));
//   }
// }