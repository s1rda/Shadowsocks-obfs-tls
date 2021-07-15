----- Installing Shadowsocks (lost sock)
 
apt install shadowsocks-libev
 
Editing the config
 
nano /etc/shadowsocks-libev/config.json
 
We restart the server:
 
systemctl restart shadowsocks-libev.service
 
And that's it, we're done with the server. Moving on to the client.
 
Install the same package on the client machine:
 
apt install shadowsocks-libev
 
We make a config file, for example, in the home directory
 
nano ~ / shsocks.json
 
{
    "server": "123.123.123.123",
    "server_port": 12345,
    "local_port": 1080,
    "password": "password",
    "timeout": 60,
    "method": "aes-256-cfb"
}
 
The only difference is the presence of local_port. The setting specifies which port on the local host the local SOCKS server will use.
 
Launch:
 
ss-local -c ~ / shsocks.json

------ Shadowsocks + obfs (tls) (lost sock with expensive grease)
 
Now we will disguise the proxy traffic under TLS / SSL, which will be closer to life than HTTP. On the server side, the following changes:
 
{
    "server": "123.123.123.123",
    "server_port": 443,
    "password": "password",
    "timeout": 60,
    "method": "aes-256-cfb",
    "plugin": "obfs-server",
    "plugin_opts": "obfs = tls; failover = 204.79.197.200: 443"
}
 
We restart the server:
 
systemctl restart shadowsocks-libev.service
 
On the client side, the following changes (for example, let's make another file ~ / shsocks-obfs-tls.json):
 
{
    "server": "123.123.123.123",
    "server_port": 443,
    "local_port": 1080,
    "password": "password",
    "timeout": 60,
    "method": "aes-256-cfb",
    "plugin": "obfs-local",
    "plugin_opts": "obfs = tls; obfs-host = www.bing.com"
}
 
Launching the client
 
ss-local -c ~ / shsocks-obfs-tls.json
