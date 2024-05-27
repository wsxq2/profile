color_echo()
{
    local color
    color="$1"
    shift
    echo -e '\033['"$color"'m'"$@"'\033[0m'
}
green()
{
    color_echo '1;32' "$@"
}
blue()
{
    color_echo '0;36' "$@"
}
yellow()
{
    color_echo '1;33' "$@"
}
red()
{
    color_echo '1;31' "$@"
}

wait_host_service(){
    local ip port timeout interval count max_count
    ip="${1:-192.168.125.77}"
    port="${2:-22}"
    timeout="${3:-600}"
    interval="${4:-10}"
    green "waiting for $ip:$port to be available: timeout=$timeout, interval=$interval"
    max_count=$((timeout/interval))
    count=0
    while ! timeout $interval bash -c "</dev/tcp/$ip/$port" &>/dev/null; do
        [[ $count -ge $max_count ]] && break
        count=$((count+1))
    done
    if [[ $count -ge $max_count ]];then
        red "timeout"
        return 1
    else
        green "cost $((count*interval))s"
        return 0
    fi
}

cp_one_file(){
    local src dst be_overwrited
    src="$(realpath -m $1)"
    dst="$(realpath -m $2)"
    if [[ ! -f "$src" ]]; then
        red "cp_one_file: src file '$src' not exist"
        return 1
    fi
    if [[ -d $dst ]]; then
        if [[ $(dirname $src) == $dst ]]; then
            yellow "cp_one_file: skip the same file '$src'"
            return 0
        fi
        be_overwrited=$dst/$(basename $src)
        if [[ -f $be_overwrited ]]; then
            yellow "cp_one_file: will overwrite the '$be_overwrited' file"
        fi
    else
        if [[ -f $dst ]]; then
            if [[ $src == $dst ]];then
                yellow "cp_one_file: skip the same file '$src'"
                return 0
            else
                yellow "cp_one_file: will overwrite the '$dst' file"
            fi
        else
            if [[ ! -d $(dirname $dst) ]]; then
                red "cp_one_file: dst dir '$(dirname $dst)' not exist"
                return 1
            fi
        fi

    fi

    \cp -vf "$src" "$dst"
}

random_string()
{
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1
}

get_uuid(){
    cat '/proc/sys/kernel/random/uuid'
}

random_port(){
    port=`echo -n $(( ( RANDOM % 40000 )  + 10000 ))`
    while [[ -n `ss -tuln | grep $port` ]]; do
        port=`echo -n $(( ( RANDOM % 40000 )  + 10000 ))`
    done
    TO_BE_OPENED_PORTS+=($port)
    echo -n "$port"
}

