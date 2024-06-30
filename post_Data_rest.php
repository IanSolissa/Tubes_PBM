<?php
include ('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['start_time'])) {
    $start_time = $_POST['start_time'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Username tidak tersedia"]));
}
if (isset($_POST['end_time'])) {
    $end_time = $_POST['end_time'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nama tidak tersedia"]));
}
if (isset($_POST['id_laporan'])) {
    $id_laporan = $_POST['id_laporan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nama tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel user
$query = "INSERT INTO `rest` (`start_time`,`end_time`,`id_laporan`) VALUES ('$start_time', '$end_time', '$id_laporan')";
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