<?php
include('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['username']) && isset($_POST['nama']) && isset($_POST['password'])) {
    $username = $_POST['username'];
    $nama = $_POST['nama'];
    $password = $_POST['password'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Data tidak lengkap"]));
}

// Query SQL untuk melakukan update data di dalam tabel user berdasarkan username
$query = "UPDATE `user` SET `nama`='$nama', `password`='$password' WHERE `username`='$username'";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data berhasil diperbarui"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal memperbarui data: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>
