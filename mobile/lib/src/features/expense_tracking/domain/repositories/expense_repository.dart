import '../models/expense.dart';

abstract class ExpenseRepository {
  Future<List<Expense>> getExpensesForTrip(String tripId);

  Future<Expense?> getExpenseById(String id);

  Future<void> saveExpense(Expense expense);
}
