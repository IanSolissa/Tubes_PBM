<?php
include ('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
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
    die(json_encode(["status" => "Gagal", "message" => "Nama tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel user
$query = "INSERT INTO `user` (`username`, `password`) VALUES ('$username', '$password')";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data berhasil disimpan"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>