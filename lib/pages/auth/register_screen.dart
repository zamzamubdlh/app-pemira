import 'package:flutter/material.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final editName = TextEditingController();
  final editEmail = TextEditingController();
  final editPhone = TextEditingController();
  final editPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DView.height(80),
            Image.asset(
              'assets/logo.png', // Ganti dengan path/logo sesuai proyek Anda
              height: 120,
              width: 120,
            ),
            DView.height(16),
            const Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            DView.height(16),
            DInput(
              label: 'Nama',
              hint: 'Masukkan Nama Anda',
              controller: editName,
              // prefixIcon: Icons.person,
            ),
            DView.height(8),
            DInput(
              label: 'Email',
              hint: 'Masukkan Email Anda',
              controller: editEmail,
              // prefixIcon: Icons.email,
            ),
            DView.height(8),
            DInput(
              label: 'No. Telpon',
              hint: 'Masukkan No. Telpon Anda',
              controller: editPhone,
              // prefixIcon: Icons.phone,
            ),
            DView.height(8),
            DInputPassword(
              label: 'Password',
              hint: 'Masukkan Password Anda',
              controller: editPassword,
              // prefixIcon: Icons.lock,
            ),
            DView.height(16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk membuat akun
              },
              child: const Text('Create Account'),
            ),
            DView.height(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Sudah punya akun?'),
                DView.height(4),
                InkWell(
                  onTap: () {
                    // Tambahkan navigasi ke halaman login
                  },
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
