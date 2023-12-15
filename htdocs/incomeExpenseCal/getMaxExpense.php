<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL getMaxExpense(?)";

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
        SELECT bpc.Category_name, bps.subcategory_name, bpt.amount
                FROM butce_planlama_tutar AS bpt
                JOIN butce_planlama_subcategories AS bps ON bpt.subcategory_id = bps.id
                JOIN butce_planlama_categories AS bpc ON bps.category_id = bpc.id
                JOIN butce_planlama_dates AS bpd ON bpt.time_id = bpd.id
                WHERE MONTH(bpd.creation_time) = MONTH(CURRENT_DATE()) AND bpc.Category_name != 'Gelir' AND bpt.user_id = ?
                ORDER BY bpt.amount DESC LIMIT 1
    */
?>
