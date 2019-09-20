 #!/bin/bash

PS4='+ $(date +"%F %T%z") ${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'

#set -xue
set -x


VERSION="release-v"

AP_PROJECT="ci-cd-demo"
AP_REGISTRY="skycitygalaxy"
AP_NAMESPACE="ci-cd-demo"


cd "$(dirname $0)"
basedir="$(dirname $(pwd))"
cd ${basedir}



docker_build() {
    git log -n 1|head -3                     >  VERSION
    echo -e "Build:\t$(date '+%F %T')"       >> VERSION
    echo -e "Branch:\t$(git branch|grep ^*)" >> VERSION

    docker images | grep ${AP_PROJECT} | awk '{print $3}' | xargs docker rmi  -f
    docker-compose -f provisioning/docker-compose-maven.yml run --rm maven
    docker-compose build
}


docker_push() {
    tag="$1"
    [[ "$tag" == "" ]] && tag="${VERSION}-$(git rev-parse --short HEAD)"
    for i in $(docker images | grep "${AP_REGISTRY}/${AP_NAMESPACE}" | awk '{print $1}');
    do
        docker tag ${i} ${i}:${tag};
        docker push $i:${tag};
        docker push $i;
        docker rmi $i:${tag};
    done
}


docker_$1



