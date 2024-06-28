<?php
include ('dbConnection.php');
$con=connectdaycareDB();
if (isset($_POST['id_anak'])) {
    $id_anak=$_POST['id_anak'];
    
}else{

    $id_anak=null;
    // $id_anak=2;

}
if ($id_anak) {
    # code...
    $query="Select * from `anak` where `id`='$id_anak'";
    $exe=mysqli_query($con,$query);
    
    if ($exe ) {
        # code...
        $arr=[];
        while ($row = mysqli_fetch_array($exe)) {
            $arr[]=$row;
        }
        header('Content-Type: application/json');
        echo json_encode($arr,JSON_PRETTY_PRINT);
    } else {
        
        $arr=["status" => "Gagal", "message" => "Data ditemukan"];
        echo json_encode($arr,JSON_PRETTY_PRINT);
        // echo json_encode($arr,JSON_PRETTY_PRINT);
        # code...
    }
}
else {
    $arr=["status" => "Gagal", "message" => "Data tidak lengkap"];
    // $arr=['Status']['Gagal'];
    // $arr[[]]=['Gagal']
    echo json_encode($arr,JSON_PRETTY_PRINT);
    
}
mysqli_close($con);                 

?>