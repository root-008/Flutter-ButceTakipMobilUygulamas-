<?php
    include '../connection.php';

    $categoryId = $_GET['categoryId'];

    $query = "SELECT id, user_id, category_id, subcategory_name FROM butce_planlama_subcategories WHERE category_id = ?";
    
    $stmt = mysqli_prepare($db, $query);
    mysqli_stmt_bind_param($stmt, "i", $categoryId);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $res = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $res[] = $row;
    }

    echo json_encode($res);

    mysqli_stmt_close($stmt);
?>
