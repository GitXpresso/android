#!/bin/bash
sudo curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/refs/heads/master/files/docker/systemctl3.py && sudo chmod -R 755 /bin/systemctl > /dev/null

echo -e "\n|---------------------|\n| systemctl installed!\n|---------------------|"

sleep 1
clear
echo "do \"/bin/systemctl\" to run systemctl!"

