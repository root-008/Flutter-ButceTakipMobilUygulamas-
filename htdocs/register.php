<?php
    include 'connection.php';

    $username = $_POST['username'];
    $password = $_POST['password'];

    // Parolayı bcrypt ile şifrele
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);

    $checkQuery = "SELECT * FROM users WHERE username = ?";
    $checkStmt = mysqli_prepare($db, $checkQuery);
    mysqli_stmt_bind_param($checkStmt, "s", $username);
    mysqli_stmt_execute($checkStmt);
    $checkResult = mysqli_stmt_get_result($checkStmt);

    $count = mysqli_num_rows($checkResult);

    if ($count == 1) {
        $response = array("status" => "Error");
        echo json_encode($response);
    } else {
        $insertQuery = "INSERT INTO users (username, password) VALUES (?, ?)";
        $insertStmt = mysqli_prepare($db, $insertQuery);
        mysqli_stmt_bind_param($insertStmt, "ss", $username, $hashedPassword);
        $insertResult = mysqli_stmt_execute($insertStmt);

        if ($insertResult) {
            $response = array("status" => "Success");
            echo json_encode($response);
        } else {
            $response = array("status" => "Error");
            echo json_encode($response);
        }
    }

    mysqli_stmt_close($checkStmt); 
    mysqli_stmt_close($insertStmt); 
?>


