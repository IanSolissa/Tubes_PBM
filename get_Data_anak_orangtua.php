<?php
// Menggunakan file dbConnection.php untuk koneksi ke database
include('dbConnection.php');

// Fungsi untuk terhubung ke database
$con = connectdaycareDB();

// Memeriksa apakah parameter 'id_orangtua' ada dalam request POST
if (isset($_POST['id_orangtua'])) {
    $id_orangtua=$_POST['id_orangtua'];

    // Query SQL untuk mengambil data anak berdasarkan id_orangtua
    $query = "SELECT * FROM anak WHERE id_orangtua = '$id_orangtua'";
    
    $exe = mysqli_query($con, $query);

    // Array untuk menyimpan hasil query
    if ($exe) {
        $arr = [];

    // Mengambil setiap baris hasil query dan menyimpannya dalam array
    while ($row = mysqli_fetch_array($exe)) {
        $arr[] = $row;
    }
    
    $getId=$arr[0]['id'];
    $queryLaporanAnak = "SELECT * FROM laporan_anak WHERE id_anak ='$getId' ORDER BY id DESC limit 1 ";    
    $exeLaporanAnak = mysqli_query($con, $queryLaporanAnak);
    $arrLaporanAnak = [];
    // Mengambil setiap baris hasil query dan menyimpannya dalam array
    while ($row = mysqli_fetch_array($exeLaporanAnak)) {
        $arrLaporanAnak[] = $row;
    }
    // echo  json_encode($arr,JSON_PRETTY_PRINT);




    // Mengirimkan respons dalam format JSON
    if (empty($arr)) {
        header('Content-Type: application/json');
        
        echo json_encode(["status" => "Gagal", "message" => "Data anak tidak ditemukan"]);
    } else {
        // $arr+=['Laporan'=> $arrLaporanAnak];
        header('Content-Type: application/json');
        echo json_encode($arr, JSON_PRETTY_PRINT);
    }
} else {
    // Jika parameter 'id_orangtua' tidak ada dalam request POST
    header('Content-Type: application/json');
    echo json_encode(["status" => "Gagal", "message" => "Parameter 'id_orangtua' tidak tersedia"]);
}

}
else {
    echo json_encode(["status" => "Gagal", "message" => "Parameter 'id_orangtua' tidak tersedia"]);
    
}
    
    // Menutup koneksi ke database
mysqli_close($con);

    ?>
