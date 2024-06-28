<?php
include('dbConnection.php'); // Sesuaikan dengan file dbConnection.php Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['key'])) {
    $key = $_POST['key'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Key tidak tersedia"]));
}
if (isset($_POST['quantity'])) {
    $quantity = $_POST['quantity'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Quantity tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel item
$query = "INSERT INTO `item` (`key`, `quantity`) VALUES ('$key', '$quantity')";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data item berhasil disimpan"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data item: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>