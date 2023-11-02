import 'package:flutter/material.dart';

class TaskActionButton extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  TaskActionButton({
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onEditPressed,
          child: Text('Editar'),
        ),
        ElevatedButton(
          onPressed: onDeletePressed,
          child: Text('Excluir'),
        ),
      ],
    );
  }
}
