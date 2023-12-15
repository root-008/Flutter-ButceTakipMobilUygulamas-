<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $database = "finansapp";

    
    $db = mysqli_connect($servername, $username, $password, $database);

    
    if (!$db) {
        die("Veritabanı bağlantısı başarısız: " . mysqli_connect_error());
    }

    

    
    
?>
