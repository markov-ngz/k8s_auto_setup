1. Set necessary env variable for the file's paths
```
INVENTORY=<inventory_file_path>
PLAYBOOK=<playbook_file_path>
KEY=<ssh_key_path>
```
2. List the inventory 
```
ansible-inventory -i $INVENTORY --list
```
3. Run the playbook 
```
ansible-playbook -i $INVENTORY $PLAYBOOK --key-file $KEY
```

