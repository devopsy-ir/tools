tools_dir=$1
echo ${tools_dir}
#apt update
#apt -y install rsync
mkdir ${tools_dir}/nexus
echo "Copy Nexus docker images ..."
rsync  -qazhPW --inplace  --progress ./nexus/volumes ${tools_dir}/nexus/

echo "Up Nexus ..."
cd ./nexus/ansible/
ansible-playbook -i hosts.yml nexus.yml
