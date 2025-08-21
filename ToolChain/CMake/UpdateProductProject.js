const { argv } = require('process');

{
    try {
	   let buildProject = require('./BuildProject');
	   if (argv.length >= 4) {
	       buildProject.BuildProductProject(argv[2], argv[3]);
	    } else {
		   console.error('Error : arguments count must >= 2');
		}
	}
    catch (e) {
	     console.error('Error:' + e.name + ": " + e.message);
		 console.error(e.stack);
         throw new Error("execute failed!!!");
    }
}