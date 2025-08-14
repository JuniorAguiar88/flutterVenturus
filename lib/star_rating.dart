import 'package:flutter/material.dart';

class StarRating extends StatefulWidget {
  const StarRating({
    super.key,
    required this.value,
    required this.onRatingChanged,
  });

  final int value;
  final Function(int)? onRatingChanged;

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _rating;
  final int _starCount = 10;

  @override
  void initState() {
    super.initState();
    _rating = widget.value;
  }

  Widget _buildStar(int index) {
    return SizedBox(
      height: 32,
      width: 32,
      child: IconButton(
        icon: Icon(
          Icons.star,
          size: 16,
          color: index < _rating ? Colors.amber : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            _rating = index + 1;
          });
          if (widget.onRatingChanged != null) {
            widget.onRatingChanged!(_rating);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_starCount, (index) => _buildStar(index)),
    );
  }
}
