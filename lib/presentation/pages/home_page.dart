import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jadwal_sholat/common/constants/app_values.dart';
import 'package:jadwal_sholat/common/constants/constants.dart';
import 'package:jadwal_sholat/common/styles/app_colors.dart';
import 'package:jadwal_sholat/common/styles/app_text_styles.dart';
import 'package:jadwal_sholat/core/config/scheduler_adzan.dart';
import 'package:jadwal_sholat/domain/entities/sholat.dart';
import 'package:jadwal_sholat/presentation/bloc/sholat_bloc.dart';
import 'package:jadwal_sholat/presentation/widgets/home_shimmer.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void registerSholatSchedule() async {
    await AndroidAlarmManager.periodic(
      const Duration(hours: 1),
      0,
      BackgroundService.callbackRegisterAlarm,
      startAt: DateTime.now(),
      exact: true,
      wakeup: true,
    );
  }

  @override
  void initState() {
    registerSholatSchedule();

    context
        .read<SholatBloc>()
        .add(GetSholatScheduleEvent(idCity, DateTime.now()));

    super.initState();
  }

  Widget header(Sholat sholat) {
    return SliverLayoutBuilder(
      builder: (context, constraints) {
        final scrolled = constraints.scrollOffset > 0;
        return SliverAppBar(
          pinned: true,
          backgroundColor: AppColors.white,
          expandedHeight: 300,
          title: Text(
            "Jadwal Sholat Hari Ini",
            style: AppTextStyle.appBarTitle.copyWith(
              color: scrolled ? AppColors.black : AppColors.white,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: SizedBox(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/image_masjid.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sholat.lokasi,
                          style: AppTextStyle.whiteTitle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          sholat.daerah,
                          style: AppTextStyle.subtitleWhite,
                        ),
                        Text(
                          sholat.jadwal.tanggal,
                          style: AppTextStyle.subtitleWhite.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget sholatItem(String type, String time) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppValues.margin_20,
        AppValues.marginZero,
        AppValues.margin_20,
        AppValues.margin_12,
      ),
      padding: const EdgeInsets.all(
        AppValues.padding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              type,
              textAlign: TextAlign.start,
              style: AppTextStyle.brand,
            ),
          ),
          Expanded(
            child: Text(
              time,
              textAlign: TextAlign.end,
              style: AppTextStyle.title.copyWith(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<SholatBloc>()
              .add(GetSholatScheduleEvent(idCity, DateTime.now()));
        },
        child: BlocBuilder<SholatBloc, SholatState>(
          builder: (context, state) {
            if (state is SholatHasData) {
              final sholat = state.sholat;

              return CustomScrollView(
                slivers: [
                  header(sholat),
                  SliverToBoxAdapter(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: AppValues.margin_30,
                      ),
                      child: Column(
                        children: [
                          sholatItem("Subuh", sholat.jadwal.subuh),
                          sholatItem("Dzuhur", sholat.jadwal.dzuhur),
                          sholatItem("Ashar", sholat.jadwal.ashar),
                          sholatItem("Maghrib", sholat.jadwal.maghrib),
                          sholatItem("Isya", sholat.jadwal.isya),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }

            return const HomeShimmer();
          },
        ),
      ),
    );
  }
}
