import 'package:flutter/material.dart';
import 'package:go_volunteer/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String email = '';
  String password = '';
  String confirmPassword = '';

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isAgreedTerms = false;
  String errorText = '';
  String passwordStrength = '';
  String emailValidator = '';
  String passwordLength = '';

  final RegExp emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false,
    multiLine: false,
  );

  void onSignUpButtonHandler() {
    setState(() {
      email = emailController.text;
      password = passwordController.text;
      confirmPassword = confirmPasswordController.text;
      emailValidator = '';
      passwordLength = '';
      errorText = '';
    });

    try {
      if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty || !_isAgreedTerms) {
        setState(() {
          errorText = 'All fields must be filled and agreed to the terms';
        });
        return;
      }

      if (password != confirmPassword) {
        setState(() {
          errorText = 'Password and confirm password must be the same';
        });
        return;
      }

      if (!emailRegex.hasMatch(email)) {
        setState(() {
          emailValidator = 'Invalid Email';
        });
      }

      if (password.length < 8) {
        setState(() {
          passwordLength = 'Password length should be greater than 8';
        });
      }

      if (emailValidator.isEmpty && passwordLength.isEmpty) {
        setState(() {
          emailController.clear();
          passwordController.clear();
          confirmPasswordController.clear();
          errorText = '';
          passwordStrength = '';
          _isAgreedTerms = false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (builder) => Login()));
      }
    } catch (e) {
      print(e);
    }
  }

  void updatePasswordStrength(String password) {
    if (password.isEmpty) {
      setState(() {
        passwordStrength = '';
      });
      return;
    }

    bool hasNumber = password.contains(RegExp(r'\d'));
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (password.length >= 8 && hasNumber && hasLetter && hasSpecialCharacters) {
      setState(() {
        passwordStrength = 'Strong';
      });
    } else if (password.length >= 8 && (hasNumber || hasLetter)) {
      setState(() {
        passwordStrength = 'Medium';
      });
    } else {
      setState(() {
        passwordStrength = 'Weak';
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Email Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your email address',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
             Padding(padding: EdgeInsets.only(left: 20.0,bottom: 5.0),
              child: Text(emailValidator,style: TextStyle(color: Colors.red),) ,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    updatePasswordStrength(value);
                  },
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    suffixText: passwordStrength.isNotEmpty
                        ? '($passwordStrength)'
                        : '',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 20.0,bottom: 5.0),
              child: Text(passwordLength,style: TextStyle(color: Colors.red),) ,),
              
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Confirm Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Enter your password again',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30.0),
                child: Text(
                  errorText,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    fillColor: MaterialStateProperty.all(Color(0xFF04BF68)),
                    value: _isAgreedTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAgreedTerms = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAgreedTerms = !_isAgreedTerms;
                        });
                      },
                      child: Text(
                        "I've read and agreed with User Agreement and Privacy Policy",
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, top: 5.0, bottom: 5.0),
                child: Row(
                  children: [
                    Text(
                      'Already have an account ? ',
                      style: TextStyle(color: Colors.grey),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) => Login()));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: onSignUpButtonHandler,
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF04BF68),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.all(20.0),
                      ),
                      child: Text('Signup'),
                    )),
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text('Other ways to signup'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFFFFFFF),
                            radius: 25,
                            child: Image.asset(
                              'assets/images/google-icon.png',
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFFFFFFF),
                            radius: 25,
                            child: Image.asset(
                              'assets/images/facebook-icon.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}