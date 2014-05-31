<?php

class template {
	private $__filename;
	private $__properties = array();

	public function __construct($filename) {
			$this->__filename = $filename;
	}

	public function __set($name,$value) {
		$this->__properties[$name] = $value;
	}

	public function &__get($name) {
		if(array_key_exists($name, $this->__properties)) { return
$this->__properties[$name];} else { return null; }
	}

	public function __isset($name) {
		return isset($this->__properties[$name]);
	}

	public function __unset($name) {
		unset($this->__properties[$name]);
	}

	public function render() {
		$filename = __DIR__.'/../templates/'.$this->__filename;
		if(file_exists($filename)) {
			echo template_render::render(array($this->__properties),
@file_get_contents($filename));
		} else {
			throw new Exception($this->__filename . ' does not exists');
		}
	}
}

class template_render {
	private $stack;

	private function __construct($stack) {
		$this->stack = $stack;
	}

	public static function render($stack, $body) {
		$block = new template_render($stack);
		$pattern = '/\{([^\s}]+) +([^}]+)\}[\t\r\n]*(.?)\{\/\1
+\2\}[\t\r\n]*/ms';
		$callback = array($block, 'render_block');
		return $block->resolve($block->exec(preg_replace_callback($pattern,
$callback, $body)));
	}

	private function get_property($name) {
		foreach($this->stack as $property) {
			if(is_array($property) && array_key_exists($name, $property)) {
return $property[$name]; }
			if(is_object($property) && property_exists($property, $name)) {
return $property->$name; }
		}
	}

	private function render_block() {
		$type = $match[1];
		$name = $match[2];
		$body = $match[3];
		$method = 'render_' . $type;
		if($method != __FUNCTION__ && method_exists($this, $method)) {
			return $thjis->$method($this->get_property($name), $body);
		}
		return null;
	}

	private function resolve($body) {
		$pattern = '/\{([^\s}]+)\}/';
		$callback = array($this, 'resolve_veriable');
		return preg_replace_callback($pattern, $callback, $body);
	}

	private function resolve_veriable($match) {
		$original = $match[0];
		$name = $match[1];
		if(strlen($name) > 0) {
			if($name[0] == '_') { return _(substr($name, 1)); }
			return $this->get_property($name);
		}
		return $original;
	}

	private function exec($body) {
		$pattern = '/\{([^\s}]+) +([^}]+)\}/';
		$callback = array($this, 'exec_method');
		return preg_replace_callback($pattern, $callback, $body);
	}

	private function exec_method($match) {
		$type = $match[1];
		$name = $match[2];
		$method = 'exec_' . $type;
		if ($method != __FUNCTION__ && method_exists($this, $method)) {
			return $this->$method($this->get_property($name));
		}
		return null;
	}
}

?>
