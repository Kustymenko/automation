#!/bin/bash -e

# Bash automation script for junos devices
# Version 1.0

#set -x

# Variables

junos_user="root"
rsa_file="~/.ssh/id_rsa"

host="198.51.100.1"


config="configure;set interfaces ge-1/0/0 flexible-vlan-tagging unit 123 vlan-id 123 description vlan_123 family inet address 192.0.2.1/24;commit;exit;show configuration interfaces ge-1/0/0 | display set;exit"



# Script body

   echo "#-------------------------------#"
   echo "# Start executing script        #"
   echo "#-------------------------------#"

for i in ${host}; do
   echo "Log in to: ${i}"

   ssh -i ${rsa_file} ${junos_user}@${i} ${config}

   echo "#-------------------------------#"
   echo "# Script executed successfully  #"
   echo "#-------------------------------#"
done
exit 0

#set +x
