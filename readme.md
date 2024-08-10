# Introduction #

This is a simple script to search a movie on a torrent site and stream it online

# Dependancies #

* Command lines tools
```sh
sudo apt update
sudo apt install grep curl fzf
```

* Download and install the latest [nodejs](https://nodejs.org/en/download/package-manager/current)

* Webtorrent (install the latest if there is a new version)
```sh
npm i webtorrent-cli@1.3.0
```

# How to install #
```sh
curl -sL https://raw.githubusercontent.com/jmswu/stream/main/stream.sh -o stream.sh && chmod +x ./stream.sh
```

# How to use #

Stream a movie like this:
```sh
./stream.sh spider man
```
![demo](./assets/demo.gif)
