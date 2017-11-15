call mvn clean package -Dmaven.test.skip=true -Pproduction
copy .\target\ROOT.war
@echo on
echo 'Build project successfully!'