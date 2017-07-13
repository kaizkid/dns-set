#! /bin/bash



if  whoami | grep -i "root"; then

echo "[[[[[[[[[[[[[[[[[[[[[[[[[[ DN-SET ]]]]]]]]]]]]]]]]]]]]]]]]]]]]";
echo "==============================================================";
echo "-------------------------By :M.Husen--------------------------";
echo " ======/root/=====>";
echo "your ip is : "
ifconfig | grep -i 'inet addr' |awk ' {print $2}';
read -p "===============> domain anda: " domain;
read -p "===============> alamat ip anda: " aipi;
echo "";
echo ""
read -p "tulis tiga deret ip dengan terbalik (192.168.1.0 => 1.168.192) :"$ipt;
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

file “/etc/bind/zones/"$domain".db”;};
zone ""$ipt".in-addr.arpa" {
type master;
file "/etc/bind/zones/rev."$ipt".in-addr.arpa";}; " >> /etc/bind/named.conf.local;

read -p " jika belum konfigurasi sebelumnya  ktik n jika sudah y " pp;


if [ $pp == "n" ]; then

mkdir /etc/bind/zones; 

echo "mencocokan....";



echo "
; BIND data file for "$domain"
;
$TTL 14400
@ IN SOA "$domain". root."$domain". (
201006601 ; Serial
7200 ; Refresh
120 ; Retry
2419200 ; Expire
604800) ; Default TTL
;


@ IN MX 10 mail."$domain".
@ IN 229 A "$aipi"
inori 229  IN "$aipi"
isla 229 IN A "$aipi"
www IN CNAME "$domain".
link 229 IN A "$aipi"
mail IN A "$aipi"
@ IN TXT "v=spf1 ip4:"$aipi" a mx ~all"
mail IN TXT "v=spf1 a -all"" >> /etc/bind/zones/$domain.db;
echo "@ IN SOA "$domain". root."$domain". (
1;
28800;
604800;
604800;
86400 );


4 IN PTR "$domain"." >> /etc/bind/zones/rev."$ipt".in-addr.arpa

cp /etc/resolve.conf /var/www/

echo "search "$domain"" >> /etc/resolve.conf
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state NEW -m udp -p udp --dport 53 -j ACCEPT 

elif [ $pp == "y"]; then 

echo "
; BIND data file for "$domain"
;
$TTL 14400
@ IN SOA "$domain". root."$domain". (
201006601 ; Serial
7200 ; Refresh
120 ; Retry
2419200 ; Expire
604800) ; Default TTL
;


@ IN MX 10 mail."$domain".
@ IN 229 A "$aipi"
inori 229  IN "$aipi"
isla 229 IN A "$aipi"
www IN CNAME "$domain".
link 229 IN A "$aipi"
mail IN A "$aipi"
@ IN TXT "v=spf1 ip4:"$aipi" a mx ~all"
mail IN TXT "v=spf1 a -all"" >> /etc/bind/zones/$domain.db;
echo "@ IN SOA "$domain". root."$domain". (
1;
28800;
604800;
604800;
86400 );


4 IN PTR "$domain"." >> /etc/bind/zones/rev."$ipt".in-addr.arpa

cp /etc/resolve.conf /var/www/

echo "search "$domain"" >> /etc/resolve.conf
iptables -A INPUT -p udp -m udp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -m state --state NEW -m udp -p udp --dport 53 -j ACCEPT 


fi

echo "merefres....";

echo " include "/etc/bind/named.conf.default-zones";" >> /etc/bind/named.conf;

service bind9 restart;

echo " test dns .."

whois $domain ;

echo "done!!";

else

echo " harus root dlu";

fi
