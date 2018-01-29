<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Home extends CI_Controller {

    private $pageData = array();

	public function index()
	{
	    $this->loadPageData();

		$this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'head');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'navigation');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'home'.DIRECTORY_SEPARATOR.'landing_page');
        $this->load->view(FRONTEND_VIEW_PATH.DIRECTORY_SEPARATOR.'foot');
	}

	private function loadPageData(){

    }

    private function getPageTitle(){

    }

}
