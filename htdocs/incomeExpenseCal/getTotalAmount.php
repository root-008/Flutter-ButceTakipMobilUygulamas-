<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL getTotalAmount(?)";

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
            (SELECT SUM(amount) 
                FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON 
                    t.subcategory_id = s.id WHERE s.category_id = 1 AND t.user_id = ?) AS gelirler,
            (SELECT SUM(amount) 
                FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON 
                    t.subcategory_id = s.id JOIN butce_planlama_categories c ON s.category_id = c.id WHERE c.id != 1 AND t.user_id = ?) AS giderler,
            ((SELECT SUM(amount) FROM butce_planlama_tutar t JOIN butce_planlama_subcategories s ON
                 t.subcategory_id = s.id WHERE s.category_id = 1 AND t.user_id = ?) - (SELECT SUM(amount) FROM butce_planlama_tutar t 
                    JOIN butce_planlama_subcategories s ON t.subcategory_id = s.id JOIN butce_planlama_categories c ON 
                        s.category_id = c.id WHERE c.id != 1 AND t.user_id = ?)) AS net_gelir
        FROM dual;
    */
?>
