# todoparser.sh

A simple utility to find TODO comments in files.

## Usage

Download and `cd` into folder, then make `todoparser.sh` executable.

```shell
chmod u+x todoparser.sh
```

Copy `todoparser.sh` to `/usr/local/bin`.

```shell
cp todoparser.sh /usr/local/bin
```

Create `alias` in `.zshrc` (or whatever).

```shell
alias todo=/usr/local/bin/todoparser.sh
```

Reload.

```shell
source ~/.zshrc
```

Run.

```shell
todo
```

## .todoignore

Create `.todoignore` to ignore files.

```
.DS_Store
.gitignore
.gitattributes
example.png

```

## Example

```python
# TODO: this is a todo
```

![example.png](example.png)

