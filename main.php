<?php

//Debugging
ini_set('display_errors', 'On');
error_reporting(E_ALL);

require_once('util/template.php');
require_once('util/utilities.php');

class running {

	public function __construct() {
		//TODO: check if POST
		if(is_postback()) {
			$this->store();
		} else {
			$this->load();
		}
	}

	private function store() {
		var_dump($_POST);
		if($this->validate()) {

		}
	}

	private function load() {

	}

	private function validate() {
		return true;
	}

	public function populate() {

	}
}

$tpl = new template('main.tpl');
$running = new running();
$running->populate($tpl);
$tpl->render();

?>
