<?php
    
    include '../connection.php';

    $userId = intval($_POST['userId']);
    $subCategoryId = intval($_POST['selectedCategory']);
    $categoryId = intval($_POST['categoryId']);

    // tutar tablosunda o kategoriye ait veri var mı kontrol et
    $checkSql = "SELECT * FROM butce_planlama_tutar WHERE user_id = ? AND subcategory_id = ?";
    $stmtCheck = mysqli_prepare($db, $checkSql);
    mysqli_stmt_bind_param($stmtCheck, "ii", $userId, $subCategoryId);
    mysqli_stmt_execute($stmtCheck);
    $checkResult = mysqli_stmt_get_result($stmtCheck);

    if(mysqli_num_rows($checkResult) > 0) {
        // eğer kayıt varsa, önce ilgili kayıtları tutar tablosundan sil
        $deleteSql = "DELETE FROM butce_planlama_tutar WHERE subcategory_id = ? AND user_id = ?";
        $stmtDelete = mysqli_prepare($db, $deleteSql);
        mysqli_stmt_bind_param($stmtDelete, "ii", $subCategoryId, $userId);
        $deleteResult = mysqli_stmt_execute($stmtDelete);

        if(!$deleteResult) {
            echo json_encode("Error");
            exit();
        }
    }

     // kayıt yoksa ya da kayıtlar başarıyla silindi ise kategoriyi sil
    $deleteSubcategorySql = "DELETE FROM butce_planlama_subcategories WHERE id = ? AND user_id = ? AND category_id = ?";
    $stmtDeleteSubcategory = mysqli_prepare($db, $deleteSubcategorySql);
    mysqli_stmt_bind_param($stmtDeleteSubcategory, "iii", $subCategoryId, $userId, $categoryId);
    $deleteSubcategoryResult = mysqli_stmt_execute($stmtDeleteSubcategory);

    if($deleteSubcategoryResult) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error");
    
    }




?>

