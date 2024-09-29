import 'package:flutter/material.dart';

void main() => runApp(TempConverterApp());

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TempConverterHomePage(),
    );
  }
}

class TempConverterHomePage extends StatefulWidget {
  @override
  _TempConverterHomePageState createState() => _TempConverterHomePageState();
}

class _TempConverterHomePageState extends State<TempConverterHomePage> {
  final TextEditingController _tempController = TextEditingController();
  bool _isFahrenheitToCelsius = true;
  String _convertedTemp = '';
  List<String> _conversionHistory = [];

  void _convertTemperature() {
    setState(() {
      String inputText = _tempController.text;
      if (inputText.isEmpty || double.tryParse(inputText) == null) {
        _convertedTemp = 'Please enter a valid temperature';
        return;
      }

      double inputTemp = double.parse(inputText);
      double result;
      String historyEntry;

      if (_isFahrenheitToCelsius) {
        result = (inputTemp - 32) * 5 / 9;
        historyEntry = 'F to C: $inputTemp°F => ${result.toStringAsFixed(2)}°C';
      } else {
        result = inputTemp * 9 / 5 + 32;
        historyEntry = 'C to F: $inputTemp°C => ${result.toStringAsFixed(2)}°F';
      }

      _convertedTemp = result.toStringAsFixed(2);
      _conversionHistory.insert(0, historyEntry);
    });
  }

  void _clearHistory() {
    setState(() {
      _conversionHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.blue,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Conversion Type:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      decorationColor: Colors.blue,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: const Text('Fahrenheit to Celsius'),
                          leading: Radio<bool>(
                            value: true,
                            groupValue: _isFahrenheitToCelsius,
                            onChanged: (bool? value) {
                              setState(() {
                                _isFahrenheitToCelsius = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('Celsius to Fahrenheit'),
                          leading: Radio<bool>(
                            value: false,
                            groupValue: _isFahrenheitToCelsius,
                            onChanged: (bool? value) {
                              setState(() {
                                _isFahrenheitToCelsius = value!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    controller: _tempController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter Temperature',
                      border: OutlineInputBorder(),
                      errorText: null, // Placeholder for error handling
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _convertTemperature,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, 
                        foregroundColor: Colors.white, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'CONVERT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_convertedTemp.isNotEmpty)
                    Text(
                      'Converted Value: $_convertedTemp',
                      style: const TextStyle(fontSize: 18, color: Colors.green),
                    ),
                  const SizedBox(height: 20),
                  const Text(
                    'Conversion History',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 1.5,
                      decorationColor: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      itemCount: _conversionHistory.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_conversionHistory[index]),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: _clearHistory,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'CLEAR HISTORY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
