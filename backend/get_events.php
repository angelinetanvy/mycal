<?php

    error_reporting(E_ALL);
    ini_set('display_errors', 1);

    include 'db_connection.php';
    $con = openCon();

    $date = substr($_SERVER['QUERY_STRING'],5);
    echo $date;

    $sql = $con->query("SELECT *  FROM `Events` WHERE `event_start` LIKE '$date%'");

    $res =array();
    while($row=$sql->fetch_assoc())

    {
        $res[] = $row;
    }

    echo json_encode($res);

?>