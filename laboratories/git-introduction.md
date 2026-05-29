# Git introduction

This document shall serve as both kickstart and reference for beginners.
Though even experienced users may learn something new.

<!--toc:start-->

- [Git instructions](#git-instructions)
  - [Git & Github](#git-github)
  - [Git help](#git-help)
  - [Configuration](#configuration)
  - [Creating a repository](#creating-a-repository)
  - [The concept of commits](#the-concept-of-commits)
  - [Git Terminology](#git-terminology) <!--toc:end-->

## Git & Github

Some might be confused about Git and Github They have similar names,
with Github just adding a ‘hub’.

- **Git** is a version control system, that lets you save, analyse and
  edit the history of files. It can be used locally, or in combination
  with a server. The latter allows for collaboration with a team and can
  act as backup. Git is licensed under GPLv2.
- **Github** is a frontend for the Git server, which adds some functions
  like access control, pull requests or issues to name a few. It is not
  a usable service on its own. Github is proprietary and owned by
  Microsoft since 2018.

## Git help

When unsure about a Git command append `--help`. This opens the most
specific manual available for your command.

Example:

``` sh
# show help for the 'config' subcommand
git config --help

# show help for the 'remote add' subcommand
git remote add --help
```

## Configuration

Before starting too use Git it is recommended to configure the user name
and email at the very least. Otherwise, Git will ask you at the first
action which requires an identity, most probably a `push`.

Git looks for a file `~/.gitconfig` (`~` = users home directory). You
can either (create and) edit the file directly, or use `git config`. See
the example below for how to configure the user name and mail.

    [user]
        name = student
        email = student@students.zhaw.ch

> For Linux users keeping their configuration files in a repository,
> distributing them with symbolic links, the Git configuration can
> include files. So the user and email can be stored in a separate file.
>
>     [include]
>         path = /path/to/include/file

Sensible options to set are the editor used for commit messages, the
default branch name and whether to merge or rebase. The value of editor
is the launch command of the desired editor. Below is an excerpt from my
configuration as an example.

``` git
[core]
    editor = nvim

; i do not care about politics, main is shorter than master
[init]
    defaultBranch = main

[pull]
    rebase = true
```

## Creating a repository

When working with Git server (e.g. Github, Gitlab, Gitea, Forgejo, ..)
there are two ways to start a repository:

- **Local:** Use `git init` to initialise the current directory as a Git
  repository. This will create a directory `.git` which contains the
  local information, e.g. history, commit hashes, hooks, etc. If you
  want to synchronise a local repository with a server, follow the steps
  for creating a remote repository and use `git remote add` to add a
  remote and its URL (default remote name is `origin`).
- **Remote:** Open the frontend of choice and create a new repository.
  On Github there is usually a green button in the top right corner.
  Choose a name, description and licence. Now get the URL to clone the
  repository locally, or set it as remote in an existing one. On Github
  click the green `Code` button and choose either **https** or **ssh**
  (recommended, but requires additional setup).

See examples for the Git commands mentioned in this section below.

``` sh
# initialise directory as git repository
# use '.' as path to initialise current directory
git init <path/to/directory

# add remote to local repository under name 'origin'
git remote add origin <url-to-remote-repository>

# change URL, for example to switch to ssh after cloning
# a repository over https
git remote set-url <remote-name> <remote-url>

# clone a remote repository
git clone <repository-url>
```

> Choosing a licence is important, if only to deny liability for your
> code.

> I recommend to setup a pair of ssh keys and use ssh connections to
> interact with the Git server. It is more secure and usually more
> convenient too.

## The concept of commits

Before looking at how to add or change commits, it is prudent to get an
understanding for how Git works.

A Git history is a linked list of changes, called commits. Each commit
has one (or more for merge commits) parents and an arbitrary number of
children. A commit is a delta relative to its parent(s) and does **not**
contain the current files.

## Git Terminology

| **Term** | **Description** |
|:---|:---|
| head | pointer to commit currently checked out. on remote it will usually point to *main*. |
| index / staging area | `git add` puts file/directories (rather the changes made to them) into a cache, called *index* or *staging area* (in arguments it is also called chache). `git commit` adds the changes in that cache to the history with a hash, a descriptoin and a few more information about the commit. |
