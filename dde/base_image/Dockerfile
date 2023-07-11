ARG BASE_IMAGE="ubuntu:focal"
FROM ${BASE_IMAGE}

ARG USER="ubuntu"
ARG ENTRYPOINT="entrypoint.sh"

ENV USER=$USER

# Handle MIT LL Proxy
COPY apt.conf /etc/apt/
COPY environment /etc/environment

# Avoid TZ selection prompt during build process.
ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

# Install baseline packages.
RUN apt update && apt install -y  \
  sudo                            \
  iputils-ping                    \
  git                             \
  vim                             \
  cmake                           \
  python3                         \
  python3-pip                     \
  ssh                             \
  gdb                             \
  rsync 
# Ubuntu uses multiples of the user id(uid) for some logging. If a large uid is 
#   given then there will be a massive range of log entries generated for each uid.
#   This can cause some system logs to baloon to hundreds of gigs. 
#   This is why the --no-log-init option is used. It prevents massive system
#   logs from being generated if a large uid is given.
RUN useradd --no-log-init -ms /bin/bash ${USER} && echo ${USER}:${USER} | chpasswd && adduser ${USER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

# entrypoint is dangerous if executed accidentally 
# so it should not be executable by default.
copy ${ENTRYPOINT} /
RUN chmod a+x /${ENTRYPOINT}
ENTRYPOINT ["/entrypoint.sh"]
