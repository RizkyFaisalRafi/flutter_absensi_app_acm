import 'package:camera/camera.dart';
import 'package:flutter_absensi_app_acm/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_absensi_app_acm/data/models/response/user_response_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_register_face_event.dart';
part 'update_user_register_face_state.dart';
part 'update_user_register_face_bloc.freezed.dart';

class UpdateUserRegisterFaceBloc
    extends Bloc<UpdateUserRegisterFaceEvent, UpdateUserRegisterFaceState> {
  final AuthRemoteDatasource authRemoteDatasource;
  UpdateUserRegisterFaceBloc(this.authRemoteDatasource)
      : super(const _Initial()) {
    //
    on<_UpdateProfileRegisterFace>((event, emit) async {
      emit(const _Loading());
      try {
        final user = await authRemoteDatasource.updateProfileRegisterFace(
          event.embedding,
          // event.image,
        );
        user.fold(
          (l) => emit(_Error(l)),
          (r) => emit(_Success(r)),
        );
      } catch (e) {
        emit(_Error(e.toString()));
      }
    });
  }
}
