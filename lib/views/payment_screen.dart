import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> metodos = [
      {
        'titulo': 'Tarjeta de Crédito o Débito',
        'icono': Icons.credit_card,
        'color': Colors.blue[100],
        'accion': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Seleccionaste Tarjeta de Crédito/Débito")),
          );
        },
      },
      {
        'titulo': 'PayPal',
        'icono': Icons.account_balance_wallet,
        'color': Colors.orange[100],
        'accion': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Seleccionaste PayPal")),
          );
        },
      },
      {
        'titulo': 'Transferencia Bancaria',
        'icono': Icons.account_balance,
        'color': Colors.green[100],
        'accion': () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Seleccionaste Transferencia Bancaria")),
          );
        },
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medio de Pago'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: metodos.length,
        itemBuilder: (context, index) {
          final metodo = metodos[index];
          return Card(
            color: metodo['color'],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(metodo['icono'], size: 32),
              title: Text(metodo['titulo']),
              onTap: metodo['accion'],
            ),
          );
        },
      ),
    );
  }
}
