<?php
include ('dbConnection.php');
$con=connectdaycareDB();
$query='Select * from `anak`';
$exe=mysqli_query($con,$query);

$arr=[];
while ($row = mysqli_fetch_array($exe)) {
    $arr[]=$row;
}
header('Content-Type: application/json');
echo json_encode($arr,JSON_PRETTY_PRINT);
mysqli_close($con);                 
?>