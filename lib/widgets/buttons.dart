import 'package:flutter/material.dart';
import 'package:cpm/utils/colors.dart';

// ElevatedButton myElevatedButton(String buttonLabel, onPressed) {
//   return ElevatedButton(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(myPrimaryColor),
//       shape: MaterialStateProperty.all<OutlinedBorder>(
//         const RoundedRectangleBorder(
//           borderRadius: BorderRadius.zero,
//         ),
//       ),
//     ),
//     onPressed: () => onPressed(),
//     child: Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Text(
//         buttonLabel,
//         style: const TextStyle(color: Colors.white),
//       ),
//     ),
//   );
// }
ElevatedButton myElevatedButton(String btnLabel, onPressHandler) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: myPrimaryColor,
      minimumSize: const Size.fromHeight(10),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    onPressed: () => onPressHandler(),
    child: Text(btnLabel,
        style: const TextStyle(fontSize: 18.0, color: Colors.white)),
  );
}
