# drone-s3cache

Drone plugin for caching build artefacts in S3 


This plugin allows for caching build artefact directories containing external libraries, packages, etc in S3 which should speed up build process. Cache is currently keyed by repository name e.g. `<repo_org>/<repo_name>`.

## Configuration

The following parameters are used to configure the plugin:

- `mode`: defines the mode of operation. Possible values `pull`, `push`.
- `folders`: list of local project directories to be cached in S3, e.g.:
```
folders: 
  - node_modules
  - folder1
  - folder2/foo
```

- `bucket`: S3 bucket name. Ensure drone has permissions to `get` and `put` objects in that bucket.
- `filename`: The filename to pull or push to S3. Default is `cache`.
- `key`: The key to pull or push to S3. Default is `$DRONE_REPO/$DRONE_BRANCH`.

This plugin assumes you have Drone setup on an AWS EC2 instance, with an IAM instance profile.

### Drone configuration example

```yaml
pipeline:
  cache-pull:
    image: robertstettner/drone-s3cache
    bucket: mybucket
    mode: pull

  build:
    image: node
    commands:
      - npm install
      - npm prune

  cache-push:
    image: robertstettner/drone-s3cache
    bucket: mybucket
    folders: node_modules
    mode: push
```

### Local Test

```
docker run -t --rm \
  -e PLUGIN_BUCKET=mybucket \
  -e PLUGIN_REGION=eu-central-1 \
  -e DRONE_REPO=myorg/octocat \
  -e DRONE_BRANCH=master \
  -e PLUGIN_MODE=pull \
  -v $(pwd):/app \
  -w /app \
  robertstettner/drone-s3cache
```