<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL getLastUpdatedData(?)";

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
        SELECT c.Category_name, sc.subcategory_name, t.amount
                FROM butce_planlama_tutar AS t
                JOIN butce_planlama_subcategories AS sc ON t.subcategory_id = sc.id
                JOIN butce_planlama_categories AS c ON sc.category_id = c.id
                JOIN butce_planlama_dates AS d ON t.time_id = d.id
                WHERE t.user_id = ?
                ORDER BY d.update_time DESC
                LIMIT 1
    */

?>
