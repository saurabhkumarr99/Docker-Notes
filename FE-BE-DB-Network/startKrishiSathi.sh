#!/bin/bash

#  chmod +x  startKrishiSathi.sh
#  ./startKrishiSathi.sh


check_docker_image() {
    local image_name="$1"
    local image_count=$(docker images -q "$image_name" | wc -l)
    
    if [ "$image_count" -eq 0 ]; then
        return 0
    else
        return 1
    fi
}


displyDockerVersion() {

  echo "---------------------------------------"
  echo "Checking Docker -v"
  echo "docker -v"
  docker -v
  echo "---------------------------------------"

}

displyImages() {

   echo "---------------------------------------"
   echo "Checking all images"
   echo "docker images"
   docker images
   echo "---------------------------------------"

}

displayContainers() {

    echo "---------------------------------------"
    echo "Checking all containers"
    echo "docker ps -a"
    docker ps -a
    echo "---------------------------------------"

    echo ""

    echo "---------------------------------------"
    echo "Checking all running containers"
    echo "docker ps "
    docker ps 
    echo "---------------------------------------"

}

createKrishiSathidbImage() {
    echo "---------------------------------------"
    echo "Checking mysql image is available"
    
    # check_docker_image "KrishiSathi"
    check_docker_image "mysql"
    local return_value=$?
    
    if [ "$return_value" -eq 0 ]; then
        echo "mysql image is not available in Docker."
        echo ""
        echo "Pulling mysql image " 
        echo "docker pull mysql"
        docker pull mysql
        echo "mysql image pulled"
    else
        echo "mysql image is available in Docker."
    fi
    
    echo "---------------------------------------"
}

createKrishiSathiBackendImage() {
    echo "---------------------------------------"
    echo "Checking krishisathibackend image is available"
    
    # check_docker_image "KrishiSathi"
    check_docker_image "saurabhkumarr99/krishisathibackend:v1.1"
    local return_value=$?
    
    if [ "$return_value" -eq 0 ]; then
        echo "saurabhkumarr99/krishisathibackend:v1.1 image is not available in Docker."
        echo ""
        echo "Pulling saurabhkumarr99/krishisathibackend:v1.1 image " 
        echo "docker pull saurabhkumarr99/krishisathibackend:v1.1"
        docker pull saurabhkumarr99/krishisathibackend:v1.1
        echo "saurabhkumarr99/krishisathibackend:v1.1 image pulled"
    else
        echo "saurabhkumarr99/krishisathibackend:v1.1 image is available in Docker."
    fi
    
    echo "---------------------------------------"
}

createKrishiSathiFrontendImage() {
    echo "---------------------------------------"
    echo "Checking KrishiSathiFrontend image is available"
    
    # check_docker_image "KrishiSathi"
    check_docker_image "saurabhkumarr99/krishisathifrontend:v1.1"
    local return_value=$?
    
    if [ "$return_value" -eq 0 ]; then
        echo "saurabhkumarr99/krishisathifrontend:v1.1 image is not available in Docker."
        echo ""
        echo "Pulling saurabhkumarr99/krishisathifrontend:v1.1 image " 
        echo "docker pull saurabhkumarr99/krishisathifrontend:v1.1"
        docker pull saurabhkumarr99/krishisathifrontend:v1.1
        echo "saurabhkumarr99/krishisathifrontend:v1.1 image pulled"
    else
        echo "saurabhkumarr99/krishisathifrontend:v1.1 image is available in Docker."
    fi
    
    echo "---------------------------------------"
}

startKrishiSathi() {
    echo "---------------------------------------"
    echo ""
    echo "Creating a krishisathi-network network"
    echo "docker network create krishisathi-network"
    docker network create krishisathi-network
    echo ""
    echo "Running the krishisathidb image in krishisathi-network"
    echo "docker run --name mysqlContainer1 --network krishisathi-network -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=krishisathi -d mysql"
    docker run --name mysqlContainer1 --network krishisathi-network -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=krishisathi -d mysql
    echo ""
    echo "Running the krishisathibackend:v1.1 image in krishisathi-network at 8085 port"
    echo "docker run --name krishisathibackendContainer1 --network krishisathi-network -d -p 8085:8085 saurabhkumarr99/krishisathibackend:v1.1"
    sleep 5
    docker run --name krishisathibackendContainer1 --network krishisathi-network -d -p 8085:8085 saurabhkumarr99/krishisathibackend:v1.1
    sleep 4
    echo ""
    echo "Running the krishisathifrontend:v1.1 image  in krishisathi-network at 4200 port"
    echo "docker run --name krishisathifrontendContainer1  -p 4200:80 saurabhkumarr99/krishisathifrontend:v1.1"
    echo ""
    echo "Go to localhost:4200"
    echo "Admin password is admin"
    echo "All otp will be display at console."
    echo ""
    docker run --name krishisathifrontendContainer1  -p 4200:80 saurabhkumarr99/krishisathifrontend:v1.1
    echo "---------------------------------------"
    
}


stopKrishiSathiContainers() {
    echo "---------------------------------------"
    echo "Stopping the mysqlContainer1 krishisathibackendContainer1 containers"
    echo "docker stop krishisathibackendContainer1 mysqlContainer1"
    docker stop krishisathibackendContainer1 mysqlContainer1
    echo ""
    echo "Removing the mysqlContainer1 krishisathibackendContainer1 krishisathifrontendContainer1"
    echo "docker rm mysqlContainer1 krishisathibackendContainer1 krishisathifrontendContainer1"
    docker rm mysqlContainer1 krishisathibackendContainer1 krishisathifrontendContainer1
    echo ""
    echo "Removing the network"
    echo "docker network rm krishisathi-network"
    docker network rm krishisathi-network
    echo "---------------------------------------"
}

echo ""
displyDockerVersion
echo ""

echo ""
displyImages
echo ""

echo ""
displayContainers
echo ""

echo ""
createKrishiSathidbImage
createKrishiSathiBackendImage
createKrishiSathiFrontendImage
echo ""

echo ""
displyImages 
echo ""

echo ""
displayContainers
echo ""

echo ""
startKrishiSathi
echo ""

echo ""
displayContainers
echo ""

echo ""
stopKrishiSathiContainers
echo ""

echo ""
displyImages
echo ""

echo ""
displayContainers
echo ""