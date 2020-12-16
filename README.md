## tea: A command line tool to interact with Gitea servers

### Build
- docker build . -t gitea/tea:0.6.0

...or to build a specific release (check [here](https://gitea.com/gitea/tea/releases)):

- export VERSION="<b>0.2.0</b>"
- docker build . -t "gitea/tea:${VERSION}" --build-arg VERSION="${VERSION}"

...alternatively for development version:

- docker build . -t "gitea/tea:latest" --build-arg VERSION="development"

The version of Go used during the build can also be overridden by appending e.g. '--build-arg GOVERSION="<b>1.13.10</b>"'

### Configuration
- docker volume create tea
- alias tea='docker run --rm -v tea:/app -v $PWD:/repo:ro -w /repo gitea/tea:<b><your_release></b>'
- tea login add -n <b><name_this_login></b> -u <b><your_gitea_url></b> -t <b><your_gitea_application_token></b> -i

### Usage
- tea

#### Notes
- tea stores its configuration in a file named 'tea.yml', which the above will store on a volume named 'tea' so that it might persist
- a pre-built [image](https://hub.docker.com/repository/docker/tgerczei/tea) is published via the Docker Hub
