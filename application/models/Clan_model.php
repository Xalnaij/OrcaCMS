<?php
/**
 * Created by PhpStorm.
 * User: Xalnaji
 * Date: 23.01.2018
 * Time: 10:56
 */

class Clan_model extends CI_Model
{
    public function getClanname(){
        $query = $this->db->select('clanname')
                    ->from($this->db->dbprefix.'clan')
                    ->get();

        return $query->result();
    }
}