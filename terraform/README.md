Use the publickey.crt to create the key pair for EC2 instances
```
ssh-keygen -t rsa -b 2048 -f kubernetes
```

Open Ubuntu Terminal for wsl
```
wsl --distribution Ubuntu --cd ~ --user $wsl_user
```