import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final bool isChecked;
  final String taskName;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;
  Function(BuildContext)? editFunction;

  ToDoTile({
    super.key,
    required this.isChecked,
    required this.taskName,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) {
            onChanged!(!isChecked);
          }
        },
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFunction,
                backgroundColor: const Color.fromARGB(255, 189, 42, 31),
                foregroundColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                autoClose: true,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: editFunction,
                backgroundColor: const Color.fromARGB(255, 32, 103, 34),
                foregroundColor: Colors.white,

                borderRadius: BorderRadius.circular(12),
                autoClose: true,
                icon: Icons.edit,
                label: 'Edit',
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color:
                  isChecked
                      ? Colors.grey[700]
                      : const Color.fromARGB(255, 20, 61, 90),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5.0,
                  offset: const Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Transform.scale(
                  scale:
                      1.3, // Adjust the scale factor to make the checkbox bigger
                  child: Checkbox(
                    value: isChecked,
                    onChanged: onChanged,
                    side: const BorderSide(color: Colors.white),
                    checkColor:
                        Colors.white, // Set the check mark color to white
                    fillColor: WidgetStateProperty.all(
                      Colors.black,
                    ), // Set the background color to black
                  ),
                ),
                Text(
                  taskName,
                  style: TextStyle(
                    color: isChecked ? Colors.white54 : Colors.white,
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        offset: Offset(1, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
