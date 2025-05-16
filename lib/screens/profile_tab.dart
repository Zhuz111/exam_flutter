import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final user = FirebaseAuth.instance.currentUser!;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = user.displayName ?? '';
  }

  Future<void> _updateProfile() async {
    await user.updateDisplayName(_nameController.text.trim());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Профиль обновлен')));
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Имя пользователя'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _updateProfile, child: const Text('Сохранить')),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Выйти из аккаунта'),
          ),
        ],
      ),
    );
  }
}