# Foundry VTT With Docker

Following https://foundryvtt.com/article/installation/ but using Docker to bring in Nodejs.

The `data/` directory contains the folders `Config`, `Data`, `Logs`. You should
backup this directory if you need to restore the game on a new server.

The `vtt/` directory contains the FoundryVTT application. Download and place
the zip file inside `vtt/` and run `unzip foundry.zip`.

## Upgrading

The software will prompt and do upgrades via the web UI automatically. Sadly
after updating the `./vtt/resources/app/main.js` will not be executable. You
will need to ssh onto this servdr and `chmod +x ./vtt/resources/app/main.js`
then `sudo docker-compose restart` to get the server back up.
