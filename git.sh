# Check the installed Git version
git --version

# Install Git (Debian/Ubuntu)
sudo apt update && sudo apt install git -y

# Install Git (CentOS/RHEL)
sudo yum install git -y

# Configure Git with your name and email
git config --global user.name "Your Name"
git config --global user.email "your_email@example.com"

# Create a new project directory and navigate into it
mkdir my_project
cd my_project

# Initialize a new Git repository
git init

# Create a shell script file and add code to it
touch script.sh
echo "echo Hello, Linux!" > script.sh

# Stage all changes
git add .

# Check the status to see staged or unstaged files
git status

# Commit your changes with a message
git commit -m "First commit: Linux code upload"

# Rename the current branch to main
git branch -M main

# Add a remote repository (replace with your actual GitHub repository URL)
git remote add origin https://github.com/your_username/your_repository.git

# Push your changes to GitHub
git push -u origin main

# Alternatively, you can set the remote URL to a different repository if needed
git remote add origin https://github.com/your_username/my_project.git

# Stage all changes again (if there are any new changes)
git add .

# Verify the remote repository configuration
git remote -v
# Expected output:
# origin  https://github.com/your_username/my_project.git (fetch)
# origin  https://github.com/your_username/my_project.git (push)

# Commit again if needed (this is an extra commit example)
git commit -m "First commit: Linux code upload"
git branch -M main
git remote add origin https://github.com/your_username/your_repository.git
git push -u origin main

# -----------------------------
# Example: Setting Git user information with variables and syncing with a specific repository

# Set your GitHub username and email (replace with your actual values)
GIT_USER="your_username"
GIT_EMAIL="your_email@example.com"
REPO_URL="https://github.com/$GIT_USER/ETL.git"  # Change this URL as needed

# Configure Git globally using the variables
git config --global user.name "$GIT_USER"
git config --global user.email "$GIT_EMAIL"

echo "========== Git initialization and remote setup =========="

# Check if the current directory is already a Git repository; if not, initialize it
if [ ! -d ".git" ]; then
    git init
    git remote add origin "$REPO_URL"
else
    echo "Git repository already initialized."
fi

# Verify that the remote repository is set correctly
git remote -v

echo "========== Adding changes and committing =========="

# Stage all changes
git add .

# Create a commit message with the current date and time
COMMIT_MSG="Update: $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$COMMIT_MSG"

echo "========== Pulling the latest changes from the remote repository =========="

# Pull the latest changes from the remote repository using rebase
git pull origin main --rebase || echo "No updates from remote, continuing."

echo "========== Pushing changes to GitHub =========="

# Push the changes to the remote repository; if push fails, exit with an error message
git push origin main || (echo "Push failed! Resolve conflicts and try again."; exit 1)

echo "GitHub integration complete."
