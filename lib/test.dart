//This class is testing for Firebase operations
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usernamecontrollerProvider = StateProvider((ref) {
  return "";
});
final passwcontrollerProvider = StateProvider(
  (ref) => "",
);

class TestScreen extends ConsumerWidget {
  TestScreen({super.key});
  final usernamecontroller = TextEditingController();
  final passwcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(usernamecontrollerProvider);
    final controller2 = ref.watch(passwcontrollerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Testing Firebase Operations")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
            TextField(
              textAlign: TextAlign.center
              ,decoration:InputDecoration(labelText: "UserName",), 
              controller: usernamecontroller,
              onChanged: ((value) {
                ref.read(usernamecontrollerProvider.notifier).state = value;
              }),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Password",)
              ,controller: passwcontroller,
              onChanged: (value) {
                ref.read(passwcontrollerProvider.notifier).state = value;
              },
            )
              ,
              Row(
                mainAxisAlignment: MainAxisAlignment.center
                ,children: [
                  ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      
                    },
                    ),
                ],
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center
                ,children: [
                  ElevatedButton(
                    onPressed: (){

                    }, 
                  child: Text("Sign Up")),
                ],
              )

            
          ]),
        ),
      ),
    );
  }
}
