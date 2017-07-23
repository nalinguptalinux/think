node {

     currentBuild.result = "SUCCESS"
     try {
	stage 'Checkout'
		checkout scm   
   
   //stage('GitClone') {
    // prepare version file
    //git url: 'git@github.com:nalinguptalinux/think.git'
    //}
   	stage('Preparation') {
    	// prepare version file
    	sh "scripts/buildtasks/scripts/generate_version_file.sh"
    	}
    	stage('Build') {
        sh "scripts/buildtasks/scripts/build.sh"
    	}
    	stage('Testing') {
        // more testing tasks to be added here
        sh "echo "test wil be here" "
    	}
      }
    catch (err) {

        currentBuild.result = "FAILURE"
        throw err
    }
}
