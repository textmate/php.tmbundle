<?php
register_shutdown_function(create_function('', 'echo file_get_contents(dirname(__FILE__) . "/javascript.html");'));
?>
