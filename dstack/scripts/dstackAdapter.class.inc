<?php

function get_dstack_adapter($config_file) {
  file_put_contents('/tmp/hmm', $config_file);
  try {
    return new dstackAdapter($config_file);
  }
  catch (Exception $e) {
    echo($e->getMessage());
    // We have to use exit(1) because otherwise vagrant doesn't nknow it actually
    // failed.
    exit(1);
  }
}

class dstackAdapter {
  public $config = NULL;
  private $config_file = '';

  public function __construct($config_file = '') {
    $this->setConfigFile($config_file);
    $this->loadConfig();
  }

  private function setConfigFile($config_file) {
    if (empty($config_file) || !is_readable($config_file)) {
      throw new Exception("Unable to read configuration file '{$config_file}'.");
    }

    $this->config_file = $config_file;
  }

  public function loadConfig() {
    $config = '';

    if ($contents = file_get_contents($this->config_file)) {
      $config = json_decode($contents);

      // Parse dstack configurations.
      foreach ($config->dstack as &$dstack_config) {
        $dstack_config = json_decode($dstack_config);
      }
    }

    if (empty($config)) {
      throw new Exception("Unable to load configuration file '{$this->config_file}'.");
    }

    $this->config = $config;
  }

  public function execute($command) {
    $output = array();
    $return = 0;

    exec($command, $output, $return);

    if ($return) {
      exit(1);
    }
  }
}
