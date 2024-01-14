# Kafka Docker Setup

This repository provides a Docker Compose setup for running Apache Kafka in containers. It includes a primary file for Kafka setup and another for creating a Kafka topic.

## Prerequisites

Before you begin, make sure you have Docker and Docker Compose installed on your machine. You can download and install Docker from the official website: [Docker](https://www.docker.com/get-started).

## Setup Kafka

1. Navigate to the project directory.

2. Run the following command to start Kafka and Zookeeper containers:

    ```bash
    docker-compose -f docker-compose-kafka.yml up -d
    ```

    This command reads the `docker-compose-kafka.yml` file and starts the Kafka and Zookeeper containers in detached mode.

3. Wait for the containers to start. You can check the logs using:

    ```bash
    docker-compose -f docker-compose-kafka.yml logs -f
    ```

    Press `Ctrl + C` to exit the log view.

## Create a Kafka Topic

To create a Kafka topic, follow these steps:

1. Navigate to the project directory.

2. Run the following command to create a topic:

    ```bash
    docker-compose -f docker-compose-create-topic.yml up
    ```

    This command reads the `docker-compose-create-topic.yml` file and creates a specified topic. Make sure to replace `your_topic_name` with the desired topic name.

## Additional Commands

### View Kafka Container Logs

```bash
docker-compose -f docker-compose-kafka.yml logs -f
