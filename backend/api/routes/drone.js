const express = require("express");
const router = express.Router();

const {PythonShell} =require('python-shell'); 
  
var occupato=false;

router.get("/test", (req, res, next)=>{ 
    console.log(occupato)
    if(occupato)
       res.sendStatus(403);
    else
    {
    res.sendStatus(200);

    occupato=true;

    let options = {
        mode: 'text',
        pythonPath: '/usr/bin/python',
        pythonOptions: ['-u'],
        scriptPath: '/home/clover/Desktop/backend/api/script',
      };

    PythonShell.run('Drone.py', options, function (err) {
      occupato=false;
        if (err){
          console.log(err);
        }
      });
    }
});

module.exports = router;