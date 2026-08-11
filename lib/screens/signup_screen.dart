import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController =
      TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoading = false;

  // Password visibility
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // PASSWORD VALIDATION
  // ============================================================

  bool hasMinimumLength(String password) {
    return password.length >= 8;
  }

  bool hasUppercase(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  bool hasLowercase(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  bool hasNumber(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  bool hasSpecialCharacter(String password) {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=/\\[\];' + "'" + '`~]')
        .hasMatch(password);
  }

  bool hasNoSpaces(String password) {
    return !password.contains(' ');
  }

  bool isStrongPassword(String password) {
    return hasMinimumLength(password) &&
        hasUppercase(password) &&
        hasLowercase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password) &&
        hasNoSpaces(password);
  }

  // ============================================================
  // CREATE ACCOUNT
  // ============================================================

  Future<void> createAccount() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    // ------------------------------------------------------------
    // BASIC VALIDATION
    // ------------------------------------------------------------

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMessage("Please fill all fields.");
      return;
    }

    // ------------------------------------------------------------
    // EMAIL VALIDATION
    // ------------------------------------------------------------

    if (!RegExp(
      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
    ).hasMatch(email)) {
      showMessage("Please enter a valid email.");
      return;
    }

    // ------------------------------------------------------------
    // STRONG PASSWORD VALIDATION
    // ------------------------------------------------------------

    if (!isStrongPassword(password)) {
      showMessage(
        "Password must meet all the requirements.",
      );
      return;
    }

    // ------------------------------------------------------------
    // CONFIRM PASSWORD
    // ------------------------------------------------------------

    if (password != confirmPassword) {
      showMessage("Passwords do not match.");
      return;
    }

    // ------------------------------------------------------------
    // START LOADING
    // ------------------------------------------------------------

    setState(() {
      isLoading = true;
    });

    // ------------------------------------------------------------
    // CALL BACKEND
    // ------------------------------------------------------------

    final result = await AuthService.signup(
      name: name,
      email: email,
      password: password,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    // ------------------------------------------------------------
    // SUCCESS
    // ------------------------------------------------------------

    if (result["success"] == true) {
      showMessage(
        result["message"] ?? "Account created successfully.",
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }

    // ------------------------------------------------------------
    // ERROR
    // ------------------------------------------------------------

    else {
      showMessage(
        result["message"] ?? "Unable to create account.",
      );
    }
  }

  // ============================================================
  // SHOW MESSAGE
  // ============================================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // PASSWORD REQUIREMENT ROW
  // ============================================================

  Widget passwordRequirement(
    String text,
    bool satisfied,
  ) {
    return Row(
      children: [
        Icon(
          satisfied
              ? Icons.check_circle
              : Icons.cancel,
          size: 18,
          color: satisfied
              ? Colors.green
              : Colors.grey,
        ),

        const SizedBox(width: 8),

        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: satisfied
                ? Colors.green
                : Colors.grey,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final password = passwordController.text;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,

            children: [
              const SizedBox(height: 20),

              // ==================================================
              // ICON
              // ==================================================

              const Icon(
                Icons.school,
                size: 80,
                color: Colors.blue,
              ),

              const SizedBox(height: 10),

              // ==================================================
              // TITLE
              // ==================================================

              const Text(
                "Create your JECTX account",
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Join the All-in-One Student Platform",
                textAlign: TextAlign.center,

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 35),

              // ==================================================
              // FULL NAME
              // ==================================================

              TextField(
                controller: nameController,

                decoration: const InputDecoration(
                  labelText: "Full Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // EMAIL
              // ==================================================

              TextField(
                controller: emailController,

                keyboardType:
                    TextInputType.emailAddress,

                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // PASSWORD
              // ==================================================

              TextField(
                controller: passwordController,

                obscureText: !showPassword,

                onChanged: (value) {
                  setState(() {});
                },

                decoration: InputDecoration(
                  labelText: "Password",

                  prefixIcon: const Icon(
                    Icons.lock,
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        showPassword =
                            !showPassword;
                      });
                    },
                  ),

                  border:
                      const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              // ==================================================
              // PASSWORD REQUIREMENTS
              // ==================================================

              const Text(
                "Password must contain:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              passwordRequirement(
                "At least 8 characters",
                hasMinimumLength(password),
              ),

              const SizedBox(height: 5),

              passwordRequirement(
                "At least one uppercase letter (A-Z)",
                hasUppercase(password),
              ),

              const SizedBox(height: 5),

              passwordRequirement(
                "At least one lowercase letter (a-z)",
                hasLowercase(password),
              ),

              const SizedBox(height: 5),

              passwordRequirement(
                "At least one number (0-9)",
                hasNumber(password),
              ),

              const SizedBox(height: 5),

              passwordRequirement(
                "At least one special character",
                hasSpecialCharacter(password),
              ),

              const SizedBox(height: 5),

              passwordRequirement(
                "No spaces",
                hasNoSpaces(password),
              ),

              const SizedBox(height: 18),

              // ==================================================
              // CONFIRM PASSWORD
              // ==================================================

              TextField(
                controller:
                    confirmPasswordController,

                obscureText:
                    !showConfirmPassword,

                decoration: InputDecoration(
                  labelText: "Confirm Password",

                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),

                  suffixIcon: IconButton(
                    icon: Icon(
                      showConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),

                    onPressed: () {
                      setState(() {
                        showConfirmPassword =
                            !showConfirmPassword;
                      });
                    },
                  ),

                  border:
                      const OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // CREATE ACCOUNT BUTTON
              // ==================================================

              SizedBox(
                height: 55,

                child: ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : createAccount,

                  child: isLoading
                      ? const SizedBox(
                          width: 25,
                          height: 25,

                          child:
                              CircularProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.white,
                          ),
                        )

                      : const Text(
                          "CREATE ACCOUNT",

                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // ==================================================
              // LOGIN
              // ==================================================

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  const Text(
                    "Already have an account? ",
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },

                    child: const Text(
                      "Login",

                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}