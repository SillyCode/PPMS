<?php

function is_postback() { return (strtolower($_SERVER['REQUEST_METHOD']) ==
'post'); }

?>
