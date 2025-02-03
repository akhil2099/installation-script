#!/bin/bash

# Define colors for better visibility
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# Function to print messages
print_success() { echo -e "${GREEN}[✔] $1${RESET}"; }
print_error() { echo -e "${RED}[✘] $1${RESET}"; }
print_info() { echo -e "${BLUE}[ℹ] $1${RESET}"; }
print_warning() { echo -e "${YELLOW}[⚠] $1${RESET}"; }

# Check if the script is run as root, if not, prompt for sudo
if [[ $EUID -ne 0 ]]; then
    if ! sudo -n true 2>/dev/null; then
        print_error "You must be a sudoer to run this script. Exiting."
        exit 1
    fi
    sudo -v
fi
# Ask the user which development environment they want to set up
echo -e "${YELLOW}Which development environment do you want to set up?${RESET}"
options=("Python" "Java" "Node.js")
select opt in "${options[@]}"; do
    case $opt in
        "Python")
            choice=1
            break
            ;;
        "Java")
            choice=2
            break
            ;;
        "Node.js")
            choice=3
            break
            ;;
        *)
            print_error "Invalid option. Please enter a valid number."
            ;;
    esac
done

print_info "Updating system packages..."
sudo apt update -y && sudo apt upgrade -y

if [[ "$choice" == "1" ]]; then
    print_info "Setting up Python development environment..."

    print_info "Installing Python and essential build tools..."
    sudo apt install -y python3 python3-pip python3-venv python3-dev build-essential

    print_info "Installing version control tools..."
    sudo apt install -y git

    print_info "Installing virtual environment & package management tools..."
    pip3 install --upgrade pip virtualenv pipenv poetry

    print_info "Installing code quality & linting tools..."
    pip3 install black flake8 pylint mypy isort

    print_info "Installing debugging & testing tools..."
    pip3 install pytest pytest-cov tox

    print_info "Installing API development & web frameworks..."
    pip3 install flask django fastapi uvicorn

    print_info "Installing database connectors & ORM..."
    pip3 install sqlalchemy psycopg2-binary pymysql sqlite3

    print_info "Installing automation & scripting tools..."
    pip3 install fabric ansible pyautogui

    print_info "Installing data science & ML tools..."
    pip3 install numpy pandas matplotlib seaborn scikit-learn jupyterlab

    print_info "Installing performance monitoring & profiling tools..."
    pip3 install py-spy memory_profiler

    print_info "Installing security & static analysis tools..."
    pip3 install bandit safety

    print_info "Installing containerization & deployment tools..."
    sudo apt install -y docker.io docker-compose
    pip3 install awscli

elif [[ "$choice" == "2" ]]; then
    print_info "Setting up Java development environment..."

    print_info "Installing Java Development Kit (JDK)..."
    sudo apt install -y openjdk-17-jdk openjdk-17-jre

    print_info "Installing Maven & Gradle (build tools)..."
    sudo apt install -y maven gradle

    print_info "Installing Git for version control..."
    sudo apt install -y git

    print_info "Installing code quality & linting tools..."
    sudo apt install -y checkstyle

    print_info "Installing debugging & testing tools..."
    sudo apt install -y junit

    print_info "Installing database connectors..."
    sudo apt install -y mysql-client postgresql-client

    print_info "Ensuring Snap is installed..."
    sudo apt install -y snapd

    print_info "Installing IntelliJ IDEA..."
    sudo snap install --classic intellij-idea-community

    print_info "Installing containerization & deployment tools..."
    sudo apt install -y docker.io docker-compose
    sudo snap install kubectl --classic
    sudo snap install helm --classic

elif [[ "$choice" == "3" ]]; then
    print_info "Setting up Node.js development environment..."

    print_info "Installing Node.js and npm..."
    sudo apt install -y nodejs npm

    print_info "Installing Yarn package manager..."
    npm install -g yarn

    print_info "Installing version control tools..."
    sudo apt install -y git

    print_info "Installing TypeScript..."
    npm install -g typescript

    print_info "Installing code quality & linting tools..."
    npm install -g eslint prettier

    print_info "Installing debugging & testing tools..."
    npm install -g jest nodemon

    print_info "Installing popular Node.js frameworks..."
    npm install -g express next react vue angular

    print_info "Installing database connectors..."
    npm install -g knex pg mysql sqlite3

    print_info "Installing containerization & deployment tools..."
    sudo apt install -y docker.io docker-compose
    npm install -g pm2 @nestjs/cli
fi

print_info "Installing useful CLI utilities..."
sudo apt install -y curl wget unzip tree htop jq

print_info "Cleaning up..."
sudo apt autoremove -y
sudo apt clean

print_success "Development environment setup complete! 🎉"

# Display installed versions
if [[ "$choice" == "1" ]]; then
    python3 --version
    pip3 --version
elif [[ "$choice" == "2" ]]; then
    java -version
    mvn -version
elif [[ "$choice" == "3" ]]; then
    node -v
    npm -v
fi

