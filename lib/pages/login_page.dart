import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskflow/services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  final _formkey=GlobalKey<FormState>(); //key qui nous aide a valider le formulaire et a acceder a son etat
  final _textControllerEmail=TextEditingController(); //controller qui nous aide a recuperer la valeur du champ email et a la manipuler
  final _textControllerPassword=TextEditingController(); //controller qui nous aide a recuperer la valeur du champ password et a la manipuler
  final _textControllerPasswordConfirm=TextEditingController(); //controller qui nous aide a recuperer la valeur du champ password confirm et a la manipuler
  bool _isObscure=true; //bolleen qui nous aide a cacher le mot de passe

  bool _isLoading=false; //boolean qui nous aide a desactiver les champs et les boutons pendant le chargement 
  bool _forLogin=true;   //boolean qui nous aide a basculer entre la page de connexion et d'inscription

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
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  hintText: 'Enter your password',
                  labelText: 'Password *',
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
              SizedBox(height:20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed:() async{
                    if (_formkey.currentState!.validate()){
                          setState(() {
                            _isLoading = true;
                      });
                      try{
                        if(_forLogin){
                           await AuthServices().signInWithEmailAndPassword(
                          _textControllerEmail.text,
                          _textControllerPassword.text);
                        }else{
                           await AuthServices().createUserWithEmailAndPassword(
                          _textControllerEmail.text,
                          _textControllerPassword.text);
                        }
                          setState(() {
                      _isLoading=false;
                    });
                      }on FirebaseAuthException catch(e){
                        setState(() {
                      _isLoading=false;
                    });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("${e.message}"),
                          behavior: SnackBarBehavior.floating,
                          showCloseIcon: true,
                          backgroundColor: Colors.red,)
                        );
                      }
                      
                    }
                    },
                 child:_isLoading ? const CircularProgressIndicator():  Text(_forLogin ? "se connecter": "s'inscrire")),
              ),

              ],
          ),
          

      )
    )
    );
}
}