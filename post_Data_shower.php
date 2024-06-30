<?php
include('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['morning_shower'])) {
    $morning_shower = $_POST['morning_shower'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Mandi pagi tidak tersedia"]));
}
if (isset($_POST['evening_shower'])) {
    $evening_shower = $_POST['evening_shower'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Mandi malam tidak tersedia"]));
}
if (isset($_POST['id_laporan'])) {
    $id_laporan = $_POST['id_laporan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Mandi malam tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel shower
$query = "INSERT INTO `shower` (`morning_shower`, `evening_shower`, `id_laporan`) VALUES ('$morning_shower', '$evening_shower', '$id_laporan')";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data shower berhasil disimpan"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data shower: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>
