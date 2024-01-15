import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isObscure = true;
  bool _isFieldsEmpty = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isRepeatPasswordValid = false;
  bool _isPasswordsEqual = true;

  @override
  void initState() {
    super.initState();
    _isFieldsEmpty = true;

    _isEmailValid = false;
    _isPasswordValid = false;
    _isRepeatPasswordValid = false;
    _isPasswordsEqual = true;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  void _updateButtonState() {
    setState(() {
      // Enable the button only if all three fields are non-empty
      _isFieldsEmpty =
          !_isEmailValid || !_isPasswordValid || !_isRepeatPasswordValid;
    });
  }

  void _checkPasswords() {
    setState(() {
      _isPasswordsEqual =
          _passwordController.text == _repeatPasswordController.text;
    });
    if (_isPasswordsEqual) {
      Navigator.pushNamed(context, '/signUpCongratulation');
    }
  }

  final TextStyle errorTextStyle = const TextStyle(
    color: Colors.red, // Set the color you prefer for error text
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeyboardDismissOnTap(
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Stack(children: [
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, top: 85.0),
                            child: Image.asset(
                              'assets/images/logo.png',
                              width: 150,
                              height: 98,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              // border: Border.all(color: _isErrorVisible ? Colors.red : Colors.transparent),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.09000000357627869),
                                  offset: Offset(1, 3),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              maxLength: 25,
                              decoration: InputDecoration(
                                counterText: '',
                                hintText: 'Enter your email',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Image.asset(
                                    'assets/images/mail.png',
                                    width: 20),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _isEmailValid = value.isNotEmpty;
                                });
                                _updateButtonState();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isFieldsEmpty = true;
                                  });
                                }

                                // Add more validation logic if needed
                                return null;
                              },
                              controller: _emailController,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                  color: !_isPasswordsEqual
                                      ? Colors.red
                                      : Colors.transparent),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.09000000357627869),
                                  offset: Offset(1, 3),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              maxLength: 25,
                              obscureText: _isObscure,
                              onChanged: (value) {
                                setState(() {
                                  _isPasswordValid = value.isNotEmpty;
                                });
                                _updateButtonState();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  setState(() {
                                    _isFieldsEmpty = true;
                                  });
                                }

                                // Add more validation logic if needed
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Image.asset(
                                  'assets/images/lock.png',
                                  width: 20,
                                ),
                                counterText: '',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  iconSize: 25,
                                ),
                              ),
                              controller: _passwordController,
                            ),
                          ),
                        ),
                        if (!_isPasswordsEqual)
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0, left: 35),
                            child: Text(
                              'passwords is not equal',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        SizedBox(height: !_isPasswordsEqual ? 4 : 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              border: Border.all(
                                  color: !_isPasswordsEqual
                                      ? Colors.red
                                      : Colors.transparent),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.09000000357627869),
                                  offset: Offset(1, 3),
                                  blurRadius: 9,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _isRepeatPasswordValid = value.isNotEmpty;
                                });

                                _updateButtonState();
                              },
                              maxLength: 25,
                              obscureText: _isObscure,
                              validator: (value) {
                                // Add more validation logic if needed
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Repeat your password',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Image.asset(
                                  'assets/images/lock.png',
                                  width: 20,
                                ),
                                counterText: '',
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                  iconSize: 25,
                                ),
                              ),
                              controller: _repeatPasswordController,
                            ),
                          ),
                        ),
                        if (!_isPasswordsEqual)
                          const Padding(
                            padding: EdgeInsets.only(top: 4.0, left: 35),
                            child: Text(
                              'passwords is not equal',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: !_isPasswordsEqual ? 4 : 24),
                  GestureDetector(
                    onTap: _isFieldsEmpty
                        ? () {
                            if (_formKey.currentState?.validate() ?? false) {}
                          }
                        : () {
                            _checkPasswords();
                          },
                    child: Container(
                      constraints: const BoxConstraints(
                        maxHeight: 52,
                        maxWidth: 335,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        gradient: LinearGradient(
                          begin: const Alignment(0.0, -1.0),
                          end: const Alignment(1.0, 1.0),
                          colors: [
                            _isFieldsEmpty
                                ? Colors.grey
                                : const Color(0xFF59A7A7),
                            _isFieldsEmpty
                                ? Colors.grey
                                : const Color(0xFFAFCD6D)
                          ],
                          stops: const [0.0, 1.0],
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontFamily: 'Gilroy',
                            fontSize: 16,
                            letterSpacing: 0,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  KeyboardVisibilityBuilder(builder: (context, visible) {
                    return Column(
                      children: <Widget>[
                        Visibility(
                          visible: !visible,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Text(
                                    'Already have an account ?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(36, 36, 36, 1),
                                        fontFamily: 'Gilroy',
                                        fontSize: 16,
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.normal,
                                        height: 1),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: const Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      'Log in',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(89, 167, 167, 1),
                                          fontFamily: 'Gilroy',
                                          fontSize: 16,
                                          letterSpacing: 0,
                                          fontWeight: FontWeight.normal,
                                          height: 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}