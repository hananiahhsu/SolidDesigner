let fs = require('fs');
let path = require('path');
var execSync = require('child_process').execSync;


function BuildProductProject(paltform, ProjectName)
{
    let buildCMakeLists = require('./BuildCMakeLists');
    // souce code dir
    let codePath = path.join(__dirname, "..\\..\\");
	console.log(codePath);
}

exports.BuildProductProject = BuildProductProject;