<?php
include('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['username'])) {
    $username = $_POST['username'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Username tidak tersedia"]));
}
if (isset($_POST['password'])) {
    $password = $_POST['password'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Password tidak tersedia"]));
}

// Query SQL untuk select data dari tabel user berdasarkan username dan password
$query = "SELECT * FROM `user` WHERE `username`='$username' AND `password`='$password'";
$result = mysqli_query($con, $query);
$exe=mysqli_query($con,$query);

// Memeriksa apakah query berhasil dijalankan atau tidak
    $arr=[];
while ($row = mysqli_fetch_array($exe)) {
    $arr[]=$row;
}
header('Content-Type: application/json');
echo json_encode($arr,JSON_PRETTY_PRINT);
     
if ($exe==false) {
    echo json_encode($result);
    # code...
}


// Menutup koneksi ke database
mysqli_close($con);
?>