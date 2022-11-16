#!/bin/sh

mkdir /tmp/v2
mv /v2-linux-64.zip /tmp/v2/
unzip /tmp/v2/v2-linux-64.zip -d /tmp/v2
install -m 755 /tmp/v2/v2 /usr/local/bin/v2
install -m 755 /tmp/v2/v2ctl /usr/local/bin/v2ctl

# Remove temporary directory
rm -rf /tmp/v2

install -d /usr/local/etc/v2
cat << EOF > /usr/local/etc/v2/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vless",
            "settings": {
                "clients": [
                    {
                        "id": "$ID", 
                        "flow": "xtls-rprx-direct",
                        "level": 0,
                        "email": "test@example.org"
                    }
                ],
                "decryption": "none"
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

/usr/local/bin/v2 -config /usr/local/etc/v2/config.json
