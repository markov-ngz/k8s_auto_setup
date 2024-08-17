1. Set necessary env variable for the file's paths
```
source set_env.sh
```
2. List the inventory 
```
ansible-inventory -i $INVENTORY --list
```
3. Run the playbook 
```
ansible-playbook -i $INVENTORY $PLAYBOOK --key-file $KEY
```

