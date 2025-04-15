import 'package:flutter/material.dart';
import 'package:ngantor/services/providers/auth_provider.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/styles/app_btn_style.dart';
import 'package:ngantor/utils/widgets/dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);

    TextEditingController _emailC = new TextEditingController();
    TextEditingController _passwordC = new TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo atau Judul
              Column(
                children: [
                  Icon(Icons.business_center, size: 64, color: AppColors.primary),
                  const SizedBox(height: 8),
                  Text(
                    'Ngantor',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Email
              TextField(
                controller: _emailC,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordC,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 8),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Lupa Password?',
                    style: TextStyle(color: AppColors.accent),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Tombol Login
              ElevatedButton(
                onPressed: () async{
                  CustomDialog().loading(context);
                  await authProv.loginUser(context, email: _emailC.text, password: _passwordC.text);
                  
                },
                style: AppBtnStyle.normal,
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text('atau'),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 16),

              // Button ke Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun?", style: TextStyle(color: AppColors.textSecondary)),
                  TextButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, "/register"), 
                    child: Text("Daftar Sekarang", style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold))
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}