part of 'sholat_bloc.dart';

abstract class SholatEvent extends Equatable {
  const SholatEvent();

  @override
  List<Object> get props => [];
}

class GetSholatScheduleEvent extends SholatEvent {
  final String idCity;
  final DateTime date;

  const GetSholatScheduleEvent(this.idCity, this.date);

  @override
  List<Object> get props => [idCity, date];
}
