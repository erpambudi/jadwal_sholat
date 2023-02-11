import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jadwal_sholat/domain/entities/sholat.dart';
import 'package:jadwal_sholat/domain/usecases/get_sholat_schedule.dart';

part 'sholat_event.dart';
part 'sholat_state.dart';

class SholatBloc extends Bloc<SholatEvent, SholatState> {
  final GetSholatSchedule _getSholatSchedule;

  SholatBloc(this._getSholatSchedule) : super(SholatInitial()) {
    on<GetSholatScheduleEvent>((event, emit) async {
      emit(SholatLoading());

      String date = "${event.date.year}/${event.date.month}/${event.date.day}";

      final result = await _getSholatSchedule.execute(event.idCity, date);

      result.fold((failure) {
        emit(SholatError(failure.message));
      }, (data) {
        emit(SholatHasData(data));
      });
    });
  }
}
