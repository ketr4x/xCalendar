class Converter {
  Map<String, double> convert({required List<String> units, required String category, required String selectedFromUnit, required double value}) {
    Map<String, double> result = {};
    for (String unit in units) {
      result[unit] = 0.0;
    }
    result[selectedFromUnit] = value;

    if (category == 'Length') {
      if (selectedFromUnit == 'Millimeter') {result['Meter'] = value / 1000;}
      else if (selectedFromUnit == 'Centimeter') {result['Meter'] = value / 100;}
      else if (selectedFromUnit == 'Kilometer') {result['Meter'] = value * 1000;}
      else if (selectedFromUnit == 'Inch') {result['Meter'] = value * 0.0254;}
      else if (selectedFromUnit == 'Foot') {result['Meter'] = value * 0.3048;}
      else if (selectedFromUnit == 'Yard') {result['Meter'] = value * 0.9144;}
      else if (selectedFromUnit == 'Mile') {result['Meter'] = value * 1609.34;}
      else if (selectedFromUnit == 'Nautical mile') {result['Meter'] = value * 1852;}
      
      result['Millimeter'] = result["Meter"]! * 1000;
      result['Centimeter'] = result["Meter"]! * 100;
      result['Kilometer'] = result["Meter"]! / 1000;
      result['Inch'] = result["Meter"]! / 0.0254;
      result['Foot'] = result["Meter"]! / 0.3048;
      result['Yard'] = result["Meter"]! / 0.9144;
      result['Mile'] = result["Meter"]! / 1609.34;
      result['Nautical mile'] = result["Meter"]! / 1852;
      
    } else if (category == 'Weight') {
      if (selectedFromUnit == 'Milligram') {result['Kilogram'] = value / 1e6;}
      else if (selectedFromUnit == 'Gram') {result['Kilogram'] = value / 1000;}
      else if (selectedFromUnit == 'Tonne') {result['Kilogram'] = value * 1000;}
      else if (selectedFromUnit == 'Ounce') {result['Kilogram'] = value * 0.0283495;}
      else if (selectedFromUnit == 'Pound') {result['Kilogram'] = value * 0.453592;}
      else if (selectedFromUnit == 'Stone') {result['Kilogram'] = value * 6.35029;}
      else if (selectedFromUnit == 'US ton') {result['Kilogram'] = value * 907.185;}
      else if (selectedFromUnit == 'Imperial ton') {result['Kilogram'] = value * 1016.05;}

      result['Milligram'] = result["Kilogram"]! * 1e6;
      result['Gram'] = result["Kilogram"]! * 1000;
      result['Tonne'] = result["Kilogram"]! / 1000;
      result['Ounce'] = result["Kilogram"]! / 0.0283495;
      result['Pound'] = result["Kilogram"]! / 0.453592;
      result['Stone'] = result["Kilogram"]! / 6.35029;
      result['US ton'] = result["Kilogram"]! / 907.185;
      result['Imperial ton'] = result["Kilogram"]! / 1016.05;

    } else if (category == 'Temperature') {
      if (selectedFromUnit == 'Celsius') {
        result['Fahrenheit'] = (value * 9/5) + 32;
        result['Kelvin'] = value + 273.15;
      } else if (selectedFromUnit == 'Fahrenheit') {
        result['Celsius'] = (value - 32) * 5/9;
        result['Kelvin'] = (value - 32) * 5/9 + 273.15;
      } else if (selectedFromUnit == 'Kelvin') {
        result['Celsius'] = value - 273.15;
        result['Fahrenheit'] = (value - 273.15) * 9/5 + 32;
      }
    } else if (category == 'Time') {
      if (selectedFromUnit == 'Nanosecond') {result['Second'] = value / 1e9;}
      else if (selectedFromUnit == 'Microsecond') {result['Second'] = value / 1e6;}
      else if (selectedFromUnit == 'Millisecond') {result['Second'] = value / 1000;}
      else if (selectedFromUnit == 'Minute') {result['Second'] = value * 60;}
      else if (selectedFromUnit == 'Hour') {result['Second'] = value * 3600;}
      else if (selectedFromUnit == 'Day') {result['Second'] = value * 86400;}
      else if (selectedFromUnit == 'Week') {result['Second'] = value * 604800;}
      else if (selectedFromUnit == 'Month') {result['Second'] = value * 2592000;}
      else if (selectedFromUnit == 'Year') {result['Second'] = value * 31536000;}

      result['Nanosecond'] = result["Second"]! * 1e9;
      result['Microsecond'] = result["Second"]! * 1e6;
      result['Millisecond'] = result["Second"]! * 1000;
      result['Minute'] = result["Second"]! / 60;
      result['Hour'] = result["Second"]! / 3600;
      result['Day'] = result["Second"]! / 86400;
      result['Week'] = result["Second"]! / 604800;
      result['Month'] = result["Second"]! / 2592000;
      result['Year'] = result["Second"]! / 31536000;
      result['Decade'] = result["Second"]! / 315360000;
      result['Century'] = result["Second"]! / 31536000000;

    } else if (category == 'Area') {
      if (selectedFromUnit == 'Square millimeter') {result['Square meter'] = value / 1e6;}
      else if (selectedFromUnit == 'Square centimeter') {result['Square meter'] = value / 10000;}
      else if (selectedFromUnit == 'Square meter') {result['Square meter'] = value;}
      else if (selectedFromUnit == 'Hectare') {result['Square meter'] = value * 10000;}
      else if (selectedFromUnit == 'Square kilometer') {result['Square meter'] = value * 1e6;}
      else if (selectedFromUnit == 'Square inch') {result['Square meter'] = value * 0.00064516;}
      else if (selectedFromUnit == 'Square foot') {result['Square meter'] = value * 0.092903;}
      else if (selectedFromUnit == 'Square yard') {result['Square meter'] = value * 0.836127;}
      else if (selectedFromUnit == 'Acre') {result['Square meter'] = value * 4046.86;}
      else if (selectedFromUnit == 'Square mile') {result['Square meter'] = value * 2.58999e6;}

      result['Square millimeter'] = result["Square meter"]! * 1e6;
      result['Square centimeter'] = result["Square meter"]! * 10000;
      result['Square kilometer'] = result["Square meter"]! / 1e6;
      result['Square inch'] = result["Square meter"]! / 0.00064516;
      result['Square foot'] = result["Square meter"]! / 0.092903;
      result['Square yard'] = result["Square meter"]! / 0.836127;
      result['Hectare'] = result["Square meter"]! / 10000;
      result['Acre'] = result["Square meter"]! / 4046.86;
      result['Square mile'] = result["Square meter"]! / 2.58999e6;

    } else if (category == 'Volume') {
      if (selectedFromUnit == 'Milliliter') {result['Liter'] = value / 1000;}
      else if (selectedFromUnit == 'Centiliter') {result['Liter'] = value / 100;}
      else if (selectedFromUnit == 'Cubic meter') {result['Liter'] = value * 1000;}
      else if (selectedFromUnit == 'Cubic inch') {result['Liter'] = value * 0.0163871;}
      else if (selectedFromUnit == 'Cubic foot') {result['Liter'] = value * 28.3168;}
      else if (selectedFromUnit == 'Fluid ounce') {result['Liter'] = value * 0.0295735;}
      else if (selectedFromUnit == 'Cup') {result['Liter'] = value * 0.236588;}
      else if (selectedFromUnit == 'Pint') {result['Liter'] = value * 0.473176;}
      else if (selectedFromUnit == 'Quart') {result['Liter'] = value * 0.946353;}
      else if (selectedFromUnit == 'Gallon') {result['Liter'] = value * 3.78541;}

      result['Milliliter'] = result["Liter"]! * 1000;
      result['Centiliter'] = result["Liter"]! * 100;
      result['Cubic meter'] = result["Liter"]! / 1000;
      result['Cubic inch'] = result["Liter"]! / 0.0163871;
      result['Cubic foot'] = result["Liter"]! / 28.3168;
      result['Fluid ounce'] = result["Liter"]! / 0.0295735;
      result['Cup'] = result["Liter"]! / 0.236588;
      result['Pint'] = result["Liter"]! / 0.473176;
      result['Quart'] = result["Liter"]! / 0.946353;
      result['Gallon'] = result["Liter"]! / 3.78541;

    } else if (category == 'Speed') {
      if (selectedFromUnit == 'Kilometer per hour') {result['Meter per second'] = value / 3.6;}
      else if (selectedFromUnit == 'Mile per hour') {result['Meter per second'] = value * 0.44704;}
      else if (selectedFromUnit == 'Knot') {result['Meter per second'] = value * 0.514444;}
      else if (selectedFromUnit == 'Foot per second') {result['Meter per second'] = value * 0.3048;}

      result['Kilometer per hour'] = result["Meter per second"]! * 3.6;
      result['Mile per hour'] = result["Meter per second"]! / 0.44704;
      result['Knot'] = result["Meter per second"]! / 0.514444;
      result['Foot per second'] = result["Meter per second"]! / 0.3048;

    } else if (category == 'Pressure') {
      if (selectedFromUnit == 'Pascal') {result['Bar'] = value / 1e5;}
      else if (selectedFromUnit == 'Kilopascal') {result['Bar'] = value / 100;}
      else if (selectedFromUnit == 'Bar') {result['Bar'] = value;}
      else if (selectedFromUnit == 'Atmosphere') {result['Bar'] = value * 1.01325;}
      else if (selectedFromUnit == 'Pound per square inch') {result['Bar'] = value * 6894.76;}
      else if (selectedFromUnit == 'Torr') {result['Bar'] = value / 750.062;}
      else if (selectedFromUnit == 'Millimeter of mercury') {result['Bar'] = value / 760;}

      result['Pascal'] = result["Bar"]! * 1e5;
      result['Kilopascal'] = result["Bar"]! * 100;
      result['Atmosphere'] = result["Bar"]! / 1.01325;
      result['Pound per square inch'] = result["Bar"]! / 6894.76;
      result['Torr'] = result["Bar"]! * 750.062;
      result['Millimeter of mercury'] = result["Bar"]! * 760;
    } else if (category == 'Angle') {
      if (selectedFromUnit == 'Radian') {result['Degree'] = value * (180 / 3.141592653589793);}
      else if (selectedFromUnit == 'Gradian') {result['Degree'] = value * (9 / 10);}
      else if (selectedFromUnit == 'Minute of arc') {result['Degree'] = value / 60;}
      else if (selectedFromUnit == 'Second of arc') {result['Degree'] = value / 3600;}
      else if (selectedFromUnit == 'Revolution') {result['Degree'] = value * 360;}

      result['Radian'] = result["Degree"]! * (3.141592653589793 / 180);
      result['Gradian'] = result["Degree"]! / (9 / 10);
      result['Minute of arc'] = result["Degree"]! * 60;
      result['Second of arc'] = result["Degree"]! * 3600;
      result['Revolution'] = result["Degree"]! / 360;
    } else if (category == 'Data') {
      if (selectedFromUnit == 'Bit') {result['Byte'] = value / 8;}
      else if (selectedFromUnit == 'Kilobyte') {result['Byte'] = value * 1024;}
      else if (selectedFromUnit == 'Megabyte') {result['Byte'] = value * 1024 * 1024;}
      else if (selectedFromUnit == 'Gigabyte') {result['Byte'] = value * 1024 * 1024 * 1024;}
      else if (selectedFromUnit == 'Terabyte') {result['Byte'] = value * 1024 * 1024 * 1024 * 1024;}
      else if (selectedFromUnit == 'Petabyte') {result['Byte'] = value * 1024 * 1024 * 1024 * 1024 * 1024;}

      result['Bit'] = result["Byte"]! * 8;
      result['Kilobyte'] = result["Byte"]! / 1024;
      result['Megabyte'] = result["Byte"]! / (1024 * 1024);
      result['Gigabyte'] = result["Byte"]! / (1024 * 1024 * 1024);
      result['Terabyte'] = result["Byte"]! / (1024 * 1024 * 1024 * 1024);
      result['Petabyte'] = result["Byte"]! / (1024 * 1024 * 1024 * 1024 * 1024);
    } else if (category == 'Energy') {
      if (selectedFromUnit == 'Joule') {result['Kilojoule'] = value / 1000;}
      else if (selectedFromUnit == 'Calorie') {result['Kilojoule'] = value * 4.184;}
      else if (selectedFromUnit == 'Kilocalorie') {result['Kilojoule'] = value * 4184;}
      else if (selectedFromUnit == 'Watt-hour') {result['Kilojoule'] = value * 3600;}
      else if (selectedFromUnit == 'Kilowatt-hour') {result['Kilojoule'] = value * 3.6e6;}
      else if (selectedFromUnit == 'Electronvolt') {result['Kilojoule'] = value * 1.60218e-16;}
      else if (selectedFromUnit == 'British thermal unit') {result['Kilojoule'] = value * 1055.06;}

      result['Joule'] = result["Kilojoule"]! * 1000;
      result['Calorie'] = result["Kilojoule"]! / 4.184;
      result['Kilocalorie'] = result["Kilojoule"]! / 4184;
      result['Watt-hour'] = result["Kilojoule"]! / 3600;
      result['Kilowatt-hour'] = result["Kilojoule"]! / 3.6e6;
      result['Electronvolt'] = result["Kilojoule"]! / 1.60218e-16;
      result['British thermal unit'] = result["Kilojoule"]! / 1055.06;
    } else if (category == 'Power') {
      if (selectedFromUnit == 'Watt') {result['Kilowatt'] = value / 1000;}
      else if (selectedFromUnit == 'Horsepower') {result['Kilowatt'] = value * 0.7457;}
      else if (selectedFromUnit == 'Megawatt') {result['Kilowatt'] = value * 1e3;}
      else if (selectedFromUnit == 'Gigawatt') {result['Kilowatt'] = value * 1e6;}

      result['Watt'] = result["Kilowatt"]! * 1000;
      result['Horsepower'] = result["Kilowatt"]! / 0.7457;
      result['Megawatt'] = result["Kilowatt"]! / 1e3;
      result['Gigawatt'] = result["Kilowatt"]! / 1e6;
    }
    
    return result;
  }
  
  Map<String, double> call({
    required String category,
    required String selectedFromUnit,
    required List<String> units,
    required double value,
  }) {
    return convert(category: category, value: value, selectedFromUnit: selectedFromUnit, units: units);
  }
}
