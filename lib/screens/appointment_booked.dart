import 'package:flutter/material.dart';
import 'package:hello_doctor/components/button.dart';
import 'package:lottie/lottie.dart';

class AppointmentBooked extends StatefulWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  State<AppointmentBooked> createState() => _AppointmentBookedState();
}

class _AppointmentBookedState extends State<AppointmentBooked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Lottie.asset('assets/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const Spacer(),
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 15,
                ),
                child: Button(
                  width: double.infinity,
                  title: 'Back to Home Page',
                  onPressed: () => Navigator.of(context).pushNamed('main'),
                  disable: false,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
