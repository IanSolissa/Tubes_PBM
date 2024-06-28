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

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($result) {
    if (mysqli_num_rows($result) > 0) {
        // Mengambil hasil query
        $row = mysqli_fetch_assoc($result);
        // Menyusun respons dalam bentuk array asosiatif
        $response = [
            "status" => "Berhasil",
            "message" => "Data ditemukan",
            "data" => [
                "id" => $row['id'],
                "username" => $row['username'],
                "password" => $row['password']
            ]
        ];
    } else {
        $response = ["status" => "Gagal", "message" => "Username atau Password tidak cocok"];
    }
} else {
    $response = ["status" => "Gagal", "message" => "Terjadi kesalahan: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>