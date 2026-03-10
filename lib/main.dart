import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const KonversiSuhu(),
    ));

class KonversiSuhu extends StatefulWidget {
  const KonversiSuhu({super.key});
  @override
  State<KonversiSuhu> createState() => _State();
}

class _State extends State<KonversiSuhu> {
  final _ctrl = TextEditingController();
  String _dari = 'Celsius';
  final _satuan = ['Celsius', 'Fahrenheit', 'Kelvin', 'Reamur'];

  double _toCelsius(double v) => switch (_dari) {
        'Fahrenheit' => (v - 32) * 5 / 9,
        'Kelvin' => v - 273.15,
        'Reamur' => v * 5 / 4,
        _ => v,
      };

  double _fromCelsius(double c, String s) => switch (s) {
        'Fahrenheit' => c * 9 / 5 + 32,
        'Kelvin' => c + 273.15,
        'Reamur' => c * 4 / 5,
        _ => c,
      };

  String _simbol(String s) =>
      {'Celsius': '°C', 'Fahrenheit': '°F', 'Kelvin': 'K', 'Reamur': '°R'}[s]!;

  @override
  Widget build(BuildContext context) {
    final input = double.tryParse(_ctrl.text);
    final celsius = input != null ? _toCelsius(input) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Suhu'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _ctrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
              decoration: const InputDecoration(
                labelText: 'Masukkan suhu',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _dari,
              decoration: const InputDecoration(
                labelText: 'Satuan asal',
                border: OutlineInputBorder(),
              ),
              items: _satuan
                  .map((s) => DropdownMenuItem(value: s, child: Text('$s ${_simbol(s)}')))
                  .toList(),
              onChanged: (v) => setState(() => _dari = v!),
            ),
            const SizedBox(height: 20),
            if (celsius != null)
              ..._satuan
                  .where((s) => s != _dari)
                  .map((s) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          title: Text('$s ${_simbol(s)}'),
                          trailing: Text(
                            _fromCelsius(celsius, s).toStringAsFixed(2),
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}