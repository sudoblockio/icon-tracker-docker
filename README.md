# icon-tracker-v2

Docker scripts to setup the icon tracker on a single node. 

### Pre-requisites

You will need to have a server with the following minimum specs depending on the network that you are running on. Specs can be reduced if you are only syncing up recent blocks or if you are using a custom version to only index subsets of a chain. 

- Mainnet 
  - 8 threads min / 24 threads recommended 
    - Low thread count will impact query performance and sync time 
    - 64 GB ram for full chain
    - 800 GB disk minimum which will grow over time 
- Testnets 
  - 4 threads min / 8 threads recommended 
  - 16 GB ram for full chain
  - 100 GB disk minimum which will grow over time 

Additionally, you will need the following installed:

- docker
- docker-compose 

### Preparation 

To setup a node to be able to run the application, directory structure and apply the following permissions:

```shell
mkdir volumes 
# Sym link appropriately if needed 
# mkdir /data/volumes
#ln -s /data/volumes volumes
# mkdir volumes/broker
# mkdir volumes/zoo
# Chown for kafka persistence 
sudo chown 1000:1000 volumes/broker
sudo chown 1000:1000 volumes/zoo
```

Additionally, you will need to fill out an `.env` file which you can find an example for in the repo. 

```shell
cp .env.example .env
nano .env
```

Follow the directions in this file to fill in the fields.

You will also want to configure firewalls appropriately so that you do not expose any of the DBs publicly.  

If you are running the frontend, expose the following and set a DNS record to point to your host for letsencrypt SSL to be activated. 

- 80 - Web insecure 
- 443 - Web secure 
- 8080 - Traefik admin 

If you are monitoring the node, you will want to open the following ports:

- 9100 - Node exporter 
- 8081 - Cadvisor 
- 9187 - Postgres exporter 
- 9308 - Kafka exporter 

> Get in touch if you want to have any prometheus rules / grafana dashboards to monitor the stack. They will be made public in the future.  

### Running the application 

After customizing the `.env` file from previous step, simply run the following command:

```shell
make up-full 
make ps-full  # See status of stack 
```

Additionally, you may want to run admin consoles such as pgadmin (postgres) and control-center (kafka). To do that, run the command in the makefile manually with an additional `-f docker-compose.admin.yml`.  Same for an ICON node if you want to run a local version (`-f docker-compose.node.yml`). 

Note that public endpoints should be ok for you to sync off of but if you want something potentially more reliable, the local icon node should be used. 

## Filling in Missing Blocks 

It is possible to miss blocks in the backend so to fill them in, there is a process to discover missing blocks, re-extract them, and process them so that they are properly stored in the backend. 

Missing blocks can come from the following general reasons:

1. Misconfigured Kafka topic / broker that has `message.max.bytes` set too low for large blocks
2. Misformatted blocks such as missing timestamps or empty hashes (they exist) that are dropped in a "[dead letter queue](https://medium.com/@sannidhi.s.t/dead-letter-queues-dlqs-in-kafka-afb4b6835309)" and need to be fixed in some way.  Currently there are only a about 5 of such messages so you should not need to worry about this much in normal practice. 
3. A restart on the transformer as it is processing a message can make it drop the block 

Generally speaking, when a block is processed it is fully processed but a process still exists to make sure the DB is 100% complete. 

