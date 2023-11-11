import 'package:flutter/material.dart';
import 'package:grocery_app/constants/style.dart';
import 'package:grocery_app/data/models/order_model.dart';
import 'package:grocery_app/presentation/orders/widgets/order_item.dart';

class OrdersList extends StatefulWidget {
  const OrdersList({
    super.key,
    required this.orders,
  });
  final List<OrderModel> orders;
  @override
  State<OrdersList> createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  late List<ExpansionPanel> ordersBuilder;
  late List<bool> isExpanedList;

  @override
  void initState() {
    isExpanedList = List<bool>.filled(widget.orders.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ordersBuilder = List<ExpansionPanel>.generate(
        widget.orders.length,
        (index) => OrderItem()(
            order: widget.orders[index], isExpanded: isExpanedList[index]));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isExpanedList[panelIndex] = isExpanded;
            });
          },
          animationDuration: const Duration(milliseconds: 400),
          expandedHeaderPadding: EdgeInsets.zero,
          expandIconColor: MyColors.textSecondry,
          children: ordersBuilder,
        ),
      ),
    );
  }
}
