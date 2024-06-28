<?php
function connectdaycareDB()
{
    $con=mysqli_connect('localhost','root','','daycare_app');

    return $con;
}?>