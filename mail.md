https://upcloud.com/community/tutorials/secure-postfix-using-lets-encrypt/
https://open-networks.ru/d/25-postfix-spf-dkim-adsp-dmarc

`sudo apt install postfix`  
`sudo apt install opendkim opendkim-tools`

`vim /etc/postfix/main.cf`:
```
smtpd_tls_cert_file=/etc/letsencrypt/live/omskvelo.ru/fullchain.pem
smtpd_tls_key_file=/etc/letsencrypt/live/omskvelo.ru/privkey.pem
smtpd_use_tls=yes

myhostname = omskvelo.ru

# DKIM
milter_default_action = accept
milter_protocol = 2
smtpd_milters = inet:localhost:8891
non_smtpd_milters = inet:localhost:8891
```

`opendkim-genkey -D /etc/postfix/dkim/ -d omskvelo.ru -s mail2`

Add TXT record to domain from /etc/postfix/dkim/mail2.txt.

`vim /etc/opendkim.conf`:
```
KeyTable file:/etc/postfix/dkim/keytable
SigningTable file:/etc/postfix/dkim/signingtable
```

`vim /etc/postfix/dkim/keytable`:
```
# имя_ключа домен:селектор:/путь/до/ключа
mail2._domainkey.omskvelo.ru omskvelo.ru:mail2:/etc/postfix/dkim/mail2.private
```

`vim /etc/postfix/dkim/signingtable`:
```
#домен имя_ключа
omskvelo.ru mail2._domainkey.omskvelo.ru
```
