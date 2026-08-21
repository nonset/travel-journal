import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/models/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({required this.tripName, super.key});

  final String tripName;

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _amountController = TextEditingController();
  final _currencyController = TextEditingController(text: 'THB');
  final _noteController = TextEditingController();
  var _category = ExpenseCategory.food;
  var _paymentMethod = PaymentMethod.cash;
  late DateTime _expenseDate;

  @override
  void initState() {
    super.initState();
    _expenseDate = DateUtils.dateOnly(DateTime.now());
  }

  @override
  void dispose() {
    _amountController.dispose();
    _currencyController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.addExpenseTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Text(AppStrings.addExpenseTitle, style: textTheme.displaySmall),
            const SizedBox(height: AppSpacing.sm),
            Text(widget.tripName, style: textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.xl),
            TextFormField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: AppStrings.addExpenseAmountLabel,
                hintText: AppStrings.addExpenseAmountHint,
                prefixIcon: Icon(Icons.payments_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<ExpenseCategory>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: AppStrings.addExpenseCategoryLabel,
                prefixIcon: Icon(Icons.category_outlined),
              ),
              items: [
                for (final category in ExpenseCategory.values)
                  DropdownMenuItem(
                    value: category,
                    child: Text(_categoryLabel(category)),
                  ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _category = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<PaymentMethod>(
              initialValue: _paymentMethod,
              decoration: const InputDecoration(
                labelText: AppStrings.addExpensePaymentMethodLabel,
                prefixIcon: Icon(Icons.account_balance_wallet_outlined),
              ),
              items: [
                for (final method in PaymentMethod.values)
                  DropdownMenuItem(
                    value: method,
                    child: Text(_paymentMethodLabel(method)),
                  ),
              ],
              onChanged: (value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _paymentMethod = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _currencyController,
              textCapitalization: TextCapitalization.characters,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: AppStrings.addExpenseCurrencyLabel,
                prefixIcon: Icon(Icons.currency_exchange_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _DatePickerCard(
              label: AppStrings.addExpenseDateLabel,
              date: _expenseDate,
              onPressed: () => _pickExpenseDate(context),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _noteController,
              minLines: 3,
              maxLines: 5,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: AppStrings.addExpenseNoteLabel,
                hintText: AppStrings.addExpenseNoteHint,
                prefixIcon: Icon(Icons.edit_note_outlined),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            FilledButton.icon(
              onPressed: _showDraftReady,
              icon: const Icon(Icons.check_rounded),
              label: const Text(AppStrings.addExpenseSave),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickExpenseDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _expenseDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _expenseDate = DateUtils.dateOnly(pickedDate);
    });
  }

  void _showDraftReady() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.addExpenseDraftReady)),
    );
  }

  String _categoryLabel(ExpenseCategory category) {
    return switch (category) {
      ExpenseCategory.food => 'Food',
      ExpenseCategory.hotel => 'Hotel',
      ExpenseCategory.transport => 'Transport',
      ExpenseCategory.shopping => 'Shopping',
      ExpenseCategory.entertainment => 'Entertainment',
      ExpenseCategory.ticket => 'Ticket',
      ExpenseCategory.other => 'Other',
    };
  }

  String _paymentMethodLabel(PaymentMethod method) {
    return switch (method) {
      PaymentMethod.cash => 'Cash',
      PaymentMethod.creditCard => 'Credit Card',
      PaymentMethod.eWallet => 'E-Wallet',
    };
  }
}

class _DatePickerCard extends StatelessWidget {
  const _DatePickerCard({
    required this.label,
    required this.date,
    required this.onPressed,
  });

  final String label;
  final DateTime date;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(AppSpacing.md),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: textTheme.labelSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(
            _formatDate(date),
            style: textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');

    return '${date.year}-$month-$day';
  }
}
