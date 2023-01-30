<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $conn = OpenCon();
    $id = $_POST['id'];

    $conn -> query("DELETE FROM Event WHERE `Events`.`event_id` = '$id'");

?>