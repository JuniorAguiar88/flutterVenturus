import 'package:flutter/material.dart';

Widget ratingWidget({
  required int number,
  double size = 48,
  Color textColor = Colors.black,
  double fontSize = 12,
}) {
  // Determina a cor da estrela baseado no número
  Color starColor;
  if (number >= 0 && number <= 3) {
    starColor = const Color(0xFFCD7F32); // Bronze
  } else if (number >= 4 && number <= 6) {
    starColor = Colors.grey; // Prata
  } else if (number >= 7 && number <= 10) {
    starColor = Colors.amber; // Amarelo (ouro)
  } else {
    starColor = Colors.grey; // Padrão para valores fora do intervalo
  }

  return SizedBox(
    height: size,
    width: size,
    child: Stack(
      children: [
        Icon(Icons.star, color: starColor, size: size),
        Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ],
    ),
  );
}
