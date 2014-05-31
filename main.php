<?php

//Debugging
ini_set('display_errors', 'On');
error_reporting(E_ALL);

require_once('util/template.php');

class running {

	public function __construct() {
		//TODO: check if POST
		if(true) {
			$this->store();
		} else {
			$this->load();
		}
	}

	private function store() {

	}

	private function load() {

	}

	private function validate() {

	}
}

$tpl = new template('main.tpl');
$tpl->render();

?>
