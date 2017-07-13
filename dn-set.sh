#! /bin/bash

read -p "domain anda: " domain;
read -p "alamat ip anda: " aipi;

cp /etc/bind/named.conf.local /var/www/
echo "mengkonfigurasi ....";
echo "";
echo " //
// Do any local configuration here
//

// Consider adding the 1918 zones here, if they are not used in your
// organization
//include "/etc/bind/zones.rfc1918";
zone "“$domain”" {
type master;
file “/etc/bind/zones/"$domain".db”;" >> /etc/bind/named.conf.local;


echo "mencocokan....";

echo "
$TTL 300
@ IN SOA "$domain" hostmaster."$domain".db (
2016210413 ; Serial ## Format Date
10800 ; Refresh ## Dalam hitungan detik
3600 ; Retry ## Dalam hitungan detik
300 ) ; Negative Cache TTL

NS ns1."$domain".
IN MX 10 mail."$domain".
$ORIGIN "$domain"
localhost IN A 127.0.0.1
www IN A "$aipi"
mail IN A "$aipi"" >> /etc/bind/zones/$domain.db;


echo "merefres....";

echo " include "/etc/bind/named.conf.default-zones";" >> /etc/bind/named.conf;

service bind9 restart;

echo " test dns .."

whois $domain ;

echo "done!!";
