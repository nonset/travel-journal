import '../../domain/models/expense.dart';
import '../../domain/repositories/expense_repository.dart';

class InMemoryExpenseRepository implements ExpenseRepository {
  InMemoryExpenseRepository({List<Expense>? initialExpenses})
    : _expenses = [...?initialExpenses];

  final List<Expense> _expenses;

  @override
  Future<List<Expense>> getExpensesForTrip(String tripId) async {
    return List.unmodifiable(
      _expenses.where(
        (expense) => expense.tripId == tripId && !expense.isDeleted,
      ),
    );
  }

  @override
  Future<Expense?> getExpenseById(String id) async {
    for (final expense in _expenses) {
      if (expense.id == id && !expense.isDeleted) {
        return expense;
      }
    }

    return null;
  }

  @override
  Future<void> saveExpense(Expense expense) async {
    final existingIndex = _expenses.indexWhere((item) => item.id == expense.id);

    if (existingIndex == -1) {
      _expenses.add(expense);
      return;
    }

    _expenses[existingIndex] = expense;
  }
}
