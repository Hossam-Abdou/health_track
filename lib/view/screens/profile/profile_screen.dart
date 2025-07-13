// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../view_models/health_cubit.dart';
// import '../../view_models/health_state.dart';
// import '../widgets/profile_option_tile.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Load profile when screen is first accessed
//     context.read<HealthCubit>().loadProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<HealthCubit, HealthState>(
//       listener: (context, state) {
//         if (state is AddProfileErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('❌ Error adding profile: ${state.error}'),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 3),
//             ),
//           );
//         } else if (state is UpdateProfileErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('❌ Error updating profile: ${state.error}'),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 3),
//             ),
//           );
//         } else if (state is ProfileErrorState) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('❌ Error loading profile: ${state.error}'),
//               backgroundColor: Colors.red,
//               duration: const Duration(seconds: 3),
//             ),
//           );
//         }
//       },
//       child: BlocBuilder<HealthCubit, HealthState>(
//         builder: (context, state) {
//           if (state is ProfileLoadingState) {
//             return const Scaffold(
//               body: Center(child: CircularProgressIndicator()),
//             );
//           } else if (state is ProfileSuccessState) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: const Text('Profile'),
//                 centerTitle: true,
//               ),
//               body: Column(
//                 children: [
//                   const SizedBox(height: 32),
//                   CircleAvatar(
//                     radius: 40,
//                     backgroundImage: NetworkImage(state.profile.avatarUrl),
//                     onBackgroundImageError: (exception, stackTrace) {
//                       // Handle image loading error
//                     },
//                   ),
//                   const SizedBox(height: 12),
//                   Text(state.profile.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//                   Text(state.profile.email, style: const TextStyle(color: Colors.grey)),
//                   const SizedBox(height: 24),
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         ProfileOptionTile(
//                           icon: Icons.person,
//                           title: 'Personal Info',
//                           onTap: () => Navigator.pushNamed(context, '/personal_info'),
//                         ),
//                         ProfileOptionTile(
//                           icon: Icons.settings,
//                           title: 'Settings',
//                           onTap: () {},
//                         ),
//                         ProfileOptionTile(
//                           icon: Icons.info,
//                           title: 'About App',
//                           onTap: () {},
//                         ),
//                         ProfileOptionTile(
//                           icon: Icons.logout,
//                           title: 'Logout',
//                           onTap: () {},
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return const Scaffold(
//               body: Center(
//                 child: Text('Something went wrong'),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }