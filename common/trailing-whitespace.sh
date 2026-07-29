#!/usr/bin/env bash

function remove-whitespace {
    # exclude file types
    # (ignore generated files/directories)
    exclude_paths=(
        ".git"
        "student-repository"
        "solution-repository"
    )
    exclude_files=(
        "*.lst"
        "*.map"
        "*.symbols"
        "*.svd"
        "*.sym"
        "*.doc"
        "*.docx"
        "*.ppt"
        "*.pptx"
        "*.uvprojx"
        "*.uvoptx"
        "*.aux"
        "*.fdb_latexmk"
        "*.fls"
        "*.log"
    )

    unset help
    unset silent
    unset no_action
    unset path_args
    unset file_args
    unset ffunix
    unset files
    unset args
    unset arguments

    for arg in "$@"; do
        if [[ "${arg}" =~ ^-[a-zA-Z]{2,}$ ]]; then
            temp=($(echo ${arg} | grep --color=never -o "."))
            args+=(${temp[@]/#/-})
        else
            args+=("${arg}")
        fi
    done

    for arg in "${args[@]}"; do
        [[ "${arg}" != "--" ]] && arguments+=("${arg}")
    done
    unset args

    for arg in "${arguments[@]}"; do
        unset arg_found
        case "${arg}" in
        "-u" | "--unix")
            arg_found="true"
            ffunix="true"
            ;;
        "-h" | "--help")
            arg_found="true"
            help="true"
            ;;
        "-n" | "--no-action")
            arg_found="true"
            no_action="true"
            ;;
        "-s" | "--silent")
            arg_found="true"
            silent="true"
            ;;
        *) ;;
        esac

        if [[ -n "${arg_found}" ]]; then
            continue
        fi

        if [[ -d "${arg}" ]]; then
            path_args+=("${arg}")
            continue
        elif [[ -f "${arg}" ]]; then
            file_args+=("${arg}")
            continue
        fi

        echo "(unrecognised argument: '${arg}')"
    done

    if [[ -n "${ffunix}" ]]; then
        sed_cmd='s/[[:space:]]\+$//'
        grep_regex=$'[[:space:]]+$'
    else
        sed_cmd='s/[[:blank:]]\+\(\r\?\)$/\1/'
        grep_regex=$'[[:blank:]]+\r?$'
    fi

    # compile exclude arguments
    unset excludes
    excludes=("(")

    for n in ${!exclude_paths[@]}; do
        excludes+=("-name" "${exclude_paths[$n]}")
        if ((${n} < ${#exclude_paths[@]} - 1)); then
            excludes+=("-o")
        fi
    done

    excludes+=(")" "-type" "d" "-prune" "-o")

    for arg in "${exclude_files[@]}"; do
        excludes+=("-not" "-name" "${arg}")
    done

    for arg in "${path_args[@]}"; do
        files=("$(
            find "${arg}" \
                "${excludes[@]}" \
                -type f \
                -exec grep -EIq "${grep_regex}" {} \; \
                -print
        )")
    done

    IFS=$'\n'
    files=(${files})
    unset IFS

    for arg in "${file_args[@]}"; do
        grep -EIq "${grep_regex}" "${arg}" && files+=("${arg}")
    done

    if [[ -n "${help}" ]] || [[ -z "${file_args[@]} ${path_args[@]}" ]]; then
        cat <<EOF
Usage: remove-whitespace [-h] [-n] path [path]

Remove trailing whitespace from plain text files.
Path points to either a file or directory, or both.
Directories are searched recursively.
If no paths are provided, the current working
directory is searched.

Options:
  -u, --unix        convert all line endings to unix style
                    line endings
  -h, --help        show this help
  -n, --no-action   do not delete, only detect whitespace
                    this switch forces silent=false
  -s, --silent      suppress output
EOF

        return 0
    fi

    retval=0
    if [[ -z "${files[@]}" ]]; then
        echo "no files with trailing whitespace or dos style line endings found"
        return 0
    else
        retval=1
    fi

    if [[ -z "${no_action}" ]]; then
        for file in "${files[@]}"; do
            if [[ -n "${ffunix}" ]]; then
                sed -i "${sed_cmd}" "${file}"
            else
                sed -i "${sed_cmd}" "${file}"
            fi
        done
    fi

    if [[ -n "${no_action}" ]] &&
        [[ -n "${files}" ]]; then
        tput setaf 1
        tput smso
        echo "The following files contain whitespace:"
        tput sgr0
        for file in "${files[@]}"; do
            echo "${file}"
        done
    elif [[ -z "${silent}" ]] &&
        [[ -n "${files}" ]]; then
        tput setaf 1
        tput smso
        echo "The following files contained whitespace:"
        tput sgr0
        for file in "${files[@]}"; do
            echo "${file}"
        done
    fi

    return ${retval}
}

remove-whitespace "$@"
