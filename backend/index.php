<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = openCon();
    
    echo "Connected Successfully";
    closeCon($con);
?>