<?php
include ('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['id_anak'])) {
    $id_anak = $_POST['id_anak'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Id anak tidak tersedia"]));
}
if (isset($_POST['arrival_time'])) {
    $arrival_time = $_POST['arrival_time'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "arrival tidak tersedia"]));
}
if (isset($_POST['temperature'])) {
    $temperature = $_POST['temperature'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "temperatur tidak tersedia"]));
}
if (isset($_POST['kondisi'])) {
    $kondisi = $_POST['kondisi'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "kondisi tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel laporan_anak
$query = "INSERT INTO `laporan_anak` (`id_anak`, `arrival_time`, `temperature`, `kondisi`) 
          VALUES ('$id_anak', '$arrival_time', '$temperature', '$kondisi')";

// Menjalankan query
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    // Mengambil id_anak yang baru saja dimasukkan
    $new_id = mysqli_insert_id($con);

    $response = ["status" => "Berhasil", "message" => "Data berhasil disimpan", "new_id" => $new_id];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>
