const express = require("express");
const router = express.Router();

const {
  PythonShell
} = require('python-shell');

var occupato = false;

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

router.get("/stato", (_req, res) => {
  if (occupato) {
    return res.sendStatus(403);
  } else {
    occupato = true;
    return res.sendStatus(200);
  }
});

router.get("/aula1", (_req, res) => {
  invokePythonScript('aula1');
  occupato = false;
});

module.exports = router;