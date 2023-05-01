import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello_doctor/components/button.dart';
import 'package:hello_doctor/components/custom_appbar.dart';
import 'package:hello_doctor/utils/config.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _idWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: const CustomAppBar(
        appTitle: 'Appointment',
        icon: FaIcon(Icons.arrow_back_ios),
      ),
      body: CustomScrollView(
        slivers: <Widget> [
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                _tableCalender(),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 25,
                  ),
                  child: Center(
                    child: Text(
                      'Select Consultation Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          _idWeekend
          ? SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
              alignment: Alignment.center,
              child: const Text(
                'Weekend is not available, please select another date',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Config.primaryColor
                ),
              ),
            ),
          )
              : SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    // when selected, update current index and set time selected to true
                    _currentIndex = index;
                    _timeSelected = true;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: _currentIndex == index
                          ? Colors.white
                          : Colors.black
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: _currentIndex == index
                      ? Config.primaryColor
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${index + 9}:00 ${index + 9 > 11 ? "PM": "AM"}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _currentIndex == index
                          ? Colors.white
                          : null,
                    ),
                  ),
                ),
              );
            },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.5
            )
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 80,
              ),
              child: Button(
                width: double.infinity,
                title: 'Make Appointment',
                onPressed: () {
                  Navigator.of(context).pushNamed('success_booking');
                },
                disable: _timeSelected && _dateSelected
                ? false
                : true,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tableCalender() {
    return TableCalendar(
        focusedDay: _focusDay,
        firstDay: DateTime.now(),
        lastDay: DateTime(2023, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      rowHeight: 48,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Config.primaryColor,
          shape: BoxShape.circle
        ),
      ),
      availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
      },
      onFormatChanged: (format) {
          setState(() {
            _format = format;
          });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _dateSelected = true;

          if(selectedDay.weekday == 6 || selectedDay.weekday == 7) {
            _idWeekend = true;
            _timeSelected = false;
            _currentIndex = null;
          } else {
            _idWeekend = false;
          }
        });
      }),
    );
  }
}
