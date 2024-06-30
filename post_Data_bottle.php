<?php
include('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['time'])) {
    $time = $_POST['time'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Item tidak tersedia"]));
}
if (isset($_POST['ML'])) {
    $ML = $_POST['ML'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Item tidak tersedia"]));
}
if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Item tidak tersedia"]));
}
if (isset($_POST['id_laporan'])) {
    $id_laporan = $_POST['id_laporan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Item tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel bottle
$query = "INSERT INTO `bottle` (`time`, `ML`, `type`,`id_laporan`) VALUES ('$time', '$ML', '$type', '$id_laporan')";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data bottle berhasil disimpan"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data bottle: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>