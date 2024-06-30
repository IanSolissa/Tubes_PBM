<?php
// Menggunakan file dbConnection.php untuk koneksi ke database
include('dbConnection.php');

// Fungsi untuk terhubung ke database
$con = connectdaycareDB();
$result=[];
// Memeriksa apakah parameter 'id_orangtua' ada dalam request POST
if (1==1) {
    // $id_anak = $_POST['id_anak'];
    $querylaporan = "SELECT * FROM laporan_anak WHERE id_anak = '25' ORDER BY id DESC LIMIT 1 " ;
    $exelaporan = mysqli_query($con, $querylaporan);
    $laporan=[];
    while ($row = mysqli_fetch_array($exelaporan)) {
        $laporan[] = $row;
        // print $row[];
    }
    // echo json_encode($laporan[0]['id']);
$result+=['laporan'=> $laporan];
// echo json_encode($result);
    $get_id= $laporan[0]["id"];
    // $get_id=11;
    
    // -------------- MEALS
    $querymeals = "SELECT * FROM meals WHERE id_laporan ='$get_id'" ;
    $exemeals = mysqli_query($con, $querymeals);
    $meal=[];
    while ($row = mysqli_fetch_array($exemeals)) {
        $meal[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['meal'=> $meal];
    // echo json_encode($meal);
    
    // echo $meal[0]['id'];


    // -------------- Toilet
    $querytoilet = "SELECT * FROM toilet WHERE id_laporan ='$get_id'" ;
    $exetoilet = mysqli_query($con, $querytoilet);
    $toilet=[];
    while ($row = mysqli_fetch_array($exetoilet)) {
        $toilet[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['toilet'=> $toilet];
    // echo json_encode($toilet);
    
    
    


    // -------------- rest
    $queryrest = "SELECT * FROM rest WHERE id_laporan ='$get_id'" ;
    $exerest = mysqli_query($con, $queryrest);
    $rest=[];
    while ($row = mysqli_fetch_array($exerest)) {
        $rest[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['rest'=> $rest];
    // echo json_encode($rest);
    


    // -------------- bottle
    $querybottle = "SELECT * FROM bottle WHERE id_laporan ='$get_id'" ;
    $exebottle = mysqli_query($con, $querybottle);
    $bottle=[];
    while ($row = mysqli_fetch_array($exebottle)) {
        $bottle[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['bottle'=> $bottle];
    // echo json_encode($bottle);
    
    // echo $bottle[0]['id'];



    // -------------- vitamin
    $queryvitamin = "SELECT * FROM vitamin WHERE id_laporan ='$get_id'" ;
    $exevitamin = mysqli_query($con, $queryvitamin);
    $vitamin=[];
    while ($row = mysqli_fetch_array($exevitamin)) {
        $vitamin[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['vitamin'=> $vitamin];
    // echo json_encode($vitamin);
    
    // echo $vitamin[0]['id'];



    // -------------- item
    $queryitem = "SELECT * FROM item WHERE id_laporan ='$get_id'" ;
    $exeitem = mysqli_query($con, $queryitem);
    $item=[];
    while ($row = mysqli_fetch_array($exeitem)) {
        $item[] = $row;
        // print $row[];
    // print("ADA");
    }
    $result+=['item'=> $item];
    // echo json_encode($item);
    
    // echo $item[0]['id'];
    

    header('Content-Type: application/json');

    echo json_encode($result,JSON_PRETTY_PRINT);


}
// Menutup koneksi ke database
mysqli_close($con);
?>
