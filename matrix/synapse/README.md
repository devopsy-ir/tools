## Init Synapse
```
docker run -it --rm --mount type=volume,src=infra_synapse_data,dst=/data -e SYNAPSE_SERVER_NAME=insa.lr -e SYNAPSE_REPORT_STATS=no docker.insa.lr/matrixdotorg/synapse:v1.98.0 generate
```

## Register Admin user
```
docker compose exec synapse register_new_matrix_user -u admin -p admin -a -c /data/homeserver.yaml http://localhost:8008
```
