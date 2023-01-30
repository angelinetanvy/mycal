<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = OpenCon();
    
    $id = $_POST['id'];
    $title = $_POST['title'];
    $detail = $_POST['detail'];
    $start = $_POST['start'];
    $end = $_POST['end'];
    $loc = $_POST['location'];

    $con -> query("UPDATE `Events` SET `event_title` = '$title', `event_detail` = '$detail', `event_start` = '$start', `event_end` = '$end', `event_location` = '$loc' WHERE `Event`.`event_id` = '$id'");

    closeCon();
?>