const express = require("express");
const router = express.Router();

const http = require('http');

const {PythonShell} =require('python-shell'); 
  
var occupato=false;

// Sta al secondo piano
router.get("/aula1", (_req, res)=>{ 
  if(occupato)
  {   
    res.sendStatus(403);
  }
    else 
    {
     http.get('http://localhost:8091/drone/aula1', (resp) => {
       if(resp.statusCode == 200)
        res.sendStatus(200);
      else
        res.sendStatus(403);
    }).on("error", (err) => {
      res.sendStatus(403);
    });
    }

  occupato=false;
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