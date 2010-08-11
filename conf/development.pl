+{
    database => {
        'dsn' => 'dbi:SQLite:/usr/local/mokelog/mokelog/var/mokelog.db',
        'username' => '',
        'password' => '',
        'connect_options' => {
            sqlite_unicode => 1,
        }
    },
    'auth' => {
        'htpasswd_file' => "__path_to(var/.htpasswd)__",
    },
}
