<?php
include('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['username'])) {
    $username = $_POST['username'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Username tidak tersedia"]));
}

// Query SQL untuk melakukan delete data dari tabel user berdasarkan username
$query = "DELETE FROM `user` WHERE `username`='$username'";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data berhasil dihapus"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menghapus data: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>
