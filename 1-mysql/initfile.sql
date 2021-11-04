CREATE DATABASE smartme_test_keystone;
GRANT ALL PRIVILEGES ON smartme_test_keystone.* TO 'sme_t_keystone'@'localhost' IDENTIFIED BY 'f3l00caTEST';
GRANT ALL PRIVILEGES ON smartme_test_keystone.* TO 'sme_t_keystone'@'%' IDENTIFIED BY 'f3l00caTEST';
CREATE DATABASE smartme_test_iotronic;
GRANT ALL PRIVILEGES ON smartme_test_iotronic.* TO 'sme_t_iotronic'@'localhost' IDENTIFIED BY 'f3l00caTEST';
GRANT ALL PRIVILEGES ON smartme_test_iotronic.* TO 'sme_t_iotronic'@'%' IDENTIFIED BY 'f3l00caTEST';