### Readme

Run lab_init.sh (or its content) to start working with labs

Then download labs from the repository and run it


## Example

lab_get() {
    
    sudo curl -fsSL "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1.sh" -o "/usr/local/bin/$1.sh"

    sudo chmod +x "/usr/local/bin/$1.sh"

}

lab_get helloworld

helloworld.sh
