import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';
import '../widgets/page_header.dart';
import '../widgets/status_text.dart';

/// Form Data Pengguna (BAB 6): dua input tervalidasi, SnackBar, dan teks status.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: AuthService.currentName ?? '');
  final TextEditingController _emailController =
      TextEditingController(text: AuthService.currentEmail ?? '');

  String _statusMessage = 'Belum ada data yang diproses';
  bool _isError = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      setState(() {
        _statusMessage = 'Periksa kembali input yang belum valid';
        _isError = true;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Input belum valid')),
        );
      }
      return;
    }

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final ok = AuthService.updateProfile(name, email);
    if (!ok) {
      setState(() {
        _statusMessage = 'Email sudah dipakai akun lain';
        _isError = true;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sudah dipakai akun lain')),
        );
      }
      return;
    }

    setState(() {
      _statusMessage = 'Data valid: $name ($email)';
      _isError = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil diproses')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return HeaderScaffold(
      title: 'Profil Saya',
      subtitle: 'Perbarui nama dan email akunmu.',
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Nama',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: Validators.name,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: Validators.email,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitForm,
                child: const Text('Simpan'),
              ),
            ),
            const SizedBox(height: 14),
            Text(_statusMessage,
                style: TextStyle(
                    color: _isError ? Colors.red : Colors.black54,
                    fontSize: 13.5)),
          ],
        ),
      ),
    );
  }
}
