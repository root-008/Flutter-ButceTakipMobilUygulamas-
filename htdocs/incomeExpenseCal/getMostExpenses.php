<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "CALL GetMostRepeatedCategory(?)";

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
        SELECT bpc.Category_name, COUNT(*) AS repetition_count
        FROM butce_planlama_tutar bpt
        JOIN butce_planlama_subcategories bps ON bpt.subcategory_id = bps.id
        JOIN butce_planlama_categories bpc ON bps.category_id = bpc.id
        WHERE bpt.user_id = ? AND bpc.Category_name != 'Gelir'   AND MONTH(bpd.creation_time) = MONTH(CURDATE())
        AND YEAR(bpd.creation_time) = YEAR(CURDATE())
        GROUP BY bpc.Category_name
        ORDER BY repetition_count DESC
        LIMIT 1;   
    */

?>