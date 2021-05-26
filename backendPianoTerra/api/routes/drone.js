const express = require("express");
const router = express.Router();

const http = require('http');

const {
  PythonShell
} = require('python-shell');

var occupato = false;

/* Controlla lo stato del drone principale e del secondario (se richiesto)
 * ritorna al chiamante 
 * 200 --> se entrambi sono disponibili
 * 403 --> se almeno uno dei due non è disponibile
 * 500 --> se si è verificato un errore imprevisto nella comunicazione col secondo drone
 */
function checkStatus(res, secondario) {
  console.log("Occupato: " + occupato);
  console.log("Secondario: " + secondario);

  if (occupato) { // Controllo lo stato del drone principale
    return res.sendStatus(403);
  }
  if (secondario) { // se necessario controllo il secondario
    http.get('http://localhost:8091/drone/stato', (resp) => {
      if (resp.statusCode == 403)
        return res.sendStatus(403);
      console.log(200);
    }).on("error", () => {
      return res.sendStatus(500);
    });
  }
  res.sendStatus(200);
  occupato = true;
}

/*
 * Invoca lo sciprt Python passato come parametro
 */
function invokePythonScript(scriptName) {
  let options = {
    mode: 'text',
    pythonPath: '/usr/bin/python',
    pythonOptions: ['-u'],
    scriptPath: '/home/clover/Desktop/backend/api/script',
  };

  PythonShell.run(scriptName, options, function (err) {
    if (err) {
      console.log(err);
    }
  });
}

function vola(res, secondo, endpoint, scriptName) {
  checkStatus(res, secondo);
  if (secondo) {
    setTimeout(function () {
      http.get('http://localhost:8091/drone/' + endpoint, () => {});
    }, 3000);
  }
  //invokePythonScript(sciprtName); 
  occupato = false;
}

router.get("/aula1", (_req, res) => {
  vola(res, true, 'stato', 'aula1.py');
});

router.get("/aula2", (_req, res) => {
  res.setstatus(500);
});

router.get("/aula3", (_req, res) => {
  res.setstatus(500);
});

router.get("/laboratorio", (_req) => {
  res.setstatus(500);
});

module.exports = router;