CREATE DATABASE {{ database_name }};
CREATE USER {{ database_user_name }} WITH password '{{ database_user_password }}';
GRANT ALL ON DATABASE {{ database_name }} TO {{ database_user_name }};