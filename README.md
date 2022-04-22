

- Create data dir and link to local  
```shell
mkdir /data
ln -s /data/mainnet mainnet
ln -s /data/volumes volumes
```
- Need to chown kafka volumes 
```shell
sudo chown 1000:1000 /data/volumes/broker
sudo chown 1000:1000 /data/volumes/zoo
```

