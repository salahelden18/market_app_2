import 'package:flutter/material.dart';

import '../../../../../core/utils/format_date.dart';
import '../../../data/models/order_events.dart';

class OrderMovementsWidget extends StatelessWidget {
  const OrderMovementsWidget({super.key, required this.orderEvents});
  final List<OrderEvent> orderEvents;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(orderEvents.length, (index) {
        final orderEvent = orderEvents[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                '${orderEvent.orderStatusModel?.enName}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: orderEvent.orderStatusModel?.enDesc != null
                  ? Text(
                      '${orderEvent.orderStatusModel?.enDesc}',
                    )
                  : null,
              trailing: Text(formatDateTimeToHours(orderEvent.addedAt)),
            ),
            if (index < orderEvents.length - 1)
              Container(
                margin: const EdgeInsets.only(left: 25),
                height: 20,
                width: 1,
                color: Colors.grey,
              ),
          ],
        );
      }),
    );
  }
}
