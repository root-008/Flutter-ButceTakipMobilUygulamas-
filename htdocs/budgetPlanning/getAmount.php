<?php
    include '../connection.php';

    $user_id = $_POST['token'];
    $categoryId = $_POST['categoryId'];
    $startDate = $_POST['startDate'];
    $endDate = $_POST['endDate'];

    
    $user_id = mysqli_real_escape_string($db, $user_id);
    $categoryId = mysqli_real_escape_string($db, $categoryId);
    $startDate = mysqli_real_escape_string($db, $startDate);
    $endDate = mysqli_real_escape_string($db, $endDate);

    

    $query = "CALL getAmount('$categoryId','$user_id','$startDate','$endDate');";

    $result = mysqli_query($db, $query);

    if ($result) {
        $res = array();
        while ($row = mysqli_fetch_assoc($result)) {
            $res[] = $row;
        }

        echo json_encode($res);
    } else {
        echo json_encode("Error in query execution: " . mysqli_error($db));
    }

    /*DELIMITER //

CREATE PROCEDURE GetirilenVerileriFiltrele (
    IN categoryId INT,
    IN user_id INT,
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    SELECT t.id, s.subcategory_name, t.amount, d.creation_time, d.update_time
    FROM butce_planlama_tutar AS t
    INNER JOIN butce_planlama_subcategories AS s ON t.subcategory_id = s.id
    INNER JOIN butce_planlama_categories AS c ON s.category_id = c.id
    INNER JOIN butce_planlama_dates AS d ON t.time_id = d.id
    WHERE c.id = categoryId 
    AND t.user_id = user_id 
    AND d.creation_time >= startDate 
    AND d.creation_time <= endDate;
END //

DELIMITER ;*/
/*SELECT t.id, s.subcategory_name, t.amount, d.creation_time, d.update_time
        FROM butce_planlama_tutar AS t
        INNER JOIN butce_planlama_subcategories AS s ON t.subcategory_id = s.id
        INNER JOIN butce_planlama_categories AS c ON s.category_id = c.id
        INNER JOIN butce_planlama_dates AS d ON t.time_id = d.id
        WHERE c.id = '$categoryId' 
        AND t.user_id = '$user_id' 
        AND d.creation_time >= '$startDate' 
        AND d.creation_time <= '$endDate'*/
?>
