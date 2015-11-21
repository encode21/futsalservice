<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Main extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see http://codeigniter.com/user_guide/general/urls.html
	 */
	
	public function __construct()
	{
		parent::__construct();
		header('Access-Control-Allow-Origin: *');
	}
	public function index()
	{
		$resp = null;
		$cn = @fopen("http://198.50.174.69:80/","r");
			// system("ping -c 1 google.com", $resp);
		if ($cn) {
			$this->load->view('welcome_message');
			// echo "Connected";
		}else{
			echo "Not Connected to internet";
		}
	}
	public function cek_koneksi()
	{
		try {
			$resp = null;
			$cn = @fopen("http://198.50.174.69:80/","r");
			// system("ping -c 1 google.com", $resp);
			if ($cn) {
				$json['conn'] = "berhasil";
			}else{
				$json['conn'] = "tidak";
			}
		} catch (Exception $e) {
			$json['conn'] = "unknown";
			throw new Exception("Error Processing Request", 1);
		}
		echo json_encode($json);
	}
	public function p_daftar()
	{
		$data = json_decode(file_get_contents('php://input'), TRUE);
		try {
			$this->modelnya->funct_p_daftar($data);
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
		}
	}
	public function datauser()
	{
		$id = $this->input->get('id_user');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->funct_get_user($id);
		}
	}
	public function datateam()
	{
		$id = $this->input->get('id_team');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->funct_get_team($id);
		}
	}
	public function p_login()
	{
		$data = json_decode(file_get_contents('php://input'), TRUE);
		try {
			$this->modelnya->funct_login($data);
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
		}
	}
	public function ambil_tempatfutsal()
	{
		try {
			$json = $this->modelnya->f_ambil_tempatfutsal();
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
			$json = array('success'=>false);
		}
		echo json_encode($json);
	}
	public function ambil_tempatfutsalid()
	{
		$id = $this->input->get('id_lap');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->f_ambil_detailfutsal($id);
		}
	}
	public function ambil_bookingdipenyedia()
	{
		$id = $this->input->get('id_penyedia');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->f_ambilpenyedia_book($id);
		}
	}
	public function ambil_gallerylapangan()
	{
		$id = $this->input->get('id_lap');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->ambilgallery_lapangan($id);
		}
	}
	public function ambil_gallerylapanganLim()
	{
		$id = $this->input->get('id_lap');
		if ($id=="") {
			$json = array(
				'success' => false,
				'msg' => 'Data tidak ditemukan'
				);
			echo json_encode($json);
		}else{
			$this->modelnya->ambilgallery_lapanganLim($id);
		}
	}
	public function ambil_timeline()
	{
		try {
			$json = $this->modelnya->f_ambil_tl();
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
			$json = array('success'=>false);
		}
		echo json_encode($json);
	}
	public function listuser_chat()
	{
		$id_ses = $_GET['id'];
		try {
			$json = $this->modelnya->ambil_listuserchat($id_ses);
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
			$json = array('success'=>false);
		}
		echo json_encode($json);
	}
	public function isi_chat()
	{
		$id_peng = $_GET['id_peng'];
		$id_pen = $_GET['id_pen'];
		try {
			$json = $this->modelnya->ambil_isichat($id_peng,$id_pen);
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
			$json = array('success'=>false);
		}
		echo json_encode($json);
	}
	public function ambil_userid()
	{
		$iduser = $_GET['iduser'];
		try {
			$json = $this->modelnya->f_ambil_userid($iduser);
		} catch (Exception $e) {
			throw new Exception("Error Processing Request", 1);
			$json = array('success'=>false);
		}
		echo json_encode($json);
	}

	public function error_pagemissing()
	{
		show_404('User is not logged in', 50000);
	}
}
