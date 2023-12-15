class Apis {
  //cmd ipconfig ipv4 address = 192.168.1.103
  static const _baseUrl = 'http://192.168.1.107/';

  static const loginApi = '${_baseUrl}login.php';
  static const signUpApi = '${_baseUrl}register.php';

  static const getGelirApi = '${_baseUrl}budgetPlanning/getAmount.php';
  static const getGelirCategoriesApi =
      '${_baseUrl}budgetPlanning/getCategories.php?categoryId=';
  static const saveGelirAmountApi =
      '${_baseUrl}budgetPlanning/insertAmount.php';
  static const saveGelirSubCategoriesApi =
      '${_baseUrl}budgetPlanning/addSubcategories.php';
  static const deleteGelirAmountApi =
      '${_baseUrl}budgetPlanning/deleteAmount.php';
  static const deleteGelirSubCategoriesApi =
      '${_baseUrl}budgetPlanning/deleteSubcategories.php';
  static const updateGelirAmountApi =
      '${_baseUrl}budgetPlanning/updateAmount.php';

  static const getStoksApi = '${_baseUrl}currentMarket/stocksApi.php';

  static const getTotalAmountApi =
      '${_baseUrl}incomeExpenseCal/getTotalAmount.php';
  static const getBankTransactionHistoryApi =
      '${_baseUrl}incomeExpenseCal/bankTransactionHistory.php';
  static const getMaxExpenseApi =
      '${_baseUrl}incomeExpenseCal/getMaxExpense.php';
  static const getLastUpdatedData =
      '${_baseUrl}incomeExpenseCal/getLastUpdatedData.php';
  static const getLastUpdatedApi =
      '${_baseUrl}incomeExpenseCal/getLastUpdatedData.php';
  static const getExpenseQueryApi =
      '${_baseUrl}incomeExpenseCal/getExpenseQuery.php';
  static const getTotalExpensesApi =
      '${_baseUrl}incomeExpenseCal/getTotalExpenses.php';
  static const getMostExpensesApi =
      '${_baseUrl}incomeExpenseCal/getMostExpenses.php';
  static const getMinExpensesApi =
      '${_baseUrl}incomeExpenseCal/getMinExpenses.php';
}
