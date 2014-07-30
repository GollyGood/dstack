#!/usr/bin/env  php
<?php
include(__DIR__ . '/dstackAdapter.class.inc');
$dstackAdapter = get_dstack_adapter($argv[1]);

file_put_contents('/tmp/install.txt', print_r($dstackAdapter, TRUE));
