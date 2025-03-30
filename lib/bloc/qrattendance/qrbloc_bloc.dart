import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pc/bloc/qrattendance/qrbloc_event.dart';
import 'package:pc/bloc/qrattendance/qrbloc_state.dart';
import 'package:pc/repository/qrattendance_repository.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  final QrRepository repository;

  QrBloc({required this.repository}) : super(QrInitial()) {
    on<UploadQrImageEvent>(_onUploadQrImage);
  }

  Future<void> _onUploadQrImage(
    UploadQrImageEvent event,
    Emitter<QrState> emit,
  ) async {
    emit(QrLoading());
    try {
      final response = await repository.uploadQrImage(event.image);
      emit(QrSuccess(message: response.message));
    } catch (e) {
      emit(QrFailure(error: 'Error: ${e.toString()}'));
    }
  }
}
