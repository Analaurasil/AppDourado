import 'package:flutter/material.dart';

class FormContrato extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CADASTRO',
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            Text('Tipo de Usuário:'),
            ListTile(
              title: Text('Funcionario'),
            ),
            ListTile(
              title: Text('Gerente'),
            ),
            ElevatedButton(
              onPressed: (){

              }, 
              child: 
                Text('Cadastrar')
              ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){

              }, 
              child: 
                Text('Login')
              )
          ],
        ),
      ),
    );
  }
}
