#!/bin/bash
set -e

echo ">>>>>>> copying a correct compose file <<<<<<<"
scp -o "StrictHostKeyChecking no" docker/docker-compose.${PROJECT_PROFILE}.yml \
    ${REMOTE_USER}@${REMOTE_HOST}:${PROJECT_DIR}/docker-compose.yml

scp -o "StrictHostKeyChecking no" .env \
    ${REMOTE_USER}@${REMOTE_HOST}:${ENV_DIR}/

echo "copy done!"


COMPOSE_OPTS="-f ./docker-compose.yml -p test_devops_${PROJECT_PROFILE}"


echo ">>>>>>> starting containers on the remote server <<<<<<<"
ssh ${REMOTE_USER}@${REMOTE_HOST} -o "StrictHostKeyChecking no" << EOF
    cd ${PROJECT_DIR}

    echo ">>>>>>> docker-compose pull/down/up <<<<<<<"
    docker-compose ${COMPOSE_OPTS} pull
    docker-compose ${COMPOSE_OPTS} down
    docker-compose ${COMPOSE_OPTS} up -d

    #echo ">>>>>>> Remove trash <<<<<<<"
    docker volume ls -qf dangling=true | xargs -r docker volume rm
    docker images --filter "dangling=true" -q --no-trunc | xargs -r docker rmi
    docker images | grep "none" | awk '/ / { print $3 }' | xargs -r docker rmi
EOF

echo "Done!"
exit 0
