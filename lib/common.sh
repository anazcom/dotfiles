# Colors for terminal output
YELLOW=$'\033[0;33m'  
GREEN=$'\033[0;32m'   
RED=$'\033[0;31m'     
PURPLE=$'\033[0;35m'  
RESET=$'\033[0m'      
BLUE=$'\033[0;34m'    
BLACK=$'\033[0;30m'   
CYAN=$'\033[0;36m'    

warning() {
    local message=$1
    echo "WARNING: ${YELLOW}$message${RESET}"
    return 1
}

error() {
    local message=$1
    echo "ERROR: ${RED}$message${RESET}" >&2
    return 1
}

info() {
    local message=$1
    echo "INFO: $message"
    return 0
}

success() {
    local message=$1
    echo "SUCCESS: ${GREEN}$message${RESET}"
    return 0
}

require() {

    name="$1"
    value="${!name}"

    if [ -z "$value" ]; then
        error "$name is not set or empty."
        exit 1
    fi
}