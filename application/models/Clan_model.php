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
        return $this->db->select('clanname')
                    ->from('clan');
    }
}