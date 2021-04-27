#! /bin/sh

export LC_ALL=C
export LC_CTYPE="UTF-8",
export LANG="en_US.UTF-8"

# ---- PART ONE ------
# Configure SSH connectivity from 'deployment' - server104 to Target Hosts 

# Comment/remove the following part if ceph-ansible has been installed first.
#############################################################################

echo 'run-kolla.sh: Cleaning directory /home/vagrant/.ssh/'
rm -f /home/vagrant/.ssh/known_hosts
rm -f /home/vagrant/.ssh/id_rsa
rm -f /home/vagrant/.ssh/id_rsa.pub

echo 'run-kolla.sh: Running ssh-keygen -t rsa'
ssh-keygen -q -t rsa -N "" -f /home/vagrant/.ssh/id_rsa

#############################################################################

echo 'run-kolla.sh: Install sshpass'
sudo apt-get install sshpass -y

echo 'run-kolla.sh: Running ssh-copy-id vagrant@server101 - Controller 1'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server101
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server301 - Controller 2'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server301
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server501 - Controller 3'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server501

echo 'run-kolla.sh: Running ssh-copy-id vagrant@server102 - Compute 1'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server102
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server103 - Compute 2'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server103
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server302 - Compute 3'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server302
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server303 - Compute 4'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server303
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server502 - Compute 5'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server502
echo 'run-kolla.sh: Running ssh-copy-id vagrant@server503 - Compute 6'
sshpass -p vagrant ssh-copy-id -o StrictHostKeyChecking=no vagrant@server503

echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server101:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server101:/home/vagrant/controller_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server301:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server301:/home/vagrant/controller_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server501:/home/vagrant/controller_setup.sh'
scp -o StrictHostKeyChecking=no controller_setup.sh vagrant@server501:/home/vagrant/controller_setup.sh

echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server102:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server102:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server103:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server103:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server302:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server302:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server303:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server303:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server502:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server502:/home/vagrant/compute_setup.sh
echo 'run-kolla.sh: Running scp controller_setup.sh vagrant@server503:/home/vagrant/compute_setup.sh'
scp -o StrictHostKeyChecking=no compute_setup.sh vagrant@server503:/home/vagrant/compute_setup.sh

echo 'run-kolla.sh: Running ssh vagrant@server101 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server101 "sudo bash /home/vagrant/controller_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server301 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server301 "sudo bash /home/vagrant/controller_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server501 "sudo bash /home/vagrant/controller_setup.sh"'
ssh -o StrictHostKeyChecking=no vagrant@server501 "sudo bash /home/vagrant/controller_setup.sh"

echo 'run-kolla.sh: Running ssh vagrant@server102 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server103 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server103 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server302 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server302 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server303 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server303 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server502 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server502 "sudo bash /home/vagrant/compute_setup.sh"
echo 'run-kolla.sh: Running ssh vagrant@server503 “sudo bash /home/vagrant/compute_setup.sh”'
ssh -o StrictHostKeyChecking=no vagrant@server503 "sudo bash /home/vagrant/compute_setup.sh"

ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
#ssh -o StrictHostKeyChecking=no vagrant@server102 "sudo pvcreate /dev/sda && sudo pvcreate /dev/sdb && sudo vgcreate cinder-volumes /dev/sda /dev/sdb && lvcreate -L 100G -m1 -n lv_mirror cinder-volumes"
ssh -o StrictHostKeyChecking=no vagrant@server302 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server502 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server103 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server303 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"
ssh -o StrictHostKeyChecking=no vagrant@server503 "sudo pvcreate /dev/sda && sudo vgcreate cinder-volumes /dev/sda"

ssh -o StrictHostKeyChecking=no vagrant@server102 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server302 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server502 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server103 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server303 "lsblk && sudo vgs"
ssh -o StrictHostKeyChecking=no vagrant@server503 "lsblk && sudo vgs"

# ---- PART TWO ----
# Prepare deployment and set environmental parameters

sudo bash controller_setup.sh
sudo bash deployment_setup.sh

export ORCHESTRATOR='openstack'
export OPENSTACK_VERSION='ussuri'
export CONTROLLER_NODES='172.16.1.101,172.16.1.104,172.16.1.107'
export AGENT_NODES='172.16.1.102,172.16.1.103,172.16.1.105,172.16.1.106,172.16.1.108,172.16.1.109'

# ---- PART THREE ----
# Install TF
# See also: https://github.com/tungstenfabric/tf-devstack/tree/master/ansible

git clone http://github.com/tungstenfabric/tf-devstack
./tf-devstack/ansible/run.sh

if [ $? -ne 0 ]; then
  echo "Cannot install TF"
  exit $?
fi

# ---- PART FOUR ----
# Install OpenStack Client

sudo apt update -y && sudo apt install python3-dev libffi-dev gcc libssl-dev python3-venv python3-pip -y
echo 'run-kolla.sh: Running sudo apt install python3-openstackclient'
sudo apt install python3-openstackclient -y
