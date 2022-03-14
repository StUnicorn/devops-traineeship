<?php 

	$title = $_POST['title'];

	require 'db.php';

	$sql = 'INSERT INTO list(title) VALUES(:title)';

	$query = $pdo->prepare($sql);

	$query->execute(['title' => $title]);

	header('Location: index.php');
?>
