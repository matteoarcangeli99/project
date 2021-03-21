const express = require("express");
const router = express.Router();

const {PythonShell} =require('python-shell'); 
  
var occupato=false;

router.get("/test", (req, res, next)=>{ 
    if(!occupato)
       return res.status(300);
    else
        return res.status(200);

    let options = {
        mode: 'text',
        pythonPath: '/usr/bin/python',
        pythonOptions: ['-u'], // get print results in real-time
        scriptPath: '/home/clover/Desktop/Test/library_backend/api/routes',
      };

    PythonShell.run('Drone.py', options, function (err) {
        if (err) throw err;
        console.log('finished');
      });
});

router.get("/test2", (_req, _res) => {
    console.log("Ci sono");
    return _res.status(200).json(JOut("Ciao mondo", {}));

});
module.exports = router;