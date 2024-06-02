### This is an alias to compile C code with jsut cc filename
```
cc() {
    gcc "$1" -o "${1%.c}.exe" && ./"${1%.c}.exe"
}
```
