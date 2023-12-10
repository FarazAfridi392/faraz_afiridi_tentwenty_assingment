import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tentwenty_movie_app/theme/light_theme.dart';

import 'package:tentwenty_movie_app/util/styles.dart';

class MovieSeatSelectionScreen extends StatefulWidget {
  @override
  _MovieSeatSelectionScreenState createState() =>
      _MovieSeatSelectionScreenState();
}

class _MovieSeatSelectionScreenState extends State<MovieSeatSelectionScreen> {
  int _selectedDateIndex = 0;
  final List<String> _dates = ['5 Mar', '6 Mar', '7 Mar', '8 Mar', '9 Mar'];
  final List<String> _times = ['12:30', '13:30'];
  final List<int> _prices = [50, 75];
  final List<int> _bonuses = [2500, 3000]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: poppinsMedium.color,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        title: const Column(
          children: [
            Text(
              'The King’s Man',
              style: poppinsMedium,
            ),
            Text(
              'In Theaters December 22, 2021',
              style: poppinsMedium,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _dates.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: index == 0 ? 0 : 10.0, right: 10),
                    child: ChoiceChip(
                      color: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor,
                      ),
                      selectedColor: primary,
                      label: Text(
                        _dates[index],
                        style: poppinsMedium,
                      ),
                      selected: _selectedDateIndex == index,
                      onSelected: (selected) {
                        setState(() {
                          _selectedDateIndex = (selected ? index : null)!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _times[0],
                  style: poppinsMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Cinetech + Hall 1',
                  style: poppinsMedium,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: primary,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              height: 200,
              width: double.infinity,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  childAspectRatio: 0.4,
                  
                ),
                itemCount: 80, 
                itemBuilder: (context, index) {
                  return Icon(
                    Icons.event_seat,
                    color: index % 2 == 0 ? Colors.grey : Colors.blue,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'From ${_prices[0]}\$ or ${_bonuses[0]} bonus',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
            const SizedBox(height: 10),
            const Spacer(),
            Center(
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => MovieSeatSelectionScreen());
                  },
                  child: SizedBox(
                    height: 70,
                    width: 300,
                    child: Center(
                      child: Text(
                        "Select Seats",
                        style: poppinsMedium.copyWith(color: Colors.white),
                      ),
                    ),
                  )),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

