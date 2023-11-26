import 'package:advertech_test_task/sending_data.dart';
import 'package:flutter/material.dart';
import 'circle_lock.dart';

void main() {
  runApp(const TestTaskApp());
}

class TestTaskApp extends StatelessWidget {
  const TestTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Advertech Test Task',
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  final GlobalKey<FormState> _messageFormKey = GlobalKey<FormState>();

  SendingData sendingData = SendingData();

  bool _inWorking = false;

  String? nameMessageErrorText;
  String? emailErrorText;

  bool _isValid = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Contact us"),
        leading: const BackButton(),
      ),
      body: Form(
        key: _messageFormKey,
        onChanged: () => setState(() => _isValid = _messageFormKey.currentState!.validate()),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const CircleLock(),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Text field is empty!";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Name",
                      ),
                      keyboardType: TextInputType.name,
                      controller: nameController,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const CircleLock(),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Text field is empty!";
                        }
                        else if (!RegExp(r'^[A-Za-z0-9]+([-._]*[A-Za-z0-9]+)*@[A-Za-z0-9]+([-.]*[A-Za-z0-9]+)*\.[A-Za-z]+$').hasMatch(value)) {
                          return "Invalid email address!";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const CircleLock(),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Text field is empty!";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: "Message",
                      ),
                      keyboardType: TextInputType.text,
                      controller: messageController,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                onPressed: _isValid ? () {
                  setState(() {
                    _inWorking = true;
                  });
                  sendingData.sendData(nameController.text, emailController.text, messageController.text).then((value) {
                    nameController.clear();
                    emailController.clear();
                    messageController.clear();
                    if (value == 201) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Row(
                            children: [
                              Icon(Icons.check, size: 20, color: Colors.green,),
                              Text("Message sent successfully")
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK")
                            )
                          ],
                        )
                      );
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            content: const Row(
                              children: [
                                Icon(Icons.close, size: 20, color: Colors.red,),
                                Text("Error sending a message")
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text("OK")
                              )
                            ],
                          )
                      );
                    }
                  });
                  setState(() {
                    _inWorking = false;
                  });
                } : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFF986d8e),
                  disabledForegroundColor: Colors.white,
                ),
                child: _inWorking ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                    SizedBox(width: 15,),
                    Text("Please Wait")
                  ],
                ) : const Text("Send"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
