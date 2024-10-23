# Allora-Basic-Coin-Prediction (easily change your model)

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
## customise your worker node with Lasso
Before reading further please make sure that:

· Your base node is the basic-coin-prediction-node

· You have every dependency for Allora’s worker nodes installed

· Your node has been configured correctly and is running perfectly

· You know how to get inside a file on Linux CLI using nano / vim / vi whatever you prefer

Here are the easy steps:
1️⃣We are now in the basic-coin-prediction-node directory after you have configured everything to test that the basic-coin-prediction-node runs perfectly

cd $HOME/basic-coin-prediction-node (copy)

2️⃣We will get inside the model.py file — I use vim but you can use whatever command you like

vim model.py (copy)

3️⃣At the top, you will want to add numpy as np there just in case you’d need it

4️⃣Next, we scroll down the def train_model section and locate the model parameter

5️⃣Go to the scikit-learn doc website and choose a regression model that you would like to use
Link: https://scikit-learn.org/stable/supervised_learning.html
You can use any supervised learning regression model, and each one performs the prediction differently. DO NOT PICK a classification model.

6️⃣Click the link of your preferred model and find the usage example

7️⃣Once found, edit the model parameter in your model.py accordingly
I also added two print(..) for easier debugging just in case we have to

8️⃣Edit the library downloader at the top of the model.py too
As you can see, I commented out the LinearRegression and added the line below to the list

from sklearn import linear_model (copy)

9️⃣Exit from model.py

1️⃣0️⃣Check requirement.txt if we need to add any dependencies
vim requirement.txt (copy)
In this case, we don’t have to add anything
1️⃣1️⃣Rebuild the docker and restart the containers with

docker compose build
docker compose up -d (copy)
1️⃣2️⃣If all went well, then check your inferences
curl http://localhost:8000/inference/<token> (copy)
Congrats! You have levelled up to level-2 builder
## Debugging
Error starting the inference container
1️⃣Check logs to see what is going on and fix the bug accordingly or switch to another model

docker compose logs -f (copy)
2️⃣If there’s no error and you can see only the printed message that says `Begin training the model` then there’s no error, the training process just takes longer than expected
3️⃣Wait until you get `Training completed`
4️⃣Restart the other containers
docker compose up -d ((copy)
5️⃣If all went well, then check your inferences

curl http://localhost:8000/inference/<token> (copy)
Getting code 500 instead of 200 in the logs
1️⃣Check your inferences
curl http://localhost:8000/inference/<token> (copy)
2️⃣A common bug is the return is a 1d array but your app.py still tries to extract it out using index and it results in an error

3️⃣To fix this, we will have to get inside app.py
vim app.py (copy)

4️⃣1. Look for def get_eth_inference() and delete the [0] in the return
Depending on your chosen model, you may have to delete both [0]

5️⃣Rebuild and restart the containers

docker compose build
docker compose down
docker compose up -d (copy)

6️⃣If all went well, then check your inferences

curl http://localhost:8000/inference/<token> (copy)

## Other things you could do to further improve the model

· Change the train_dataset

· Change how the final output is aggregated

· Edit the input (X_train and X_test)

· Hyperparameter Editing / Tuning

Please see our doc for additional advice: https://docs.allora.network/devs/workers/walkthroughs/walkthrough-price-prediction-worker/modelpy


















