

CREATE USER 'student01'@'localhost' IDENTIFIED BY 'Study123!';

CREATE USER 'remote_dev'@'%' IDENTIFIED BY 'DevWork456#';

CREATE USER 'office_worker'@'192.168.10.*' IDENTIFIED BY 'Office789$';

CREATE USER 'webapp_user'@'localhost' IDENTIFIED BY 'WebApp2024!';
GRANT SELECT, INSERT, UPDATE, DELETE ON shop_db.* TO 'webapp_user'@'localhost';

CREATE USER 'db_admin'@'192.168.1.100' IDENTIFIED BY 'Admin#2024Secure';
GRANT ALL privileges ON *.* TO 'db_admin'@'192.168.1.100';

CREATE USER 'report_viewer'@'%' IDENTIFIED BY 'ViewOnly999@';
GRANT SELECT ON company_db.* TO 'report_viewer'@'%';













