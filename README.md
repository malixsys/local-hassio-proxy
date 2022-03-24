## Local HASS proxy

### Run
```bash
docker build . -t proxyjs
docker run --rm -it -p 5000:5000 proxyjs
```

### Dokku
```bash
dokku apps:create hassio
```
