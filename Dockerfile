# Base Image
FROM node:lts-alpine3.11
ARG SSH_KEY

# Install git
USER root
RUN apk add --no-cache git openssh-client
# RUN eval $(ssh-agent -s) && ssh-add /home/node/.ssh/id_rsa
# RUN ssh-add -l

# Create user
# USER node


# Create new directory for the app
RUN mkdir -p /home/node/app && chown -R root:root /home/node/app
RUN mkdir -p /home/node/.ssh && chown -R root:root /home/node/.ssh && ssh-keyscan github.com >> /home/node/.ssh/known_hosts
WORKDIR /home/node/app

# Copy the project in the current dir
COPY --chown=root:root . .

# RUN --mount=type=ssh ssh-add -l
# console log id_rsa.pub
# RUN eval $(ssh-agent -s) && ssh-add -l
RUN --mount=type=ssh ssh-add -l && yarn

# build the app

RUN ["yarn", "build"]

# Expose the port
# EXPOSE 3000

# Launch the fixture task
CMD ["yarn", "start"]
