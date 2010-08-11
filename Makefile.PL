use inc::Module::Install;
name 'Mokelog';
all_from 'lib/Mokelog.pm';

requires(
    'Text::Livedoor::Wiki' => 0,
    'Apache::Htpasswd' => 0,
    'Polocky::WAF' => 0, 
    'Data::ObjectDriver' => 0,
    'DBD::SQLite' => 0,
    'DateTime' => 0,
);

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::LoadAllModules';
auto_include;
WriteAll;
