# ==============================================================================
# Back end specific installation
# ==============================================================================

echo_h2 "Installing ssh forwarder for docker"

git clone git://github.com/abrugh/docker-ssh-agent-forward /tmp/docker-ssh
cd /tmp/docker-ssh || return
make
make install
cd - || return
