# tea: A command line tool to interact with Gitea servers

## Build
- docker build . -t gitea/tea:0.3.0

### Usage
- docker volume create tea
- alias tea='docker run --rm -v tea:/app gitea/tea:0.3.0'
- tea login add -n <name_this_login> -u <your_gitea_url> -t <your_gitea_application_token> -i

#### tea stores its configuration in a file named 'tea.yml', which the above will store on a volume named 'tea' so that it might persist
