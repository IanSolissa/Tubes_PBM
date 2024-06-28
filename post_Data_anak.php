<?php
include ('dbConnection.php'); // Pastikan file dbConnection.php sesuai dengan kebutuhan Anda
$con = connectdaycareDB(); // Fungsi untuk koneksi ke database

// Memeriksa dan mengambil nilai dari $_POST
if (isset($_POST['nama_lengkap'])) {
    $nama_lengkap = $_POST['nama_lengkap'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nama lengkap tidak tersedia"]));
}
if (isset($_POST['tanggal_lahir'])) {
    $tanggal_lahir = $_POST['tanggal_lahir'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Tanggal lahir tidak tersedia"]));
}
if (isset($_POST['jenis_kelamin'])) {
    $jenis_kelamin = $_POST['jenis_kelamin'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Jenis kelamin tidak tersedia"]));
}
if (isset($_POST['alamat_rumah'])) {
    $alamat_rumah = $_POST['alamat_rumah'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Alamat rumah tidak tersedia"]));
}
if (isset($_POST['nama_darurat'])) {
    $nama_darurat = $_POST['nama_darurat'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nama kontak darurat tidak tersedia"]));
}
if (isset($_POST['hubungan_darurat'])) {
    $hubungan_darurat = $_POST['hubungan_darurat'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Hubungan dengan darurat tidak tersedia"]));
}
if (isset($_POST['nomor_darurat'])) {
    $nomor_darurat = $_POST['nomor_darurat'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Nomor telepon darurat tidak tersedia"]));
}
if (isset($_POST['riwayat_medis'])) {
    $riwayat_medis = $_POST['riwayat_medis'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "Riwayat medis tidak tersedia"]));
}
if (isset($_POST['id_orangtua'])) {
    $id_orangtua = $_POST['id_orangtua'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "ID orang tua tidak tersedia"]));
}
if (isset($_POST['id_pengasuh'])) {
    $id_pengasuh = $_POST['id_pengasuh'];
} else {
    die(json_encode(["status" => "Gagal", "message" => "ID orang tua tidak tersedia"]));
}

// Query SQL untuk menyisipkan data ke dalam tabel anak
$query = "INSERT INTO `anak` (`nama_lengkap`, `tanggal_lahir`, `jenis_kelamin`, `alamat_rumah`, `nama_darurat`, `hubungan_darurat`, `nomor_darurat`, `riwayat_medis`, `id_orangtua`,`id_pengasuh`) 
          VALUES ('$nama_lengkap', '$tanggal_lahir', '$jenis_kelamin', '$alamat_rumah', '$nama_darurat', '$hubungan_darurat', '$nomor_darurat', '$riwayat_medis', '$id_orangtua','$id_pengasuh')";
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
