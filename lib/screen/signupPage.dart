import 'package:flutter/material.dart';
import 'package:test_app/helper/radioButton.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isvisible = true;
  bool _isvisible2 = true;
  TextEditingController _passwordcontroller=TextEditingController();
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Signup to continue',
              style: TextStyle(fontSize: 30, color: Colors.blue),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextFormField(
                      //  keyboardType: ,
                      validator: (val){
                        if (val!.isEmpty){
                          return 'Enter your Username';
                        }return null;
                      },
                      decoration: const InputDecoration(
                          hintText: 'Enter Your Username',
                          label: Text('Username'),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    TextFormField(
                      //  keyboardType: ,
                      validator: (val){
                        if (val!.isEmpty){
                          return 'Enter your Phone nubmer';
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: 'Enter Your phone',
                          label: Text('Phone'),
                          prefixIcon: Icon(Icons.phone)),
                    ),
                    TextFormField(
                      controller: _passwordcontroller,
                        obscureText: _isvisible,
                        validator: (val){
                          if (val!.isEmpty){
                            return 'Enter your password';
                          }return null;
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your password',
                            label: Text('password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: visibilityCheck,
                                child: Icon(_isvisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)))),
                    TextFormField(
                        obscureText: _isvisible2,
                        validator: (val){
                         if (val==_passwordcontroller){
                           return 'Password not match';
                         } 
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter password again',
                            label: Text('ComfirmPassword'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: InkWell(
                                onTap: visibilityCheck2,
                                child: Icon(_isvisible2
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
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Text('Gender :',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
      
            Container(
               margin: const EdgeInsets.symmetric(horizontal: 25),
              child: RadioButton()),
            const SizedBox(
              height: 16,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/loging');
              },
              child: GestureDetector(
                onTap: () {
                  if (_formkey.currentState!.validate()){
                    Navigator.pushNamed(context,'/loging' );
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('signup....')));
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
                    'Signup',
                    style: TextStyle(fontSize: 20),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void visibilityCheck() {
    setState(() {
      _isvisible = !_isvisible;
    });
  }

  void visibilityCheck2() {
    setState(() {
      _isvisible2 = !_isvisible2;
    });
  }
}
