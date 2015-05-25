## [Varnish](#markdown-header-varnish)

1. Set the following variables in your settings.php


        /**
         * Varnish settings.
         */
        $conf['reverse_proxy'] = TRUE;
        // Include in this array all webheads, load balancers, and 127.0.0.1.
        $conf['reverse_proxy_addresses'] = array('127.0.0.1');

        // Varnish control terminal.
        // Usually the internal IP of all webheads on port 6082 space separated.
        $conf['varnish_control_terminal'] = '127.0.0.1:6082';
        $conf['varnish_control_key'] = '49d7f218-231f-4e32-9582-f1aa8168b95e';
        $conf['varnish_version'] = '3';

        // Drupal 7 does not cache pages when we invoke hooks during bootstrap. This
        // needs to be disabled.
        $conf['cache_backends'][] = 'sites/all/modules/contrib/varnish/varnish.cache.inc';
        $conf['cache_class_cache_page'] = 'VarnishCache';
        $conf['page_cache_invoke_hooks'] = FALSE;


2. Visit your site using http://<full-domain>:6081
