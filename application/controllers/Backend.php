<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Backend extends CI_Controller
{

    public function index()
    {
        $this->load->view(BACKEND_VIEW_PATH.DIRECTORY_SEPARATOR.'head');
        $this->load->view(BACKEND_VIEW_PATH.DIRECTORY_SEPARATOR.'navigation');
        $this->load->view(BACKEND_VIEW_PATH.DIRECTORY_SEPARATOR.'sitebar');
        $this->load->view(BACKEND_VIEW_PATH.DIRECTORY_SEPARATOR.'dashboard'.DIRECTORY_SEPARATOR.'dashboard');
        $this->load->view(BACKEND_VIEW_PATH.DIRECTORY_SEPARATOR.'foot');
    }
}