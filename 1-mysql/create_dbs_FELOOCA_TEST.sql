CREATE DATABASE felooca_test_keystone;
GRANT ALL PRIVILEGES ON felooca_test_keystone.* TO 'fe_t_keystone'@'localhost' IDENTIFIED BY 'f3l00caTEST';
GRANT ALL PRIVILEGES ON felooca_test_keystone.* TO 'fe_t_keystone'@'%' IDENTIFIED BY 'f3l00caTEST';
CREATE DATABASE felooca_test_iotronic;
GRANT ALL PRIVILEGES ON felooca_test_iotronic.* TO 'fe_t_iotronic'@'localhost' IDENTIFIED BY 'f3l00caTEST';
GRANT ALL PRIVILEGES ON felooca_test_iotronic.* TO 'fe_t_iotronic'@'%' IDENTIFIED BY 'f3l00caTEST';