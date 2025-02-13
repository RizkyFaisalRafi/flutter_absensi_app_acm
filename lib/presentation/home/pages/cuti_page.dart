import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absensi_app_acm/data/datasources/auth_local_datasource.dart';
import 'package:flutter_absensi_app_acm/presentation/auth/bloc/login/login_bloc.dart';
import 'package:flutter_absensi_app_acm/presentation/auth/bloc/user/user_bloc.dart';
import 'package:flutter_absensi_app_acm/presentation/home/bloc/add_cuti/add_cuti_bloc.dart';
// import 'package:flutter_absensi_app_acm/presentation/home/bloc/add_permission/add_permission_bloc.dart';
import 'package:flutter_absensi_app_acm/presentation/home/bloc/add_permissions/add_permissions_bloc.dart';
import 'package:flutter_absensi_app_acm/presentation/home/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../core/components/custom_date_picker.dart';
import '../../../core/core.dart';

class CutiPage extends StatefulWidget {
  const CutiPage({super.key});

  @override
  State<CutiPage> createState() => CutiPageState();
}

class CutiPageState extends State<CutiPage> {
  String? imagePath;
  late final TextEditingController dateController;
  late final TextEditingController reasonController;

  @override
  void initState() {
    dateController = TextEditingController();
    reasonController = TextEditingController();
    context.read<UserBloc>().add(const UserEvent.getUser());
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      if (pickedFile != null) {
        imagePath = pickedFile.path;
      } else {
        debugPrint('No file selected.');
      }
    });
  }

  String formatDate(DateTime date) {
    // Gunakan DateFormat untuk mengatur format tanggal
    final dateFormatter = DateFormat('yyyy-MM-dd');
    // Kembalikan tanggal dalam format yang dinginkan
    return dateFormatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuti'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          // Cuti
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (data) {
                  return Text(
                    'Sisa Cuti: ${data.cuti ?? '0'} Cuti', // Jika data kosong, tampilkan 0
                  );
                },
                orElse: () {
                  return const Column(
                    children: [
                      Text('Terjadi Error'),
                    ],
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (message) => Center(
                  child: Text(message),
                ),
              );
            },
          ),

          CustomDatePicker(
            label: 'Tanggal',
            onDateSelected: (selectedDate) =>
                dateController.text = formatDate(selectedDate).toString(),
          ),
          const SpaceHeight(16.0),
          CustomTextField(
            controller: reasonController,
            label: 'Keperluan',
            maxLines: 5,
          ),
          const SpaceHeight(26.0),

          // Lampiran
          // Padding(
          //   padding: EdgeInsets.only(right: context.deviceWidth / 2),
          //   child: GestureDetector(
          //     onTap: _pickImage,
          //     child: imagePath == null
          //         ? DottedBorder(
          //             borderType: BorderType.RRect,
          //             color: Colors.grey,
          //             radius: const Radius.circular(18.0),
          //             dashPattern: const [8, 4],
          //             child: Center(
          //               child: SizedBox(
          //                 height: 120.0,
          //                 child: Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Assets.icons.image.svg(),
          //                     const SpaceHeight(18.0),
          //                     const Text('Lampiran'),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           )
          //         : ClipRRect(
          //             borderRadius: const BorderRadius.all(
          //               Radius.circular(18.0),
          //             ),
          //             child: Image.file(
          //               File(imagePath!),
          //               height: 120.0,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //   ),
          // ),

          const SpaceHeight(65.0),

          // Button Kirim Permintaan
          BlocConsumer<AddCutiBloc, AddCutiState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: AppColors.red,
                    ),
                  );
                },
                success: () {
                  dateController.clear();
                  reasonController.clear();
                  setState(() {
                    imagePath = null;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Submit Cuti success'),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                  context.pushReplacement(const MainPage());
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      final image =
                          imagePath != null ? XFile(imagePath!) : null;
                      context.read<AddCutiBloc>().add(
                            AddCutiEvent.addPermission(
                              date: dateController.text,
                              reason: reasonController.text,
                              // image: image!,
                            ),
                          );
                    },
                    label: 'Kirim Permintaan Cuti',
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
