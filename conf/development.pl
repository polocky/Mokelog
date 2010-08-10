+{
    database => {
        'dsn' => 'dbi:SQLite:/home/polocky/github/Mokelog/var/mokelog.db',
        'username' => '',
        'password' => '',
        'connect_options' => {
            sqlite_unicode => 1,
            unicode => 1,
        }
    },
    'auth' => {
        'htpasswd_file' => "__path_to(conf/.htpasswd)__",
    },
}
