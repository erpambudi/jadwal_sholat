part of 'sholat_bloc.dart';

abstract class SholatState extends Equatable {
  const SholatState();

  @override
  List<Object> get props => [];
}

class SholatInitial extends SholatState {}

class SholatLoading extends SholatState {}

class SholatHasData extends SholatState {
  final Sholat sholat;

  const SholatHasData(this.sholat);

  @override
  List<Object> get props => [Sholat];
}

class SholatError extends SholatState {
  final String message;

  const SholatError(this.message);

  @override
  List<Object> get props => [message];
}
