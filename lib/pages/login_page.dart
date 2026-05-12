import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formkey=GlobalKey<FormState>();
  final _textControllerEmail=TextEditingController();
  final _textControllerPassword=TextEditingController();
  final _textControllerPasswordConfirm=TextEditingController();
  bool _isObscure=true;

  bool _isLoading=false;
  bool _forLogin=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _textControllerEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Enter your email',
                  labelText: 'Email *',
                  border: OutlineInputBorder(
                  ),
                ),
                  validator:(value){
                    if(value ==null || value.isEmpty){
                      return 'Email is required';
                    }else if(!value.contains("@")){
                    return 'please enter valid Email';
                    }else if(!value.contains(".com")){
                      return 'please enter valid Email';
                    }else{
                      return null;
                    }
                  }
                
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _textControllerPassword,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  labelText: 'Password *',
                  border: OutlineInputBorder(
                  ),
                ),
                validator:(value){
                  if(value ==null || value.isEmpty){
                    return 'Password is required';
                  }else if(value.length<6){
                  return 'Password must be at least 6 characters';
                
                }else{
                  return null;
                }
                 },
                
              ),
               SizedBox(height: 20,),
              TextFormField(
                controller: _textControllerPasswordConfirm,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Retap your password',
                  labelText: 'Retap your Password *',
                  border: OutlineInputBorder(
                  ),
                   suffixIcon: IconButton(
                  onPressed: _isLoading? null: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off, color: Colors.black,)
                ),
                
                ),

                validator:(value){
                  if(value ==null || value.isEmpty){
                    return 'Password is required';
                  }else if(value.length<6){
                  return 'Password must be at least 6 characters';
                }else if(value !=_textControllerPassword.text){
                  return 'password doesn\'t match';
                }else{
                  return null;
                }
                 },
                
              ),
              ],
          ),
          

      )
    )
    );
}
}