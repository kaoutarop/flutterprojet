import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage> {
  final _keyForm = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();
  final TextEditingController _passvalidationcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _passVisible = false;
  // Fonction pour l'inscription (SignUp)
  Future<void> SignUp() async {
    try {
      // Créer l'utilisateur avec FirebaseAuth
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passcontroller.text.trim(),
      );
      // Vérification si l'utilisateur est créé avec succès
      if (userCredential.user != null) {
        // Redirection vers la page de connexion
        Navigator.pushReplacementNamed(context, '/login');
        Fluttertoast.showToast(msg: "Inscription réussie. Connectez-vous !");
      }
    } on FirebaseAuthException catch (e) {
      // Gestion des erreurs FirebaseAuth
      if (e.code.contains("weak-password")) {
        Fluttertoast.showToast(
            msg: "Votre mot de passe doit contenir au moins 6 caractères.");
      } else if (e.code.contains("invalid-email")) {
        Fluttertoast.showToast(
            msg: "Votre email n'a pas un format valide.");
      } else if (e.code.contains("email-already-in-use")) {
        Fluttertoast.showToast(
            msg: "Cette adresse mail est déjà utilisée.");
      } else {
        Fluttertoast.showToast(msg: "Erreur: ${e.message}");
      }
      print(e); // Affiche les erreurs dans la console
    } catch (e) {
      // Autres erreurs
      Fluttertoast.showToast(msg: "Une erreur est survenue: ${e.toString()}");
      print(e);
    }
  }
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
  String? _validateConfirmPassword(String? value){
    if(value == null || value.isEmpty){
      return 'Please confirm your password';
    }
    if(value != _passcontroller.text){
      return '¨Passwords do not match';
    }
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page ',
          style: TextStyle(color: Colors.white,fontSize: 60),),backgroundColor: Colors.blueGrey,

      ),
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(key:_keyForm,child: Column(
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
                controller: _emailcontroller,
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
                controller: _passcontroller,
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
            TextFormField(
                controller: _passvalidationcontroller,
                obscureText: !_passVisible,
                decoration: InputDecoration(
                    labelText: "same password",
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
            ElevatedButton(onPressed: (){
              if(_keyForm.currentState!.validate())
              {
                SignUp();//if the form is valid,execute the login logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Register !')),
                );
                // add your login logic here
                Navigator.pushNamed(context, '/login');
              }
            },
              child: Text(
                "Register",
                style: TextStyle(fontSize: 30,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.teal,
              ),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: ()
            {
              Navigator.pushNamed(context, "/login");
            }, child: const Text(
              "Already have an account? login here",
              style: TextStyle(fontSize: 30, color: Colors.pink),
            ),)

          ],

        )),),
    );
  }
}
