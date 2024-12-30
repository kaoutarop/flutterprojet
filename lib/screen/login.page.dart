import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _keyform=GlobalKey<FormState>();

  final TextEditingController _emailController=TextEditingController();

  final TextEditingController _passwordController=TextEditingController();

  bool _passVisible = false;

  String? _emailvalidator(String? value)
  {
    if(value==null||value.isEmpty) return "please enter you email";
    final _emailPattern =r'^[^@]+@[^@]+\.[^@]+$';
    final regexp=RegExp(_emailPattern);
    if(!regexp.hasMatch(value)) return "Please enter a valid email adress ";
    return null;
  }

  String? _passvalidator(String? value )
  {if(value==null||value.isEmpty) return "please enter you password";
  if(value.length<6) return 'password must be at least 6 characters';
  return null;

  }
  // Fonction de connexion avec Firebase
  Future<void> SignIn() async {
    if (_keyform.currentState!.validate()) {
      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        // Appel Firebase pour s'authentifier
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        // Vérifier si l'utilisateur est connecté
        if (userCredential.user != null) {
          // Redirection vers la page d'accueil si la connexion est réussie
          Navigator.pushNamed(context, '/home');
        } else {
          // Si l'utilisateur n'est pas trouvé (cela ne devrait normalement pas se produire)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Utilisateur introuvable.')),
          );
        }
      } on FirebaseAuthException catch (e) {
        // Afficher un message d'erreur en cas de problème
        String message;
        if (e.code == 'user-not-found') {
          message = 'Aucun utilisateur trouvé avec cet email.';
        } else if (e.code == 'wrong-password') {
          message = 'Mot de passe incorrect.';
        } else {
          message = 'La connexion a échoué. Veuillez réessayer.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Une erreur est survenue. Veuillez réessayer.')),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page ',
          style: TextStyle(color: Colors.white,fontSize: 60),),backgroundColor: Colors.blueGrey,

      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(key:_keyform,child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Image.asset('images/login_logo.webp',
              height: 120,
              width: 120),
            Text('hello back to the home page!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 29,color: Colors.blueAccent),),
            SizedBox(height: 20),
            TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "email",border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.blueAccent,
                    )),
                keyboardType: TextInputType.emailAddress,
                validator: _emailvalidator
            ),
            SizedBox(height: 20),
            TextFormField(
                controller: _passwordController,
                obscureText: !_passVisible,
                decoration: InputDecoration(
                    labelText: "password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                    ),
                    suffixIcon: IconButton(onPressed:(){
                      setState((){
                        _passVisible=!_passVisible;
                      });
                    }, icon: Icon(_passVisible
                        ? Icons.visibility
                        : Icons.visibility_off))
                ),
                validator: _passvalidator
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              if(_keyform.currentState!.validate())
              { SignIn();
                //if the form is valid,execute the login logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing login')),
                );
                // add your login logic here
                //Navigator.pushNamed(context, '/home');
              }
            },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 30,color: Colors.deepOrange),
              ),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: ()
            {
              Navigator.pushNamed(context, "/register");
            }, child: const Text(
              "Register",
              style: TextStyle(fontSize: 30, color: Colors.pink),
            ),)

          ],

        )),),
    );
  }
}
