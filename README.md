# Allora-Basic-Coin-Prediction (Allora Network UPDATE 09-06)

- You must need to buy a VPS for running Allora Worker
- You should buy VPS which is fulfilling all these requirements : 
```bash
Operating System : Ubuntu 22.04
CPU: Minimum of 1/2 core.
Memory: 2 to 4 GB.
Storage: SSD or NVMe with at least 5GB of space.
```

## Clean Docker First
```bash
docker system prune
```

## Automatic Installtion:

```bash
cd $HOME
rm -rf basicinstall.sh
wget https://raw.githubusercontent.com/0xtnpxsgt/Allora-Basic-Coin-Prediction/main/basicinstall.sh
chmod +x basicinstall.sh
./basicinstall.sh
```

## Check logs 
```bash
docker logs -f worker
```
