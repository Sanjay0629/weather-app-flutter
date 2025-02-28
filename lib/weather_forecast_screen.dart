import "package:flutter/material.dart";

class WeatherForecastScreen extends StatelessWidget {
  final IconData icons;
  final String time;
  final String temp;
  const WeatherForecastScreen({
    super.key,
    required this.time,
    required this.icons,
    required this.temp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 90,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Icon(icons, size: 32),
            const SizedBox(height: 8),
            Text(temp),
          ],
        ),
      ),
    );
  }
}
