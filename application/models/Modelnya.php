<?php

/**
* 
*/
class Modelnya extends CI_Model
{
	function funct_p_daftar($dt)
	{
		if ($dt=="") {
			$json = array('success' => false);
		}else {
			$json = array('success' => true,'data'=>$dt );
			
			/*Data User*/
			$dtuser = new stdClass();
			$dtuser->id_user = "";
			$dtuser->username = $dt['username'];
			$dtuser->password = $dt['pwd'];
			$dtuser->status = 'penyewa';
			$dtuser->aktif = 1;
			$q = $this->db->insert('user',$dtuser);
			$id = $this->db->insert_id();
			if ($q==TRUE) {
				/*Data Team*/
				$dtteam = new stdClass();
				$dtteam->id_team = "";
				$dtteam->id_user = $id;
				$dtteam->nama_team = $dt['nama'];
				$dtteam->ava_team = "default.png";
				$dtteam->telp_team = $dt['tlp'];
				$dtteam->jml_pemain_team = $dt['jml'];
				$dtteam->kota = $dt['reg'];
				$dtteam->email = $dt['email'];
				$dtteam->banned = "0";
				// echo $dtteam->nama."<br>";
				$qi = $this->db->insert('team',$dtteam);
				if ($qi==true) {
					$this->db->where('id_user',$id);
					$q = $this->db->get('user');
				}
				$json = array('id_user'=>$id);
			}
			// return $q->row();
		}
		echo json_encode($json);
	}
	function funct_login($data)
	{
		if ($data=="") {
			$json = array('success'=>false,'msg'=>'Data form tidak lengkap!');
		}else{
			$uname = $data['username'];
			$pwd = $data['password'];
			// $this->db->where('username',$uname);
			// $this->db->where('username',$pwd);
			$q=$this->db->query("SELECT * FROM user WHERE username='$uname' AND password='$pwd' AND aktif='1'");
			$r = $q->num_rows();
			if ($r>0) {
				$rdata = $q->row();
				$json = array('success'=>true,'id'=>$rdata->id_user,'statusUser'=>$rdata->status);
			}else{
				$json = array('success'=>false,'msg'=>'error_auth');
			}
		}
		echo json_encode($json);
	}
	function funct_get_user($id)
	{
		$this->db->where('id_user',$id);
		$q = $this->db->get('user');
		$res = $q->num_rows();
		if ($res>0) {
			$rdata = $q->row();
			$json = array('id_user' => $rdata->id_user,'username'=>$rdata->username );
			// $json = array($data);
		}else{
			$json = array('success'=>false,'msg'=>'Data user gagal di ambil.');
		}
		echo json_encode($json);
	}
	function funct_get_team($id)
	{
		$this->db->where('id_team',$id);
		$q = $this->db->get('team');
		$res = $q->num_rows();
		if ($res>0) {
			$rdata = $q->row();
			$json = array(
					'id_team' => $rdata->id_team,
					'id_user'=>$rdata->id_user,
					'nama_team' => $rdata->nama_team,
					'ava_team' => $rdata->ava_team,
					'telp_team' => $rdata->telp_team,
					'jml_pemain_team' => $rdata->jml_pemain_team,
					'regional_team' => $rdata->kota,
					'email_team' => $rdata->email
					 );
			// $json = array($data);
		}else{
			$json = array('success'=>false,'msg'=>'Data team gagal di ambil.');
		}
		echo json_encode($json);
	}

	/*After Login*/
	function f_ambil_tempatfutsal()
	{
		$q = $this->db->get('penyedia');
		return $q->result();
	}

	function f_ambil_detailfutsal($id)
	{
		// $this->db->where('id_penyedia',$id);
		// $q = $this->db->get('penyedia');
		$q = $this->db->query("SELECT p.* FROM penyedia p WHERE p.id_penyedia='$id'");
		$res = $q->num_rows();
		if ($res>0) {
			$json = $q->result();
			// $json = array($data);
		}else{
			$json = array('success'=>false,'msg'=>'Data gagal di ambil.');
		}
		echo json_encode($json);
	}
	function f_ambilpenyedia_book($id)
	{
		$q = $this->db->query("SELECT b.*,DATE_FORMAT(b.jam_booking, '%H:%i') as jam_booking,DATE_FORMAT(b.tgl_booking,'%d %M %Y') as tgl_booking,p.nama_team FROM booking b RIGHT JOIN team p ON b.id_penyewa=p.id_team WHERE b.id_penyedia=(SELECT id_penyedia FROM penyedia WHERE id_penyedia='$id')");
		$res = $q->num_rows();
		if ($res>0) {
			$json = $q->result();
			// $json = array($data);
		}else{
			$json = $q->result();
			// $json = array('success'=>false,'msg'=>'Data gagal di ambil.');
		}
		echo json_encode($json);	
	}
	function ambilgallery_lapanganLim($id)
	{
		$q = $this->db->query("SELECT l.status,l.foto_lapangan FROM lapangan l INNER JOIN penyedia p ON l.id_penyedia=p.id_penyedia WHERE p.id_penyedia='$id' LIMIT 4");
		$res = $q->num_rows();
		if ($res>0) {
			$json = $q->result();
			// $json = array($data);
		}else{
			$json = $q->result();
			// $json = array('success'=>false,'msg'=>'Data gagal di ambil.');
		}
		echo json_encode($json);
	}
	function ambilgallery_lapangan($id)
	{
		$q = $this->db->query("SELECT l.status,l.foto_lapangan FROM lapangan l INNER JOIN penyedia p ON l.id_penyedia=p.id_penyedia WHERE p.id_penyedia='$id'");
		$res = $q->num_rows();
		if ($res>0) {
			$json = $q->result();
			// $json = array($data);
		}else{
			$json = array('success'=>false,'msg'=>'Data gagal di ambil.');
		}
		echo json_encode($json);
	}
	function f_ambil_tl($value='')
	{
		$q = $this->db->query("SELECT tl.*,DATE_FORMAT(tl.tgl_post, '%d %M %Y') as tgl_post,DATE_FORMAT(tl.tgl_post, '%H:%i') as jam_post,t.id_team,t.nama_team,t.ava_team FROM timeline tl INNER JOIN team t ON tl.id_team=t.id_team WHERE tl.status='1'");
		return $q->result();
		
	}
	function ambil_listuserchat($id)
	{
		// $q = $this->db->query("SELECT * FROM chat_ c_ WHERE c_.id_penerima IN ('$id') OR c_.id_pengirim IN ('$id')");
		$q = $this->db->query("SELECT c.*,c_.*,t.ava_team,t.nama_team,t.id_user FROM chat_ c_ INNER JOIN chat c ON c.id_detail_chat=c_.id_chat_ LEFT JOIN team t ON t.id_user=c_.id_penerima WHERE c.dari IN (c_.id_penerima,c_.id_pengirim) OR c.ke IN (c_.id_penerima,c_.id_pengirim) GROUP BY c_.id_chat_");
		return $q->result();
	}
	function ambil_isichat($i,$sid)
	{
		$q = $this->db->query("SELECT c.*,u.id_user,t.id_team,t.ava_team,t.nama_team,c.msg AS msgfrom, IF(c.dari='$i','costom-card-pengirim','costom-card-penerima') AS classCard, IF(c.dari='$i','hide','') AS classHide FROM chat c LEFT JOIN user u ON u.id_user=c.dari LEFT JOIN team t ON t.id_user=u.id_user WHERE c.dari IN ('$i','$sid') AND c.ke IN ('$i','$sid') ORDER BY waktu ASC");
		return $q->result();
	}
	function f_ambil_userid($i)
	{
		$q = $this->db->query("SELECT t.*,u.id_user,u.username FROM user u INNER JOIN team t ON u.id_user=t.id_user WHERE u.id_user='$i'");
		return $q->result();
	}
}