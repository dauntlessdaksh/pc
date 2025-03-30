import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class QrEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UploadQrImageEvent extends QrEvent {
  final XFile image;

  UploadQrImageEvent({required this.image});

  @override
  List<Object?> get props => [image];
}
