import 'package:equatable/equatable.dart';

abstract class QrState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QrInitial extends QrState {}

class QrLoading extends QrState {}

class QrSuccess extends QrState {
  final String message;

  QrSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class QrFailure extends QrState {
  final String error;

  QrFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
