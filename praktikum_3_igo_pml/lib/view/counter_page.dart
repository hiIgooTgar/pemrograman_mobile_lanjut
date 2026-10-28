import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktikum_3_igo_pml/bloc/counter_bloc.dart';
import 'package:praktikum_3_igo_pml/bloc/counter_event.dart';
import 'package:praktikum_3_igo_pml/bloc/counter_state.dart';

class CounterPage extends StatefulWidget {
  static const Color primaryNavy = Color(0xFF0A2481);

  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final TextEditingController _kurangController = TextEditingController();
  final TextEditingController _tambahController = TextEditingController();

  @override
  void dispose() {
    _kurangController.dispose();
    _tambahController.dispose();
    super.dispose();
  }

  int _parseVal(String text) => text.isEmpty ? 1 : (int.tryParse(text) ?? 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Praktikum 3 - Bloc",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: CounterPage.primaryNavy,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.bilangan != 0 && state.bilangan % 10 == 0) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    "Nilai mencapai kelipatan 10: ${state.bilangan}",
                  ),
                  backgroundColor: CounterPage.primaryNavy,
                  duration: const Duration(seconds: 2),
                ),
              );
          }
        },
        builder: (context, state) {
          final Color textColor = state.bilangan > 0
              ? Colors.green
              : (state.bilangan < 0 ? Colors.red : Colors.black);

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isMobile = constraints.maxWidth < 500;
              return Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: isMobile ? double.infinity : 550,
                    padding: EdgeInsets.all(isMobile ? 20 : 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: isMobile
                          ? []
                          : [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${state.bilangan}",
                          style: TextStyle(
                            fontSize: isMobile ? 60 : 80,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _kurangController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDec("Nilai Kurang"),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: _tambahController,
                                keyboardType: TextInputType.number,
                                decoration: _inputDec("Nilai Tambah"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ElevatedButton(
                                    style: _btnStyle(),
                                    onPressed: () =>
                                        context.read<CounterBloc>().add(
                                          KurangEvent(
                                            _parseVal(_kurangController.text),
                                          ),
                                        ),
                                    child: const Text("Kurang"),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    style: _btnStyle(),
                                    onPressed: () =>
                                        context.read<CounterBloc>().add(
                                          TambahEvent(
                                            _parseVal(_tambahController.text),
                                          ),
                                        ),
                                    child: const Text("Tambah"),
                                  ),
                                  const SizedBox(height: 10),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: CounterPage.primaryNavy,
                                      ),
                                      foregroundColor: CounterPage.primaryNavy,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                      ),
                                    ),
                                    onPressed: () {
                                      _kurangController.clear();
                                      _tambahController.clear();
                                      context.read<CounterBloc>().add(
                                        ResetEvent(),
                                      );
                                    },
                                    child: const Text("Reset"),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    style: _btnStyle(),
                                    onPressed: () =>
                                        context.read<CounterBloc>().add(
                                          KurangEvent(
                                            _parseVal(_kurangController.text),
                                          ),
                                        ),
                                    child: const Text("Kurang"),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side: const BorderSide(
                                        color: CounterPage.primaryNavy,
                                      ),
                                      foregroundColor: CounterPage.primaryNavy,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    onPressed: () {
                                      _kurangController.clear();
                                      _tambahController.clear();
                                      context.read<CounterBloc>().add(
                                        ResetEvent(),
                                      );
                                    },
                                    child: const Text("Reset"),
                                  ),
                                  ElevatedButton(
                                    style: _btnStyle(),
                                    onPressed: () =>
                                        context.read<CounterBloc>().add(
                                          TambahEvent(
                                            _parseVal(_tambahController.text),
                                          ),
                                        ),
                                    child: const Text("Tambah"),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  InputDecoration _inputDec(String label) => InputDecoration(
    labelText: label,
    isDense: true,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: CounterPage.primaryNavy, width: 2),
    ),
  );

  ButtonStyle _btnStyle() => ElevatedButton.styleFrom(
    backgroundColor: CounterPage.primaryNavy,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
  );
}
