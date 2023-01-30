<?php
    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = openCon();
    
    $id = $_POST['id'];
    $title = $_POST['title'];
    $detail = $_POST['detail'];
    $start = $_POST['start'];
    $end = $_POST['end'];
    $loc = $_POST['location'];

    $con->query("INSERT INTO `Events`(`event_id`, `event_title`, `event_detail`, `event_start`, `event_end`, `event_location`) VALUES('".$id."','".$title."','".$detail."','".$start."','".$end."','".$loc."')");

    closeCon();
?>