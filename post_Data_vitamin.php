<?php
include('dbConnection.php'); // Sesuaikan dengan file dbConnection.php Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['vitamin_name'])) {
    $vitamin_name = $_POST['vitamin_name'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nama vitamin tidak tersedia"]));
}
if (isset($_POST['amount'])) {
    $amount = $_POST['amount'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Jumlah tidak tersedia"]));
}
if (isset($_POST['time'])) {
    $time = $_POST['time'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Waktu tidak tersedia"]));
}
if (isset($_POST['id_laporan'])) {
    $id_laporan = $_POST['id_laporan'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Waktu tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel vitamin
$query = "INSERT INTO `vitamin` (`vitamin_name`, `amount`, `time`, `id_laporan`) VALUES ('$vitamin_name', '$amount', '$time', '$id_laporan')";
$exe = mysqli_query($con, $query);

// Memeriksa apakah query berhasil dijalankan atau tidak
if ($exe) {
    $response = ["status" => "Berhasil", "message" => "Data vitamin berhasil disimpan"];
} else {
    $response = ["status" => "Gagal", "message" => "Gagal menyimpan data vitamin: " . mysqli_error($con)];
}

// Mengembalikan respons dalam format JSON
echo json_encode($response);

// Menutup koneksi ke database
mysqli_close($con);
?>
