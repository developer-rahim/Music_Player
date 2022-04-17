import 'dart:ui';

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isvisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context,'/navbar');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ],
            ),
            Container(
              height: 200,
              width: 300,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Card(
                elevation: 100,
                shadowColor: Colors.black,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.network(
                    'https://media.istockphoto.com/vectors/login-page-on-laptop-screen-notebook-and-online-login-form-sign-in-vector-id1135341047?k=20&m=1135341047&s=612x612&w=0&h=ai30N4N8VC_uylITs2bWfJ0k3GzbWn-q0nR664tj0tk=',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Welcome Back',
                style: TextStyle(
                  fontSize: 30,
                )),
            const Text(
              'login into your existing account',
            ),
            Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      validator: (val){
                        if(val!.isEmpty){
                          return 'Please enter your number';
                        }return null;
                      },
                      //  keyboardType: ,
                      decoration: const InputDecoration(
                          hintText: 'Enter Your phone',
                          label: Text('Phone'),
                          prefixIcon: Icon(Icons.phone)),
                    ),
                    TextFormField(
                        controller: _passwordController,
                        obscureText: isvisible,
                        validator: (val){
                          if(val!.isEmpty){
                            return 'Enter your Password';
                          }return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your password',
                            label: Text('password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: visibilityCheck,
                                child: Icon(isvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off))))
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: const EdgeInsets.only(right: 30),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [Text('Forget Password ?')],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {},
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pushNamed(context, '/navbar');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Loging...Please waitt')));
                  }
                },
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blueAccent),
                  padding: const EdgeInsets.all(15),
                  child: const Center(
                      child: Text(
                    'Login',
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account ?'),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      '  SignUp',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void visibilityCheck() {
    setState(() {
      isvisible = !isvisible;
    });
  }
}
