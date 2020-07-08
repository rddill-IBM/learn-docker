/**
 * Copyright 2015 IBM Corp. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
/*
 * Zero to Cognitive Chapter 4
 */

'use strict';
let express = require('express');
let http = require('http');
let path = require('path');
let fs = require('fs');
let mime = require('mime');
let bodyParser = require('body-parser');
let cookieParser = require('cookie-parser');
let cfenv = require('cfenv');
let redis = require('redis');

let appEnv = cfenv.getAppEnv();
let app = express();
let client = redis.createClient({host: 'redis-server', port: 6379});
// redis-server is defined as a service in the docker-compose.yml file
client.set('visits', 0);

app.use(cookieParser());
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.set('appName', 'z2c-chapter04');
app.set('port', appEnv.port);

app.set('views', path.join(__dirname + '/HTML'));
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/HTML'));
app.use(bodyParser.json());
app.get('/', (req, res, next) => {
    client.get('visits', (err, visits) => {
        console.log('visits: ' + visits);
        client.set('visits', parseInt(visits) + 1);
    });
    next();
});

// Define your own router file in controller folder, export the router, add it into the index.js.
// app.use('/', require("./controller/yourOwnRouter"));

// app.use('/', require('./controller/restapi/router'));

http.createServer(app).listen(
    app.get('port'),
    function(req, res) {
        console.log(app.get('appName') + ' is listening on port: ' + app.get('port'));
    }
);

function loadSelectedFile(req, res) {
    let uri = req.originalUrl;
    let filename = __dirname + '/HTML' + uri;
    fs.readFile(
        filename,
        function(err, data) {
            if (err) {
                res.writeHead(500);
                console.log('Error loading ' + filename + ' error: ' + err);
                return res.end('Error loading ' + filename);
            }
            res.setHeader('content-type', mime.lookup(filename));
            res.writeHead(200);
            res.end(data);
        }
    );
}
