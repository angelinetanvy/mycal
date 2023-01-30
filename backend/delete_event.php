<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = openCon();
    $id = $_POST['id'];

    $con -> query("DELETE FROM Events WHERE `Events`.`event_id` = '$id'");

    closeCon();

?>