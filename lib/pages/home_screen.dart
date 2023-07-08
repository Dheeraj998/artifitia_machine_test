import 'dart:convert';

import 'package:artifitia_machine_test/data/controller/main_controller.dart';
import 'package:artifitia_machine_test/helper/custom_print.dart';
import 'package:artifitia_machine_test/model/weather_model.dart';
import 'package:artifitia_machine_test/widgets/fn_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) async {
              final ctr = MainController.instance;

              if (await ctr.box?.get('weather') != null) {
                ctr.weatherData = weatherModelFromJson(ctr.box?.get('wather'));
              }
              if (item == 0) {
                ctr.dataFromLocal =
                    "humidity: ${ctr.weatherData?.current?.humidity.toString()}";
                ctr.update();
              } else if (item == 1) {
                ctr.dataFromLocal =
                    "wind: ${ctr.weatherData?.current?.windKph.toString()}";
                ctr.update();
              } else if (item == 2) {
                ctr.dataFromLocal =
                    "precipitation: ${ctr.weatherData?.current?.precipIn.toString()}";
                ctr.update();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('humidity')),
              PopupMenuItem<int>(value: 1, child: Text('wind')),
              PopupMenuItem<int>(value: 2, child: Text('precipitation')),
            ],
          ),
        ],
      ),
      body: SafeArea(child: GetBuilder<MainController>(builder: (ctr) {
        final WeatherModel? wetherData = ctr.weatherData;
        return ctr.weatherApiResponse.loading == true
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.blue,
              ))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 30),
                      FnText(
                        text: wetherData?.location?.name ?? "",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FnText(
                        text:
                            "${wetherData?.location?.region}, ${wetherData?.location?.country} ",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      SizedBox(height: 20),
                      FnText(
                        text: "${wetherData?.current?.tempC} c",
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/download.png',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FnText(
                                text: "${wetherData?.current?.humidity}",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              FnText(
                                text: "humidity",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FnText(
                                text: "${wetherData?.current?.windKph} kph",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              FnText(
                                text: "wind",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FnText(
                                text: "${wetherData?.current?.precipIn} % ",
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                              FnText(
                                text: "precipitation",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),

                      FnText(
                        text: ctr.dataFromLocal ?? "------------",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              );
      })),
    );
  }
}
