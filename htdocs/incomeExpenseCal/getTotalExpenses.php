<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL GetTotalExpenses(?)";

    $stmt = mysqli_prepare($db, $query);
    mysqli_stmt_bind_param($stmt, "i", $user_id);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $data = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $data[] = $row;
    }

    mysqli_stmt_close($stmt); 

    echo json_encode($data);

    /*
        SELECT c.Category_name, SUM(t.amount) AS total_expense
        FROM users u
        JOIN butce_planlama_subcategories sc ON u.user_id = sc.user_id
        JOIN butce_planlama_tutar t ON sc.id = t.subcategory_id
        JOIN butce_planlama_categories c ON sc.category_id = c.id
        WHERE u.user_id = ? AND c.Category_name != 'Gelir'
        GROUP BY c.id;
    */
?>
