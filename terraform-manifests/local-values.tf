locals {
  instance_configurations = [
  {
    name         = "Jenkins-Server"
    instance_type = "t3.micro"
    user_data    = file("./scripts/JenkinsServerInstallation.sh")
  },
  {
    name         = "Nexus-Server"
    instance_type = "t2.medium"
    user_data    = file("./scripts/NexusInstallation.sh")
  },
  {
    name         = "Sonarqube-Server"
    instance_type = "t2.medium"
    user_data    = file("./scripts/SonarqubeInstallation.sh")
  }
]

  common_tags = {
      owner = "Ashutosh"
      environment = "Dev"
  }
}