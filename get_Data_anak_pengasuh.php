<?php
include ('dbConnection.php');
$con=connectdaycareDB();

if (isset($_POST['id_pengasuh'])) {
    $id_pengasuh=$_POST['id_pengasuh'];
    # code...
}else{
    die(json_encode(["status" => "Gagal", "message" => "Item tidak tersedia"]));
}

if ($id_pengasuh!=null||$id_pengasuh!="") {
    # code...
    $query="Select * from `anak` where id_pengasuh='$id_pengasuh'";
    $exe=mysqli_query($con,$query);
    
    $arr=[];
    while ($row = mysqli_fetch_array($exe)) {
        $arr[]=$row;
    }
    header('Content-Type: application/json');
    echo json_encode($arr,JSON_PRETTY_PRINT);
}

mysqli_close($con);                 
?>