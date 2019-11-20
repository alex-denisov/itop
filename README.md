# iTop 2.5.1 Docker image
##### Based on work done by Vladimir Kunin (https://github.com/vbkunin/itop-docker)

## Build Image
```
docker build -t americatel/itop .
```

## Running
```
$ docker-compose up -d
```

After of complete the installation, you need to config file /etc/itop/production/config-itop.php
```
'app_root_url' => 'http://itop.example.com:9080/itop/',
'email_asynchronous' => true,
'email_default_sender_address' => 'sender@example.com',
'email_default_sender_label' => 'Example',
'email_transport' => 'SMTP',
'email_transport_smtp.encryption' => 'tls',
'email_transport_smtp.host' => 'smtp.office365.com',
'email_transport_smtp.password' => 'password',
'email_transport_smtp.port' => 587,
'email_transport_smtp.username' => 'user@example.com.pe',
'timezone' => 'America/Lima',

'authent-ldap' => array (
		'host' => 'ldap.example.com',
		'port' => 389,
		'default_user' => 'user@example.red',
		'default_pwd' => 'password',
		'base_dn' => 'DC=example,DC=red',
		'user_query' => '(&(samaccountname=%1$s))',
		'options' => array (
		  17 => 3,
		  8 => 0,
		),
		'start_tls' => false,
		'debug' => false,
	),
```

If you need to setup Cron, exec this command
```
docker exec itop-web /setup-itop-cron.sh [User] [Password]
```

If you need to do the config file config-itop.php writable or read-only, you'd use these commands
```
docker exec itop-web /make-itop-config-writable.sh
docker exec itop-web /make-itop-config-read-only.sh
```