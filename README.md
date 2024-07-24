# `upstream`

`upstream` is a command trying to report the git repository for a given (RPM) package.
The command uses https://repology.org/project as the information source.
The heuristics used in the command is partially taken from
[repology-updater/repology/parsers/parsers/gentoo.py](https://github.com/repology/repology-updater/blob/master/repology/parsers/parsers/gentoo.py).

## requirements
`upstream` requires `bash`, `xsltproc`, and `curl` commands.
They are available as packages on Fedora: `dnf install bash xsltproc curl`.

## usage
```
	$ ./upstream Q pkg
```

Example session:
```
$ ./upstream Q kernel; echo $?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
0
$ ./upstream Q podman; echo $?
https://github.com/containers/podman.git
0
$ ./upstream Q ansible; echo $?
https://github.com/ansible/ansible.git
0
$ ./upstream Q gcc; echo $?
git://gcc.gnu.org/git/gcc.git
0
$ ./upstream Q bash; echo $?
https://git.savannah.gnu.org/git/bash.git
0
$ ./upstream Q glibc; echo $?
https://sourceware.org/git/glibc.git
0
$ ./upstream Q no-such-pkg; echo $?
2
```

If `upstream` can report a repository, it exits with 0.  NOTE: the exit
status is nothing to do with the correctness of the information.

If `upstream` cannot report a repository, it exits ewith 2.
1 represents the other errors.

## testing

`t_upstream.bash` is a script for testing `upstream` command.
