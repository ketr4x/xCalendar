import 'package:flutter/material.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/drawer.dart';
import 'converter_page.dart';

class UnitLandingPage extends StatefulWidget {
  const UnitLandingPage({super.key});

  @override
  State<UnitLandingPage> createState() => _UnitLandingPageState();
}

class _UnitLandingPageState extends State<UnitLandingPage> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    BottomNavBar.handleNavigation(context, index);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> units = {
      'Length': ['Millimeter', 'Centimeter', 'Meter', 'Kilometer', 'Inch', 'Foot', 'Yard', 'Mile', 'Nautical mile'],
      'Area': ['Square millimeter', 'Square centimeter', 'Square meter', 'Hectare', 'Square kilometer', 'Square inch', 'Square foot', 'Square yard', 'Acre', 'Square mile'],
      'Volume': ['Milliliter', 'Centiliter', 'Liter', 'Cubic meter', 'Cubic inch', 'Cubic foot', 'Fluid ounce', 'Cup', 'Pint', 'Quart', 'Gallon'],
      'Weight': ['Milligram', 'Gram', 'Kilogram', 'Tonne', 'Ounce', 'Pound', 'Stone', 'US ton', 'Imperial ton'],
      'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
      'Time': ['Nanosecond', 'Microsecond', 'Millisecond', 'Second', 'Minute', 'Hour', 'Day', 'Week', 'Month', 'Year', 'Decade', 'Century'],
      'Speed': ['Meter per second', 'Kilometer per hour', 'Mile per hour', 'Knot', 'Foot per second'],
      'Pressure': ['Pascal', 'Kilopascal', 'Bar', 'Atmosphere', 'Pound per square inch', 'Torr', 'Millimeter of mercury'],
      'Energy': ['Joule', 'Kilojoule', 'Calorie', 'Kilocalorie', 'Watt-hour', 'Kilowatt-hour', 'Electronvolt', 'British thermal unit'],
      'Power': ['Watt', 'Kilowatt', 'Horsepower', 'Megawatt', 'Gigawatt'],
      'Data': ['Bit', 'Byte', 'Kilobyte', 'Megabyte', 'Gigabyte', 'Terabyte', 'Petabyte'],
      'Angle': ['Degree', 'Radian', 'Gradian', 'Minute of arc', 'Second of arc', 'Revolution']
    };

    final unitCategories = [
      {
        'name': 'Length',
        'icon': Icons.straighten,
        'color': Colors.blue.shade700,
      },
      {
        'name': 'Area',
        'icon': Icons.crop_square,
        'color': Colors.green.shade700,
      },
      {
        'name': 'Volume',
        'icon': Icons.local_drink,
        'color': Colors.cyan.shade700,
      },
      {
        'name': 'Weight',
        'icon': Icons.fitness_center,
        'color': Colors.orange.shade700,
      },
      {
        'name': 'Temperature',
        'icon': Icons.thermostat,
        'color': Colors.red.shade700,
      },
      {
        'name': 'Time',
        'icon': Icons.access_time,
        'color': Colors.purple.shade700,
      },
      {
        'name': 'Speed',
        'icon': Icons.speed,
        'color': Colors.indigo.shade700,
      },
      {
        'name': 'Pressure',
        'icon': Icons.compress,
        'color': Colors.teal.shade700,
      },
      {
        'name': 'Energy',
        'icon': Icons.bolt,
        'color': Colors.amber.shade700,
      },
      {
        'name': 'Power',
        'icon': Icons.flash_on,
        'color': Colors.deepOrange.shade700,
      },
      {
        'name': 'Data',
        'icon': Icons.storage,
        'color': Colors.brown.shade700,
      },
      {
        'name': 'Angle',
        'icon': Icons.architecture,
        'color': Colors.blueGrey.shade700,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "Unit Converter",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      drawer: AppDrawer(category: 'Math'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
              child: Text(
                'Select Unit Category',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                padding: const EdgeInsets.all(4.0),
                itemCount: unitCategories.length,
                itemBuilder: (context, index) {
                  final category = unitCategories[index];
                  return UnitCategoryButton(
                    name: category['name'] as String,
                    icon: category['icon'] as IconData,
                    color: category['color'] as Color,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UnitConvertPage(category: category['name'] as String, units: units[category['name']] as List<String>)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}

class UnitCategoryButton extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const UnitCategoryButton({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3), width: 2),
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32.0,
                color: color,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              name,
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}