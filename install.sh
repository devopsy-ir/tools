tools_dir=$1
domain=$2

#apt update
#apt -y install rsync

mkdir -p ${tools_dir}/nexus

sed -i -E "s/domain:.*/domain: ${domain}/g" ./nginx/ansible/hosts.yml

#echo "Copy Nexus docker images ..."
#rsync  -qazhPW --inplace  --progress ./nexus/volumes ${tools_dir}/nexus/

#echo "Up Nexus ..."
#cd ./nexus/ansible/
#ansible-playbook -i hosts.yml nexus.yml
