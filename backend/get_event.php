<?php

    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = openCon();

    $id = substr($_SERVER['QUERY_STRING'],3);
    echo $id;

    $sql = $con->query("SELECT *  FROM `Events` WHERE `event_id` = '$id'");

    $res =array();
    while($row=$sql->fetch_assoc())
    {
        $res[] = $row;
    }

    echo json_encode($res);

?>