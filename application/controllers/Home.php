<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

	public function index()
	{
		$this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'head');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'navigation');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'home'.DIRECTORY_SEPARATOR.'landing_page');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'foot');
	}

}
