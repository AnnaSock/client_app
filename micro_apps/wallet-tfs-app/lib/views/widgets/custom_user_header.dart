import 'package:flutter/material.dart';
import 'package:micro_commons/utils/colors.dart';
import 'package:micro_commons/utils/util.dart';

class CustomUserHeader extends StatelessWidget
{
  final String name;
  final String phoneNumber;
  final VoidCallback onClose;
  final double fem;

  const CustomUserHeader({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.onClose,
    required this.fem,
  });

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [

          // bouton fermer
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: primaryColor,
                size: 28,
              ),
              onPressed: onClose,
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: const Color(0xFFBCC3FF),
                    child: Text(getInitials(name)),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),

                    Text(
                      phoneNumber,
                      style: TextStyle(
                        fontSize: 13 * fem,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
