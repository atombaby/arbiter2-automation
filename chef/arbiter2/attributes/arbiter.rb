default['arbiter']['config']['general'] = {
  'debug_mode'            => 'false',
  'arbiter_refresh'       => '30',
  'history_per_refresh'   => '3',
  'min_uid'               => '1000'
}
default['arbiter']['config']['self']['groupname'] = 'arbitors'
default['arbiter']['config']['badness'] = {
  'max_history_kept'      => '180',
  'cpu_badness_threshold' => '0.9',
  'mem_badness_threshold' => '0.9',
  'time_to_max_bad'       => '300',
  'time_to_min_bad'       => '300'
}
default['arbiter']['config']['email'] = {
  'email_domain'    => 'fredhutch.org',
  'from_email'      => 'noreply+arbiter@fredhutch.org',
  'admin_emails'    => ['mrg@fredhutch.org'],
  'mail_server'     => 'mx.fhcrc.org',
  'keep_plots'      => 'false',
  'plot_location'   => '/var/spool/arbiter'
}
default['arbiter']['config']['database'] = {
  'log_location'      => '/var/log/arbiter',
  'log_rotate_period' => '3'
}
default['arbiter']['config']['processes'] = {
  'memsw'          => 'false',
  'pss'            => 'true',
  'whitelist'      => %w[gcc clang],
  'whitelist_file' => '/etc/arbiter/whitelist.txt'
}
default['arbiter']['config']['status'] = {
  'order'                              => "['invincible','admin','normal']",
  'fallback_status'                    => 'normal',
  'div_cpu_quotas_by_threads_per_core' => 'true'
}
default['arbiter']['config']['status']['groups'] = {
  'normal' => {
    'uids'      => [],
    'cpu_quota' => '100',
    'mem_quota' => '10'
  },
  'admin' => {
    'uids'      => [1000],
    'cpu_quota' => '100',
    'mem_quota' => '10'
  },
  'invincible' => {
    'uids'      => [0],
    'cpu_quota' => '1e5',
    'mem_quota' => '1e5'
  }
}
default['arbiter']['config']['status']['penalty'] = {
  'relative_quotas'   => 'true',
  'order'             => '["penalty1","penalty2","penalty3"]',
  'occur_timeout'     => '10800'
}
default['arbiter']['config']['status']['penalty']['groups'] = {
  'penalty1' => {
    'timeout'    => '600',
    'cpu_quota'  => '0.8',
    'mem_quota'  => '0.8',
    'expression' => 'new'
  },
  'penalty2' => {
    'timeout'    => '600',
    'cpu_quota'  => '0.8',
    'mem_quota'  => '0.8',
    'expression' => 'repeated'
  },
  'penalty3' => {
    'timeout'    => '600',
    'cpu_quota'  => '0.8',
    'mem_quota'  => '0.8',
    'expression' => 'severe'
  }
}
default['arbiter']['config']['high_usage_watcher'] = {
  'high_usage_watcher'                     => 'true',
  'cpu_usage_threshold'                    => '0.9',
  'mem_usage_threshold'                    => '0.25',
  'timeout'                                => '600',
  'div_cpu_thresholds_by_threads_per_core' => 'true',
  'user_count'                             => '8'
}
default['arbiter']['whitelisted_processes'] = %w[
  bash
]
