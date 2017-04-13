<?php
//DB Configuration
$cfg_db_host='localhost';
$cfg_db_user='wpa';
$cfg_db_pass='wpapass';
$cfg_db_name='wpa';

//reCaptcha auth
$publickey = '';
$privatekey = '';

//bosskey
$bosskey = '8dbf3ee8dc96b9170bd3fc6a9b9384fe';

//App specific defines
define('PYRIT', 'pyrit');
define('WPACLEAN', '/var/www/html/dwpa-master/web/cap/wpaclean');
define('CAP2HCCAP', '/var/www/html/dwpa-master/web/cap/cap2hccap.bin');

define('CAP', '/var/www/html/dwpa-master/web/cap/');
define('CRACKED', '/var/www/html/dwpa-master/web/dicts/cracked.txt.gz');
if (is_dir('/run/shm'))
    define('SHM', '/run/shm/');
elseif (is_dir('/dev/shm'))
    define('SHM', '/dev/shm/');
else
    die('Can not access SHM!');

define('MIN_HC_VER', '0.8.7');
?>
