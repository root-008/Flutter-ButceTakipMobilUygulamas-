<?php
    include '../connection.php';

    date_default_timezone_set('Europe/Istanbul');

    $userId = (int)$_POST['userId'];
    $subCategory_id = (int)$_POST['subCategory_id'];
    $amount = (float)$_POST['amount'];

    $date = date('Y-m-d H:i:s');

    //tutar eklemek istediğimiz kategori tutar tablosunda bulunuyor mu kontrol ediyoruz 
    $checkSql = "SELECT * FROM butce_planlama_tutar WHERE user_id=? AND subcategory_id=?";
    $checkStmt = mysqli_prepare($db, $checkSql);
    mysqli_stmt_bind_param($checkStmt, "ii", $userId, $subCategory_id);
    mysqli_stmt_execute($checkStmt);
    $checkResult = mysqli_stmt_get_result($checkStmt);

    if (mysqli_num_rows($checkResult) > 0) {
        //eğer kategori var ise 
        $row = mysqli_fetch_assoc($checkResult);
        $timeId = $row['time_id'];
        //eski tutarın üzerine tutarı ekliyoruz
        $updateSql = "UPDATE butce_planlama_tutar SET amount = amount + ? WHERE user_id=? AND subcategory_id=?";
        $updateStmt = mysqli_prepare($db, $updateSql);
        mysqli_stmt_bind_param($updateStmt, "dii", $amount, $userId, $subCategory_id);
        $updateResult = mysqli_stmt_execute($updateStmt);
        //ve tutarın güncellenme tarihini dates tablosunda güncelliyoruz
        $updateDateSql = "UPDATE butce_planlama_dates SET update_time = ? WHERE id = ?";
        $updateDateStmt = mysqli_prepare($db, $updateDateSql);
        mysqli_stmt_bind_param($updateDateStmt, "si", $date, $timeId);
        $updateDateResult = mysqli_stmt_execute($updateDateStmt);

        if ($updateResult && $updateDateResult) {
            echo json_encode("Success");
        } else {
            echo json_encode("Error");
        }

        mysqli_stmt_close($updateStmt); // İkinci sorgu ifadesini kapat
        mysqli_stmt_close($updateDateStmt); // Üçüncü sorgu ifadesini kapat
    } else {
        //eğer kategori yok ise
        $insertDateSql = "INSERT INTO butce_planlama_dates(id, creation_time, update_time) VALUES (null, ?, ?)";
        $insertDateStmt = mysqli_prepare($db, $insertDateSql);
        mysqli_stmt_bind_param($insertDateStmt, "ss", $date, $date);
        $insertDateResult = mysqli_stmt_execute($insertDateStmt);

        if ($insertDateResult) {
            $dateId = mysqli_insert_id($db);
            //tutar tablosuna o kategoriye ait tutar bilgisini ekliyoruz
            $insertSql = "INSERT INTO butce_planlama_tutar (id, user_id, subcategory_id, time_id, amount) VALUES (null, ?, ?, ?, ?)";
            $insertStmt = mysqli_prepare($db, $insertSql);
            mysqli_stmt_bind_param($insertStmt, "iiid", $userId, $subCategory_id, $dateId, $amount);
            $insertResult = mysqli_stmt_execute($insertStmt);

            if ($insertResult) {
                echo json_encode("Success");
            } else {
                echo json_encode("Error");
            }

            mysqli_stmt_close($insertStmt); // Dördüncü sorgu ifadesini kapat
        } else {
            echo json_encode("Error");
        }

        mysqli_stmt_close($insertDateStmt); // Beşinci sorgu ifadesini kapat
    }

    mysqli_stmt_close($checkStmt); // İlk sorgu ifadesini kapat
?>
