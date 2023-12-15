<?php
    include '../connection.php';

    date_default_timezone_set('Europe/Istanbul');

    $amountId = (int)$_POST['amountId'];
    $amount = (float)$_POST['amount'];

    $date = date('Y-m-d H:i:s');

    $selectTime = "SELECT time_id FROM butce_planlama_tutar WHERE id=?";
    $selectStmt = mysqli_prepare($db, $selectTime);
    mysqli_stmt_bind_param($selectStmt, "i", $amountId);
    mysqli_stmt_execute($selectStmt);
    $selectResult = mysqli_stmt_get_result($selectStmt);
    $row = mysqli_fetch_assoc($selectResult);
    $timeId = $row['time_id'];

    $updateQuery = "UPDATE butce_planlama_tutar SET amount=? WHERE id=?";
    $updateStmt = mysqli_prepare($db, $updateQuery);
    mysqli_stmt_bind_param($updateStmt, "di", $amount, $amountId);
    $updateResult = mysqli_stmt_execute($updateStmt);

    $updateDateQuery = "UPDATE butce_planlama_dates SET update_time=? WHERE id=?";
    $updateDateStmt = mysqli_prepare($db, $updateDateQuery);
    mysqli_stmt_bind_param($updateDateStmt, "si", $date, $timeId);
    $updateDateResult = mysqli_stmt_execute($updateDateStmt);

    if ($updateResult && $updateDateResult) {
        echo json_encode("Success");
    } else {
        echo json_encode("Error");
    }

    mysqli_stmt_close($selectStmt); // İlk sorgu ifadesini kapat
    mysqli_stmt_close($updateStmt); // İkinci sorgu ifadesini kapat
    mysqli_stmt_close($updateDateStmt); // Üçüncü sorgu ifadesini kapat
?>
