import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormLight extends StatefulWidget {
  const FormLight({super.key});

  @override
  State<FormLight> createState() => _FormLightState();
}

class _FormLightState extends State<FormLight> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _errorMessage = '';

  final TextEditingController _controllerCurrentKwFirstFloor =
      TextEditingController(text: "16607"); // Valor inicial
  final TextEditingController _controllerNewKwFirstFloor =
      TextEditingController();

  final TextEditingController _controllerCurrentKwSecondFloor =
      TextEditingController(text: "21825"); // Valor inicial
  final TextEditingController _controllerNewKwFSecondFloor =
      TextEditingController();

  final TextEditingController _controllerCurrentKwThridFloor =
      TextEditingController(text: "12282"); // Valor inicial
  final TextEditingController _controllerNewKwFThridFloor =
      TextEditingController();

  final TextEditingController _controllerAmountPayable =
      TextEditingController();

  int _resultFirstFloorTotalKW = 0;
  int _resultSecondFloorTotalKW = 0;
  int _resultThridFloorTotalKW = 0;

  @override
  void initState() {
    super.initState();
    // Primer piso
    _controllerCurrentKwFirstFloor.addListener(_updateResultFirstFloor);
    _controllerNewKwFirstFloor.addListener(_updateResultFirstFloor);
    // Segundo piso
    _controllerCurrentKwSecondFloor.addListener(_updateResultSecondFloor);
    _controllerNewKwFSecondFloor.addListener(_updateResultSecondFloor);
    // Tercer piso
    _controllerCurrentKwThridFloor.addListener(_updateResultThridFloor);
    _controllerNewKwFThridFloor.addListener(_updateResultThridFloor);
  }

  void _updateResultFirstFloor() {
    double value1 = double.tryParse(
            _controllerCurrentKwFirstFloor.text.replaceAll(',', '.')) ??
        0;
    double value2 =
        double.tryParse(_controllerNewKwFirstFloor.text.replaceAll(',', '.')) ??
            0;

    setState(() {
      var totalKW = (value2 - value1).round();
      if (totalKW < 0) {
        _resultFirstFloorTotalKW = 0;
      } else {
        _resultFirstFloorTotalKW = totalKW;
      }
    });
  }

  void _updateResultSecondFloor() {
    double value1 = double.tryParse(
            _controllerCurrentKwSecondFloor.text.replaceAll(',', '.')) ??
        0;
    double value2 = double.tryParse(
            _controllerNewKwFSecondFloor.text.replaceAll(',', '.')) ??
        0;

    setState(() {
      var totalKW = (value2 - value1).round();
      if (totalKW < 0) {
        _resultSecondFloorTotalKW = 0;
      } else {
        _resultSecondFloorTotalKW = totalKW;
      }
    });
  }

  void _updateResultThridFloor() {
    double value1 = double.tryParse(
            _controllerCurrentKwThridFloor.text.replaceAll(',', '.')) ??
        0;
    double value2 = double.tryParse(
            _controllerNewKwFThridFloor.text.replaceAll(',', '.')) ??
        0;

    setState(() {
      var totalKW = (value2 - value1).round();
      if (totalKW < 0) {
        _resultThridFloorTotalKW = 0;
      } else {
        _resultThridFloorTotalKW = totalKW;
      }
    });
  }

  @override
  void dispose() {
    _controllerCurrentKwFirstFloor.dispose();
    super.dispose();
  }

  void _submitForm() {
    print('_resultFirstFloorTotalKW : $_resultFirstFloorTotalKW');
    print('_resultSecondFloorTotalKW : $_resultSecondFloorTotalKW');
    print('_resultThridFloorTotalKW : $_resultThridFloorTotalKW');

    if (_formKey.currentState?.validate() == false &&
        _controllerAmountPayable.text.isEmpty) {
      setState(() {
        _errorMessage = 'Porfavor ingresa el valor del recibo a pagar';
      });
      return;
    }

    if (_formKey.currentState?.validate() == true &&
        _controllerAmountPayable.text.isNotEmpty) {
      setState(() {
        _errorMessage = '';
      });
      String valueOldKwFirstFloor = _controllerCurrentKwFirstFloor.text;
      String valueNewKwFirstFloor = _controllerNewKwFirstFloor.text;

      String valueOldKwSecondFloor = _controllerCurrentKwSecondFloor.text;
      String valueNewKwSecondFloor = _controllerNewKwFSecondFloor.text;

      String valueOldKwThridFloor = _controllerCurrentKwThridFloor.text;
      String valueNewKwThridFloor = _controllerNewKwFThridFloor.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form Submitted')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white12,
      padding: const EdgeInsets.all(25),
      child: ListView(
        children: [
          Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FirstFloorKw(
                      controllerCurrentKwFirstFloor:
                          _controllerCurrentKwFirstFloor,
                      controllerNewKwFirstFloor: _controllerNewKwFirstFloor,
                      onFieldChanged: (_) => _updateResultFirstFloor(),
                      resultTotalKW: _resultFirstFloorTotalKW,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      decoration: const BoxDecoration(color: Colors.black12),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    SecondFloorKw(
                      controllerCurrentKwSecondFloor:
                          _controllerCurrentKwSecondFloor,
                      controllerNewKwSecondFloor: _controllerNewKwFSecondFloor,
                      onFieldChanged: (_) => _updateResultSecondFloor(),
                      resultTotalKW: _resultSecondFloorTotalKW,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      decoration: const BoxDecoration(color: Colors.black12),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    ThridFloorKw(
                      controllerCurrentKwThridFloor:
                          _controllerCurrentKwThridFloor,
                      controllerNewKwThridFloor: _controllerNewKwFThridFloor,
                      onFieldChanged: (_) => _updateResultThridFloor(),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      decoration: const BoxDecoration(color: Colors.black12),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'La suma de todos los KW de la casa es: ',
                        ),
                        Text(
                          '${_resultFirstFloorTotalKW + _resultSecondFloorTotalKW + _resultThridFloorTotalKW} Kw',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 1,
                      decoration: const BoxDecoration(color: Colors.black12),
                      margin: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    const Text('Ingresa el valor del Recibo a Pagar: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      controller: _controllerAmountPayable,
                      placeholder: 'Monto del recibo a pagar: (ejem: 570.80)',
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: CupertinoColors.lightBackgroundGray,
                          width: 1.0,
                        ),
                      ),
                    ),
                    if (_errorMessage != '')
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(
                              color: CupertinoColors.destructiveRed),
                        ),
                      ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     hintText: 'Monto del recibo a pagar: (ejem: 570.80)',
                    //     border: OutlineInputBorder(),
                    //   ),
                    //   keyboardType:
                    //       const TextInputType.numberWithOptions(decimal: true),
                    //   inputFormatters: <TextInputFormatter>[
                    //     FilteringTextInputFormatter.allow(
                    //         RegExp(r'^\d+[\.\,]?\d{0,2}')),
                    //   ],
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Porfavor ingresa el valor del recibo a pagar';
                    //     }
                    //     final newValue = value.replaceAll(',', '.');
                    //     if (double.tryParse(newValue) == null) {
                    //       return 'Porfavor ingresa el valor del recibo a pagar';
                    //     }
                    //     return null;
                    //   },
                    // ),
                    const SizedBox(height: 30),
                    Platform.isIOS
                        ? Center(
                            child: CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              onPressed: _submitForm,
                              child: const Text('Realizar cuenta'),
                            ),
                          )
                        : Center(
                            child: ElevatedButton(
                              onPressed: _submitForm,
                              child: const Text('Realizar cuenta'),
                            ),
                          )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstFloorKw extends StatefulWidget {
  final TextEditingController controllerCurrentKwFirstFloor;
  final TextEditingController controllerNewKwFirstFloor;
  final Function(String) onFieldChanged;
  final int resultTotalKW;

  const FirstFloorKw({
    super.key,
    required this.controllerCurrentKwFirstFloor,
    required this.controllerNewKwFirstFloor,
    required this.onFieldChanged,
    required this.resultTotalKW,
  });

  @override
  State<FirstFloorKw> createState() => _FirstFloorKwState();
}

class _FirstFloorKwState extends State<FirstFloorKw> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Datos del Primero Piso: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerCurrentKwFirstFloor,
          decoration: const InputDecoration(
            hintText: 'Nro KW del mes anterior',
            labelText: 'Nro KW del mes anterior',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }

            final newValue = value.replaceAll(',', '.');
            if (double.tryParse(newValue) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            return null;
          },
          enabled: false,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerNewKwFirstFloor,
          decoration: const InputDecoration(
            hintText: 'Digita el nro KW del mes actual',
            labelText: 'Digita el nro KW del mes actual',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }
            final valueOfNewKw = value.replaceAll(',', '.');
            final valueOfOldKw =
                widget.controllerCurrentKwFirstFloor.text.replaceAll(',', '.');
            if (double.tryParse(valueOfNewKw) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            // Validacion para que el KW actual no sea menor al anterior
            final value1 = double.tryParse(valueOfOldKw);
            final value2 = double.tryParse(valueOfNewKw);
            if (value1 != null && value2 != null && value2 < value1) {
              return 'El KW actual no debe ser menor al KW anterior';
            }
            return null;
          },
          onChanged: widget.onFieldChanged,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Total de KW del primer piso: '),
            Text(
              '${widget.resultTotalKW} Kw',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class SecondFloorKw extends StatefulWidget {
  final TextEditingController controllerCurrentKwSecondFloor;
  final TextEditingController controllerNewKwSecondFloor;
  final Function(String) onFieldChanged;
  final int resultTotalKW;

  const SecondFloorKw({
    super.key,
    required this.controllerCurrentKwSecondFloor,
    required this.controllerNewKwSecondFloor,
    required this.onFieldChanged,
    required this.resultTotalKW,
  });

  @override
  State<SecondFloorKw> createState() => _SecondFloorKwState();
}

class _SecondFloorKwState extends State<SecondFloorKw> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Datos del Segundo Piso: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerCurrentKwSecondFloor,
          decoration: const InputDecoration(
            hintText: 'Nro KW del mes anterior',
            labelText: 'Nro KW del mes anterior',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }

            final newValue = value.replaceAll(',', '.');
            if (double.tryParse(newValue) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            return null;
          },
          enabled: false,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerNewKwSecondFloor,
          decoration: const InputDecoration(
            hintText: 'Digita el nro KW del mes actual',
            labelText: 'Digita el nro KW del mes actual',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }
            final valueOfNewKw = value.replaceAll(',', '.');
            final valueOfOldKw =
                widget.controllerCurrentKwSecondFloor.text.replaceAll(',', '.');
            if (double.tryParse(valueOfNewKw) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            // Validacion para que el KW actual no sea menor al anterior
            final value1 = double.tryParse(valueOfOldKw);
            final value2 = double.tryParse(valueOfNewKw);
            if (value1 != null && value2 != null && value2 < value1) {
              return 'El KW actual no debe ser menor al KW anterior';
            }
            return null;
          },
          onChanged: widget.onFieldChanged,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Total de KW del segundo piso: '),
            Text(
              '${widget.resultTotalKW} Kw',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}

class ThridFloorKw extends StatefulWidget {
  final TextEditingController controllerCurrentKwThridFloor;
  final TextEditingController controllerNewKwThridFloor;
  final Function(String) onFieldChanged;

  const ThridFloorKw({
    super.key,
    required this.controllerCurrentKwThridFloor,
    required this.controllerNewKwThridFloor,
    required this.onFieldChanged,
  });

  @override
  State<ThridFloorKw> createState() => _ThridFloorKwState();
}

class _ThridFloorKwState extends State<ThridFloorKw> {
  int _resultTotalKW = 0;

  @override
  void initState() {
    super.initState();
    widget.controllerCurrentKwThridFloor.addListener(_updateResult);
    widget.controllerNewKwThridFloor.addListener(_updateResult);
  }

  void _updateResult() {
    double value1 = double.tryParse(
            widget.controllerCurrentKwThridFloor.text.replaceAll(',', '.')) ??
        0;
    double value2 = double.tryParse(
            widget.controllerNewKwThridFloor.text.replaceAll(',', '.')) ??
        0;

    setState(() {
      var totalKW = (value2 - value1).round();
      if (totalKW < 0) {
        _resultTotalKW = 0;
      } else {
        _resultTotalKW = totalKW;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Datos del Tercer Piso: ',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerCurrentKwThridFloor,
          decoration: const InputDecoration(
            hintText: 'Nro KW del mes anterior',
            labelText: 'Nro KW del mes anterior',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }

            final newValue = value.replaceAll(',', '.');
            if (double.tryParse(newValue) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            return null;
          },
          enabled: false,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.controllerNewKwThridFloor,
          decoration: const InputDecoration(
            hintText: 'Digita el nro KW del mes actual',
            labelText: 'Digita el nro KW del mes actual',
            border: OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'^\d+[\.\,]?\d{0,2}')),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Porfavor ingresa un número';
            }
            final valueOfNewKw = value.replaceAll(',', '.');
            final valueOfOldKw =
                widget.controllerCurrentKwThridFloor.text.replaceAll(',', '.');
            if (double.tryParse(valueOfNewKw) == null) {
              return 'Porfavor ingresa un numero válido';
            }

            // Validacion para que el KW actual no sea menor al anterior
            final value1 = double.tryParse(valueOfOldKw);
            final value2 = double.tryParse(valueOfNewKw);
            if (value1 != null && value2 != null && value2 < value1) {
              return 'El KW actual no debe ser menor al KW anterior';
            }
            return null;
          },
          onChanged: widget.onFieldChanged,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Text('Total de KW del tercer piso: '),
            Text(
              '$_resultTotalKW Kw',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
