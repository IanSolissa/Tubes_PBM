<?php
// Menggunakan file dbConnection.php untuk koneksi ke database
include('dbConnection.php');

// Fungsi untuk terhubung ke database
$con = connectdaycareDB();
$result=[];
// Memeriksa apakah parameter 'id_orangtua' ada dalam request POST
if (isset($_POST['id_anak'])) {
    $id_anak = $_POST['id_anak'];
    $querylaporan = "SELECT * FROM laporan_anak WHERE id_anak = '$id_anak' ORDER BY id DESC LIMIT 1 " ;
    $exelaporan = mysqli_query($con, $querylaporan);
    $laporan=[];
    while ($row = mysqli_fetch_array($exelaporan)) {
        $laporan[] = $row;
        // print $row[];
    }
    if (empty($laporan)) {

        # code...
    }else {
        echo json_encode($laporan,JSON_PRETTY_PRINT);
    }}
    mysqli_close($con);

?>