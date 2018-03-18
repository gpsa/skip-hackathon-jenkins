# skip-hackathon-jenkins

- Import the examples make your own changes.
- Remember to create your own Git/GitLab/GitHub project for doing your tests.
- Chanage the repository configurations after you import de Job.

## Import the job that will work and make the branch master merge
java -jar jenkins-cli.jar -s http://server create-job skip-hackathon-working < examples/skip-hackathon.xml

## Import the job that will force the build not to work
java -jar jenkins-cli.jar -s http://server create-job skip-hackathon-not-working < examples/skip-hackathon-force-error.xml

