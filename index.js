const express = require('express');
const proxy = require('express-http-proxy');

const PORT = process.env.PORT || 5000;
const HOST = "0.0.0.0";

const app = express();

app.use(proxy('192.168.0.20:8123', {
    proxyErrorHandler: function(err, res, next) {
        next(err);
    }
}));

const server = app.listen(PORT, HOST, () => {
    console.log(`Starting Proxy at ${HOST}:${PORT}`);
});

async function closeGracefully(signal) {
    console.log(`*^!@4=> Received signal to terminate: ${signal}`)

    await server.close()
    process.exit()
}

process.on('SIGINT', closeGracefully)
process.on('SIGTERM', closeGracefully)