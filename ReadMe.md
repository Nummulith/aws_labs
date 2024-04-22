### Readme

## Preparation

Create lab_get function to start working with labs:

```
lab_get() {
    sudo curl -fsSL  -H 'Cache-Control: no-cache, no-store' "https://raw.githubusercontent.com/Nummulith/linux_labs/main/$1/$1.sh" -o "/usr/local/bin/$1.sh"
    sudo chmod +x "/usr/local/bin/$1.sh"
}
```

## Running the lab

Download labs from the repository and run it

```
lab_get hello_world
hello_world.sh
```

## See the output of the lab

```
hello world!
```
