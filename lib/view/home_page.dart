import 'package:aula_inv_texto/view/busca_cep_page.dart';
import 'package:aula_inv_texto/view/por_extenso_page.dart';
// adicao
import 'package:aula_inv_texto/view/novas_funcionalidades_pages.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              child: Row(
                children: [
                  Icon(Icons.edit, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Por Extenso",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PorExtensoPage()),
                );
              },
            ),
            GestureDetector(
              // adicao
              child: Row(
                children: [
                  Icon(Icons.event, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Feriados",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeriadosPage()),
                );
              },
            ),
            GestureDetector(
              // adicao
              child: Row(
                children: [
                  Icon(Icons.business, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Consulta CNPJ",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CnpjPage()),
                );
              },
            ),
            GestureDetector(
              // adicao
              child: Row(
                children: [
                  Icon(Icons.email, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Validar e-mail",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailPage()),
                );
              },
            ),
            GestureDetector(
              child: Row(
                children: [
                  Icon(Icons.home, color: Colors.white, size: 50.0),
                  SizedBox(width: 30),
                  Text(
                    "Busca CEP",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuscaCepPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
