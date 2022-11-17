#!/bin/bash

PORT_DB=27018
PORT_REDIS=6379

start_mongodb() {
  docker run --rm -d --name mongodb_local\
    -e MONGO_INITDB_ROOT_USERNAME=root \
    -e MONGO_INITDB_ROOT_PASSWORD=123456 \
    -p 27018:27017 \
    mongo:4.4

  echo "mongodb started on port ${PORT_DB}"
  echo
}

start_redis() {
  echo "Starting redis on port ${PORT_REDIS}..."
  # check first if minio running to avoid errors
  count_proc=$(docker ps | grep redis-stack-server | wc -l)
  if [ "$count_proc" -ne "0" ]; then
      docker container kill redis || true
  fi
  # check first if this container exists locally to avoid error message
  count_proc=$(docker container list -all | grep redis-stack-server | wc -l)
  if [ "$count_proc" -ne "0" ]; then
      docker container rm redis || true
  fi

  docker run --rm -d --name redis_local -p ${PORT_REDIS}:${PORT_REDIS} redis

  echo "redis started on port ${PORT_REDIS}"
  echo
}

start() {
    dbId=`lsof -ti :$PORT_DB | xargs echo $1` 
    if [[ "$dbId" == "" ]]; then
      echo "No MongoDB running"
      echo "MongoDB Starting..."
      start_mongodb
    else
      echo "MongoDB is running on port : $PORT_DB" 
    fi
    echo

    redisId=`lsof -ti :$PORT_REDIS | xargs echo $1` 
    if [[ "$redisId" == "" ]]; then
      echo "No Redis running"
      echo "Redis Starting..."
      # brew services start redis
      start_redis
    else
      echo "Redis is running on port : $PORT_REDIS" 
    fi
    echo
}

case "$1" in
start)
  start
  ;;
stop)
  stop
  ;;
start_mongodb)
  start_mongodb
  ;;
start_redis)
  start_redis
  ;;
*)
echo "Usage: $0 {start|stop|secret}" >&2
  echo "Example: ./services.sh start " >&2
  exit 1
  ;;
esac