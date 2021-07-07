#!/bin/zsh
# Shell script to install my zshrc, homebrew, packages, and apps onto macOS

BOTTLES=(awscli git gnupg mas python go wget) # mas is needed to install app store apps
CASKS_NO_INSTALLER=(anki docker postman loopback visual-studio-code dash discord obs)
CASKS_INSTALLER=()
STOREAPPS=( # to find app ids install mas via homebrew then use the command 'mas search <APP NAME>'
    497799835 # Xcode
    634159523 # MainStage
    634148309 # Logic Pro
    424390742 # Compressor
    434290957 # Motion
    424389933 # Final Cut Pro
    1320666476 # Wipr
    824183456 # Affinity Photo
    824171161 # Affinity Designer
)

# Get required files/binaries off the internet
curl -o ~/.zshrc https://gist.githubusercontent.com/ASirolly/5bc954dca52860bf5dab4661bf265a57/raw/6576d883912b2b2df30e885f4a7eb0f0f08c4352/.zshrc
brew --version
if [ $? -eq 0 ]; then
    echo "Homebrew is already installed...\nrunning update and upgrade..."
    brew update
    brew upgrade
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install optional Homebrew bottles
if [ ${#BOTTLES[@]} -ne 0 ]; then
    echo "Installing bottles from Homebrew..."
    sleep 1
    brew install ${BOTTLES[@]}
    echo "Finished downloading bottles.\nSleeping for 3 seconds..."
    sleep 3
else
    echo "No bottles listed to install. Skipping..."
fi

# Install optional Homebrew casks
if [ ${#CASKS_NO_INSTALLER[@]} -ne 0 ]; then
    echo "Installing casks from Homebrew..."
    sleep 1
    brew install --cask ${CASKS_NO_INSTALLER[@]}
    echo "Finished downloading casks.\nSleeping for 3 seconds..."
    sleep 3
else
    echo "No casks (no installer) listed to install. Skipping..."
fi

# Install optional Homebrew casks
if [ ${#CASKS_INSTALLER[@]} -ne 0 ]; then
    echo "Installing casks from Homebrew..."
    sleep 1
    brew install --cask ${CASKS_INSTALLER[@]}
    echo "Finished downloading casks.\nSleeping for 3 seconds..."
    sleep 3
else
    echo "No casks (w/ installer) listed to install. Skipping..."
fi

# Install optional apps from the Mac App Store
mas version
if [ $? -eq 0 ]; then
    if [ ${STOREAPPS[@]} -ne 0 ]; then
        echo "Installing apps from Mac App Store..."
        sleep 1
        echo "Finished downloading App Store apps.\nSleeping for 3 seconds..."
        sleep 3
    else
        echo "No apps listed to install. Skipping..."
    fi
else
    echo "mas not installed. skipping installing App Store apps."
    sleep 3
fi

# Create directories
echo "Creating default directories..."
mkdir ~/Repository
echo "Finished creating directories.\nSleeping for 3 seconds..."
sleep 3

source ~/.zshrc # TODO:// make sure parent shell inherits this
exit 0