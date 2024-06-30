<?php
include ('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['waktu'])) {
    $waktu = $_POST['waktu'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "item tidak tersedia"]));
}
if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "item tidak tersedia"]));
}
if (isset($_POST['kondisi'])) {
    $kondisi = $_POST['kondisi'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "item tidak tersedia"]));
}
if (isset($_POST['catatan'])) {
    $catatan = $_POST['catatan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "item tidak tersedia"]));
}
if (isset($_POST['id_laporan'])) {
    $id_laporan = $_POST['id_laporan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "item tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel user
$query = "INSERT INTO `toilet` (`waktu`, `type`,`kondisi`,`catatan`,`id_laporan`) VALUES ('$waktu', '$type', '$kondisi','$catatan','$id_laporan')";
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