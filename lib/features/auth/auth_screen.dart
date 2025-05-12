import 'package:circular_chem_app/core/models/category_enum.dart';
import 'package:circular_chem_app/features/auth/controllers/auth_controller.dart';
import 'package:circular_chem_app/features/auth/services/auth_service.dart';
import 'package:circular_chem_app/features/auth/widgets/auth_button.dart';
import 'package:circular_chem_app/features/auth/widgets/auth_field.dart';
import 'package:circular_chem_app/features/auth/widgets/category_dropdown.dart';
import 'package:circular_chem_app/features/auth/widgets/grey_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final _emailController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _taxRegistryController = TextEditingController();
  final authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    CategoryType? industry;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              // **Title Widget**
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 26.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to CircularChem",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .green[600], // A deep green for "CircularChem"
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Where recycling waste is at your fingertips!",
                      style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color:
                            Colors.grey[600], // A softer grey for the tagline
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // **End of Title Widget**
              Obx(() {
                return !authController.isLogin.value
                    ? AuthField(
                        controller: _companyNameController,
                        labelText: 'Company Name',
                        prefixIcon: Icon(Icons.business),
                        validation: emptyValidation,
                      )
                    : SizedBox();
              }),
              Obx(() {
                return !authController.isLogin.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CategoryDropdown(
                          width: screenWidth,
                          onChanged: (chosenIndustry) {
                            industry = chosenIndustry!;
                            print('Chosen industry is $industry');
                          },
                          labelText: 'Industry Type',
                        ),
                      )
                    : SizedBox();
              }),
              Obx(() {
                return !authController.isLogin.value
                    ? AuthField(
                        controller: _taxRegistryController,
                        labelText: 'Tax Registration No.',
                        hintText: '000000000',
                        prefixIcon: Icon(Icons.assignment),
                        validation: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a tax registration number';
                          }
                          final regex = RegExp(r'^\d{9}$');
                          if (!regex.hasMatch(value)) {
                            return 'Tax registration number must be exactly 9 digits';
                          }
                          return null;
                        },
                      )
                    : SizedBox();
              }),
              AuthField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              Obx(() {
                return AuthField(
                  controller: _passwordController,
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  obscureText: authController.isObscured.value,
                  postfixIcon: IconButton(
                    icon: Icon(authController.isObscured.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () => authController.toggleObscured(),
                  ),
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6)
                      return 'Password must be at least 6 characters';
                    return null;
                  },
                );
              }),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GreyTextButton(
                    onPressed: () {},
                    text: 'Forgot Password?',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Obx(() {
                  return Center(
                    child: AuthButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (industry == null &&
                              !authController.isLogin.value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please choose an industry')));
                            return;
                          }
                          // Manually validate the form
                          try {
                            if (!authController.isLogin.value) {
                              // Registration logic
                              await AuthService(FirebaseAuth.instance)
                                  .createAccount(
                                email: _emailController.text,
                                password: _passwordController.text,
                                companyName: _companyNameController.text,
                                taxRegistryNumber: _taxRegistryController.text,
                                industry: industry!,
                              );
                            } else {
                              // Login logic
                              await AuthService(FirebaseAuth.instance)
                                  .loginWithEmailAndPassword(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            print('error code is: ${e.code}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          } catch (e) {
                            print('error code is: ${e.toString()}');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        }
                      },
                      text: authController.isLogin.value ? 'Login' : 'Sign Up',
                      width: screenWidth * 0.8,
                    ),
                  );
                }),
              ),
              Obx(() {
                return GreyTextButton(
                  onPressed: () {
                    authController.toggleMode();
                    _emailController.clear();
                    _passwordController.clear();
                    _companyNameController.clear();
                    _taxRegistryController.clear();
                    industry = null;
                    authController.isObscured.value = true;
                  },
                  text: authController.isLogin.value
                      ? 'No account yet? Register now!'
                      : 'Already have an account? Login now!',
                );
              })
            ],
          ),
        ),
      ),
    );
  }

  String? emptyValidation(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }
}
