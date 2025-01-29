#!/bin/bash
set -e  # Exit if any command fails

# Install Maven
apt-get update && apt-get install -y maven

# Build the project
mvn clean package

