<?php
    include '../connection.php';

    $userId = (int)$_POST['userId'];
    $subCategoryName = $_POST['gelirType'];
    $categoryId = $_POST['categoryId'];
    
    $checkSql = "SELECT * FROM butce_planlama_subcategories
        WHERE user_id = ? AND subcategory_name = ?";
    
    $checkStmt = mysqli_prepare($db, $checkSql);
    mysqli_stmt_bind_param($checkStmt, "is", $userId, $subCategoryName);
    mysqli_stmt_execute($checkStmt);
    $checkResult = mysqli_stmt_get_result($checkStmt);

    if(mysqli_num_rows($checkResult) > 0){
        echo json_encode("Error");
    }else{
        $insertSql = "INSERT INTO butce_planlama_subcategories (`id`, `user_id`, `category_id`, `subcategory_name`)
         VALUES (null,?,?,?)";

        $insertStmt = mysqli_prepare($db, $insertSql);
        mysqli_stmt_bind_param($insertStmt, "iis", $userId, $categoryId, $subCategoryName);
        $insertResult = mysqli_stmt_execute($insertStmt);

        if($insertResult){
            echo json_encode("Success");
        }else{
            echo json_encode("Error");
        }
    }

    mysqli_stmt_close($checkStmt);
    mysqli_stmt_close($insertStmt);
?>
