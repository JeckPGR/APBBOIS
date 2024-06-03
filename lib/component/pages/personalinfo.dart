import 'package:flutter/material.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4A1C6F),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/image/profile.png'), // Replace with the actual image asset path
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoRow(
                icon: Icons.phone,
                title: 'Phone Number',
                value: '(62) 877 - 9478 - 0139',
              ),
              _buildInfoRow(
                icon: Icons.email,
                title: 'Email Address',
                value: 'Alyssiaeyy@gmail.com',
              ),
              _buildInfoRow(
                icon: Icons.location_city,
                title: 'Subdistrict',
                value: 'DayeuhKolot',
              ),
              _buildInfoRow(
                icon: Icons.location_on,
                title: 'Location Detail',
                value: 'Jl Sukabirus No. 17 Bandung',
              ),
              _buildInfoRow(
                icon: Icons.school,
                title: 'Education',
                value: 'Bachelor Computer Science',
              ),
              _buildInfoRow(
                icon: Icons.work,
                title: 'Job',
                value: 'Student',
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle change data button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A1C6F), // Button color
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child:const  Text('Change Data', style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF4A1C6F)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
