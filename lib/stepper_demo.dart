import 'package:flutter/material.dart';

const Color kMainColor = Color.fromARGB(255, 232, 245, 245);

class StepperDemo extends StatefulWidget {
  const StepperDemo({super.key});

  @override
  State<StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  final List<Map<String, String>> _stages = [
    {
      'title': 'Order placed',
      'subtitle': 'We received your order',
      'detail': 'Order was placed and confirmed. Preparing to process.'
    },
    {
      'title': 'Processing',
      'subtitle': 'We are preparing your items',
      'detail': 'Items are being picked from the warehouse and prepared for packing.'
    },
    {
      'title': 'Packed',
      'subtitle': 'Items packed securely',
      'detail': 'Your items have been packed and are ready to be handed to the carrier.'
    },
    {
      'title': 'Shipped',
      'subtitle': 'Carrier received the parcel',
      'detail': 'Parcel has been handed over to the carrier and left the origin facility.'
    },
    {
      'title': 'Delivered',
      'subtitle': 'Package delivered',
      'detail': 'Delivery completed. Enjoy your purchase!'
    },
  ];

  int _currentStep = 0;

  @override
  void dispose() {
    super.dispose();
  }

  void _goToStep(int step) {
    setState(() => _currentStep = step.clamp(0, _stages.length - 1));
  }

  void _onStepContinue() {
    if (_currentStep < _stages.length - 1) {
      setState(() => _currentStep++);
    } else {
      _showSummary();
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) setState(() => _currentStep--);
  }

  void _reset() {
    setState(() => _currentStep = 0);
  }

  void _showSummary() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Summary'),
        content: Text('Shipping progressed from ${_stages.first['title']} to ${_stages.last['title']}.'
            '\nCurrent status: ${_stages[_currentStep]['title']}.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _stages[_currentStep];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Timeline'),
        actions: [
          IconButton(
            tooltip: 'Reset',
            icon: const Icon(Icons.refresh),
            onPressed: _reset,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [kMainColor, Colors.orange.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Card with rounded corners like the design
                  Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
                      child: Column(
                        children: [
                          // Header
                          Row(
                            children: [
                              const Expanded(
                                child: Text('Shipping process', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              ),
                              Chip(label: Text('${_currentStep + 1}/${_stages.length}'))
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Use Material Stepper to demonstrate the Stepper widget
                          Stepper(
                            type: StepperType.vertical,
                            currentStep: _currentStep,
                            onStepTapped: (i) => _goToStep(i),
                            onStepContinue: _onStepContinue,
                            onStepCancel: _onStepCancel,
                            controlsBuilder: (context, details) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(onPressed: details.onStepCancel, child: const Text('Back')),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: details.onStepContinue,
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent, foregroundColor: Colors.white),
                                      child: Text(_currentStep == _stages.length - 1 ? 'Finish' : 'Next'),
                                    ),
                                  ],
                                ),
                              );
                            },
                            steps: List.generate(_stages.length, (i) {
                              final s = _stages[i];
                              return Step(
                                title: Text(s['title']!),
                                subtitle: Text(s['subtitle']!),
                                content: Text(s['detail']!),
                                isActive: i <= _currentStep,
                                state: i < _currentStep ? StepState.complete : (i == _currentStep ? StepState.editing : StepState.indexed),
                              );
                            }),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Progress summary bar
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: LinearProgressIndicator(
                                  value: (_currentStep + 1) / _stages.length,
                                  backgroundColor: Colors.grey[200],
                                  color: Colors.deepPurpleAccent,
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text('${_currentStep + 1}/${_stages.length}', style: const TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(alignment: Alignment.centerLeft, child: Text('Current: ${current['title']}', style: const TextStyle(fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ...existing code...
}
