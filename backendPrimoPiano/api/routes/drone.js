const express = require("express");
const router = express.Router();

const {PythonShell} =require('python-shell'); 
  
var occupato=false;

router.get("/aula1", (_req, res)=>{ 
  res.sendStatus(300);
  console.log("OK");
 /* occupato=true;

  let options = {
    mode: 'text',
    pythonPath: '/usr/bin/python',
    pythonOptions: ['-u'],
    scriptPath: '/home/clover/Desktop/backend/api/script',
  };

PythonShell.run('aula1.py', options, function (err) {
    if (err){
      res.sendStatus(500, err.message);
    }
  });

  occupato=false;*/
});

router.get("/aula2", (_req)=>{ 
  occupato=true;

  let options = {
    mode: 'text',
    pythonPath: '/usr/bin/python',
    pythonOptions: ['-u'],
    scriptPath: '/home/clover/Desktop/backend/api/script',
  };

PythonShell.run('aula2.py', options, function (err) {
    if (err){
      console.log(err);
    }
  });

  occupato=false;
});

router.get("/aula3", (_req)=>{ 
  occupato=true;

  let options = {
    mode: 'text',
    pythonPath: '/usr/bin/python',
    pythonOptions: ['-u'],
    scriptPath: '/home/clover/Desktop/backend/api/script',
  };

PythonShell.run('aula3.py', options, function (err) {
    if (err){
      console.log(err);
    }
  });

  occupato=false;
});

router.get("/laboratorio", (_req)=>{ 
  occupato=true;

  let options = {
    mode: 'text',
    pythonPath: '/usr/bin/python',
    pythonOptions: ['-u'],
    scriptPath: '/home/clover/Desktop/backend/api/script',
  };

PythonShell.run('laboratorio.py', options, function (err) {
    if (err){
      console.log(err);
    }
  });
  occupato=false;
});

module.exports = router;