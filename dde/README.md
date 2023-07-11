# dde

Docker Development Environment (DDE) and associated tooling

The goal of this project is to make creating and distributing development
environments easy. It uses Docker and D9 Nexys to build, package, serve, and use
docker images which encapsulate all aspects of a project's development.

## Usage
### Setting up a project
```bash
git clone git@g99-gitlab:g99_common/dde.git
cd dde
./install # Install artifacts to /opt/g99_common/dde
cd <path_to_my_project>/<my_project>
cp /opt/g99_common/dde/template/* .
mv template <my_project>
$EDITOR <my_project> # Make requisite edits, details in file
mv setup_template setup_<my_project>
$EDITOR setup_<my_project> # Add all setup commands required for the environment
./<my_project> # Should build your image and enter the container
```

### Using DDE commands
```
Available options are:
    -h  | --help            Prints help information.

    -r  | --rebuild         Rebuild the environment.

    -t  | --tag             Specify the image tag to target instead of 'latest'.

    -x  | --execute         Execute a given command inside of a container. 
                                  Will likely want to prepend '-c'.

    -R | --remote           Spawn a container which is detached and listening on the
                                  specified port for ssh requests.

    -s  | --ssh             ssh into a container at the specified port.

    -p  | --push            Push the image to the remote repository.
```

Whenever changes are made to the setup script, the image will need to be
rebuilt. Using the -r will perform the rebuild using the updated setup scripts.

For instances where you want different build environments for the same project
(adding new dependencies in a branch, archiving old environments, etc) you can
use the -t option to tag an image and use it later without overwriting the main
"latest" tag.

To execute a specific command within the environment without needing to first
open a shell into the environment, use the -x option. For example:
```bash
my_project -x "cd build && make"
```

TODO: Jake, fill in the rest of the things that you added