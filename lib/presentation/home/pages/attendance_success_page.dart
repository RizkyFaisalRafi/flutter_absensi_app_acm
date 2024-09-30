// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_absensi_app_acm/presentation/home/bloc/is_checked_in/is_checked_in_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';

class AttendanceSuccessPage extends StatelessWidget {
  final String status;
  const AttendanceSuccessPage({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.success.image(),
            const Text(
              'Sukses!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SpaceHeight(8.0),
            Center(
              child: Text(
                'Anda telah melakukan Absensi $status Pukul ${DateTime.now().toFormattedTime()}. Selamat $status ',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: AppColors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SpaceHeight(80.0),
            Button.filled(
              onPressed: () {
                context
                    .read<IsCheckedInBloc>()
                    .add(const IsCheckedInEvent.isCheckedIn());
                context.popToRoot();
              },
              label: 'Oke, dimengerti',
            ),
          ],
        ),
      ),
    );
  }
}
