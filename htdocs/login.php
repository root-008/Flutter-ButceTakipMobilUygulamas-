<?php
    include 'connection.php';

    $username = $_POST['username'];
    $password = $_POST['password'];

    $query = "SELECT * FROM users WHERE username = ?";
    $stmt = mysqli_prepare($db, $query);
    mysqli_stmt_bind_param($stmt, "s", $username);
    mysqli_stmt_execute($stmt);
    $result = mysqli_stmt_get_result($stmt);

    $count = mysqli_num_rows($result);

    if ($count == 1) {
        $row = mysqli_fetch_assoc($result);
        $hashedPassword = $row["password"];

        // Parolayı bcrypt ile doğrula
        if (password_verify($password, $hashedPassword)) {
            $user_id = $row["user_id"];
            $response = array("status" => "Success", "user_id" => $user_id);
            echo json_encode($response);
        } else {
            $response = array("status" => "Error");
            echo json_encode($response);
        }
    } else {
        $response = array("status" => "Error");
        echo json_encode($response);
    }

    mysqli_stmt_close($stmt); 
?>


