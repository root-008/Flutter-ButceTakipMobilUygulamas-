<?php
    include '../connection.php';

    $user_id = intval($_POST['token']);

    $query = "
    CALL GetMinAmountForCategory(?);
    ";

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

    

?>