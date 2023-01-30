<?php
    function openCon() {
        $dbhost = "127.0.0.1";
        $dbuser = "pma";
        $dbpass = "";
        $db = "mycal";
        $con = new mysqli($dbhost, $dbuser, $dbpass,$db) or die("Error: %s\n". $conn -> error);

        return $con;
    }
 
    function closeCon($con) {
        $con -> close();
    }
   
?>