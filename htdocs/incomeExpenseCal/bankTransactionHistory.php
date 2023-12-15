<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL bankTransactionHistory(?);";

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
    SELECT users.username, butce_planlama_categories.Category_name, butce_planlama_subcategories.subcategory_name, butce_planlama_dates.creation_time, butce_planlama_tutar.amount 
            FROM butce_planlama_tutar
            JOIN users ON users.user_id = butce_planlama_tutar.user_id
            JOIN butce_planlama_subcategories ON butce_planlama_subcategories.id = butce_planlama_tutar.subcategory_id
            JOIN butce_planlama_categories ON butce_planlama_categories.id = butce_planlama_subcategories.category_id
            JOIN butce_planlama_dates ON butce_planlama_dates.id = butce_planlama_tutar.time_id
            WHERE butce_planlama_tutar.user_id = ?
            ORDER BY butce_planlama_dates.creation_time DESC
    */
?>

