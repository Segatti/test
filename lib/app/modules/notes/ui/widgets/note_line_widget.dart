import 'package:flutter/material.dart';

class NoteLineWidget extends StatelessWidget {
  final String note;
  final int index;
  final Function(BuildContext, int) editPopup;
  final Function(BuildContext, int) deletePopup;
  const NoteLineWidget({
    super.key,
    required this.note,
    required this.editPopup,
    required this.deletePopup,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    note,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                editPopup(context, index);
              },
              child: const Icon(
                Icons.edit,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () {
                deletePopup(context, index);
              },
              child: const Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
