#### User Definition ####
# 				Use this section to define input variables:
#				application name
#				environment_name
#				jsonfile name
#				Important: Please make sure that application/environment/
#						   pipeline names are not the same as exisinting
#						   application/environment/pipelines


application_name=Impulses-Master
environment_name=impulse-master
#pipeline_name=Impulses_deploy_master
jsonfile=file://pipeline_master.json

#### Initializing EBS ####
#				User needs to have awsebcli installed
#				there is no .elasticbeanstalk folder in directory, 
#				aws account does not have a environment with the same name
# working
echo "3\n\n$application_name\nY\n1\nn\nn\n" | eb init -i

#### Creating EBS Environment (EC2 instance) ####
# 				This will host our webserver
# working
eb create $environment_name

#### Create Codepipeline ####
#				This will create an aws codepipeline that connect the
# 				github repo to application environment for deployment
# 				
#				Changes in the github repo will be automatically tracked
aws codepipeline create-pipeline --cli-input-json $jsonfile

#### Terminate #### 
#				terminate ebs application environment (EC2 instance)
#				environment has to be terminated before deleting application
#eb terminate

# 				delete ebs application
# aws elasticbeanstalk delete-application --application-name Impulses-test

#				delete aws codepipeline
# aws codepipeline delete-pipeline --name $pipeline_name
