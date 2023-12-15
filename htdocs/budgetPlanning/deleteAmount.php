<?php
include '../connection.php';

$amountId = intval($_POST['amountId']);


// Tutar tablosundan veriyi sildikten sonra trigger oluşturup date tablosundan da veriyi silebiliriz.

$query = "DELETE FROM butce_planlama_tutar WHERE id = ?";
$stmt = mysqli_prepare($db, $query);
mysqli_stmt_bind_param($stmt, "i", $amountId);
$result = mysqli_stmt_execute($stmt);

 /*
    phpmayadmin kısmında bulunan trigger'ın kodunu aşağıya yapıştırıyorum

    DELIMITER //

    CREATE TRIGGER delete_date_after_delete_tutar
    AFTER DELETE ON butce_planlama_tutar
    FOR EACH ROW
    BEGIN
        DELETE FROM butce_planlama_dates WHERE id = OLD.time_id;
    END //

    DELIMITER ;

    show triggers diyerekte veritabanında bulunan trigersları görebiliriz.

 */


if ($result && $resultTrigger) {
    echo json_encode("Success");
} else {
    echo json_encode("Error");
}
?>
