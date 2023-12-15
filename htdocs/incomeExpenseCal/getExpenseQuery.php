<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL getExpenseQuery(?)";

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
        SELECT
                COALESCE(SUM(t.amount), 0) AS this_month_expenses,
                COALESCE((SELECT SUM(t2.amount)
                        FROM butce_planlama_tutar AS t2
                        INNER JOIN butce_planlama_dates AS d2 ON t2.time_id = d2.id
                        WHERE t2.user_id = t.user_id
                            AND MONTH(d2.creation_time) = MONTH(CURRENT_DATE) - 1
                            AND YEAR(d2.creation_time) = YEAR(CURRENT_DATE)), 0) AS previous_month_expenses
            FROM butce_planlama_tutar AS t
            INNER JOIN butce_planlama_dates AS d ON t.time_id = d.id
            WHERE MONTH(d.creation_time) = MONTH(CURRENT_DATE)
            AND YEAR(d.creation_time) = YEAR(CURRENT_DATE)
            AND t.user_id = ?
            AND t.subcategory_id NOT IN (SELECT id FROM butce_planlama_subcategories WHERE category_id = 1) 
            GROUP BY t.user_id
    */
?>
