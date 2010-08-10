use inc::Module::Install;
name 'Mokelog';
all_from 'lib/Mokelog.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
test_requires 'Test::LoadAllModules';
auto_include;
WriteAll;
