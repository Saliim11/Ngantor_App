import 'package:flutter/material.dart';
import 'package:ngantor/pages/auth_pages/register/widgets/expandable_tile.dart';
import 'package:ngantor/services/providers/widget_provider.dart';
import 'package:ngantor/services/providers/auth_provider.dart';
import 'package:ngantor/utils/colors/app_colors.dart';
import 'package:ngantor/utils/styles/app_btn_style.dart';
import 'package:ngantor/utils/widgets/dialog.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProv = Provider.of<AuthProvider>(context);

    // bool _isloading = authProv.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Daftar Akun'),
        centerTitle: true,
        elevation: 0,
        foregroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            buildExpandableField(
              context,
              index: 0,
              label: 'Username',
              icon: Icons.person_outline,
              controller: _usernameController,
              isFilled: context.watch<WidgetProvider>().isFilledUsername
            ),
            buildExpandableField(
              context,
              index: 1,
              label: 'Email',
              icon: Icons.email_outlined,
              controller: _emailController,
              isFilled: context.watch<WidgetProvider>().isFilledEmail
            ),
            buildExpandableField(
              context,
              index: 2,
              label: 'Password',
              icon: Icons.lock_outline,
              controller: _passwordController,
              isFilled: context.watch<WidgetProvider>().isFilledPassword,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                CustomDialog().loading(context);
                await authProv.registerUser(context, name: _usernameController.text, email: _emailController.text, password: _passwordController.text);
              },
              style: AppBtnStyle.normal,
              child: const Center(
                child: Text(
                  'Daftar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah punya akun?", style: TextStyle(color: AppColors.textSecondary)),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/login");
                  }, 
                  child: Text("Login Sekarang", style: TextStyle(color: AppColors.accent, fontWeight: FontWeight.bold))
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}