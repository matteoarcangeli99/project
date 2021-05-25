const express = require('express');
const app = express();
const JOut = require("./shared/jout.js");

app.use(express.urlencoded({extended: true})); 
app.use(express.json());  

app.use('/drone', require('./api/routes/drone'));

/* ERRORI */
app.use((_req, _res, _next) => {
    _next({
        statusCode: 404,
        message: 'Resource not found.'
    });
});

app.use((_error, _req, _res, _next) => {
    _res.status(_error.statusCode ? _error.statusCode : 500)
        .json(JOut([], _error ? _error : {
            statusCode: 500,
            message: "Internal server error."
        }));
});

module.exports = app;