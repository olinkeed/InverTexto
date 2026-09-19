import 'dart:convert';

import 'package:aula_inv_texto/service/invertexto_service.dart';
import 'package:flutter/material.dart';

// adicao
class FeriadosPage extends StatefulWidget {
  const FeriadosPage({super.key});

  @override
  State<FeriadosPage> createState() => _FeriadosPageState();
}

class _FeriadosPageState extends State<FeriadosPage> {
  final campo = TextEditingController();
  final apiService = InvertextoApiService();
  Future<dynamic>? consulta;
  String? erro;

  // adicao
  void buscar() {
    final ano = campo.text.trim();
    if (!RegExp(r'^\d{4}$').hasMatch(ano)) {
      setState(() {
        erro = 'Digite um ano válido com quatro números.';
        consulta = null;
      });
      return;
    }
    setState(() {
      erro = null;
      consulta = apiService.buscaFeriados(ano);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PaginaConsulta(
      titulo: 'Feriados',
      label: 'Digite o ano',
      controller: campo,
      keyboardType: TextInputType.number,
      erro: erro,
      consulta: consulta,
      onBuscar: buscar,
    );
  }
}

// adicao
class CnpjPage extends StatefulWidget {
  const CnpjPage({super.key});

  @override
  State<CnpjPage> createState() => _CnpjPageState();
}

class _CnpjPageState extends State<CnpjPage> {
  final campo = TextEditingController();
  final apiService = InvertextoApiService();
  Future<dynamic>? consulta;
  String? erro;

  // adicao
  void buscar() {
    final cnpj = campo.text.replaceAll(RegExp(r'\D'), '');
    if (cnpj.length != 14) {
      setState(() {
        erro = 'Digite um CNPJ válido com 14 números.';
        consulta = null;
      });
      return;
    }
    setState(() {
      erro = null;
      consulta = apiService.buscaCnpj(cnpj);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PaginaConsulta(
      titulo: 'Consulta CNPJ',
      label: 'Digite o CNPJ',
      controller: campo,
      keyboardType: TextInputType.number,
      erro: erro,
      consulta: consulta,
      onBuscar: buscar,
    );
  }
}

// adicao
class EmailPage extends StatefulWidget {
  const EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final campo = TextEditingController();
  final apiService = InvertextoApiService();
  Future<dynamic>? consulta;
  String? erro;

  // adicao
  void buscar() {
    final email = campo.text.trim();
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      setState(() {
        erro = 'Digite um e-mail válido.';
        consulta = null;
      });
      return;
    }
    setState(() {
      erro = null;
      consulta = apiService.validaEmail(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _PaginaConsulta(
      titulo: 'Validar e-mail',
      label: 'Digite o e-mail',
      controller: campo,
      keyboardType: TextInputType.emailAddress,
      erro: erro,
      consulta: consulta,
      onBuscar: buscar,
    );
  }
}

// adicao
class _PaginaConsulta extends StatelessWidget {
  const _PaginaConsulta({
    required this.titulo,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.erro,
    required this.consulta,
    required this.onBuscar,
  });

  final String titulo;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? erro;
  final Future<dynamic>? consulta;
  final VoidCallback onBuscar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(titulo, style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(color: Colors.white),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => onBuscar(),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onBuscar,
                child: const Text('Consultar'),
              ),
            ),
            if (erro != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  erro!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            // adicao
            if (consulta != null)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 14),
                  child: FutureBuilder<dynamic>(
                    future: consulta,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(
                          'Não foi possível concluir a consulta.\n${snapshot.error}',
                          style: const TextStyle(color: Colors.redAccent),
                          textAlign: TextAlign.center,
                        );
                      }
                      final dados = snapshot.data;
                      if (dados == null || (dados is Map && dados.isEmpty)) {
                        return const Text(
                          'A API não retornou dados.',
                          style: TextStyle(color: Colors.white),
                        );
                      }
                      return Text(
                        const JsonEncoder.withIndent('  ').convert(dados),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
