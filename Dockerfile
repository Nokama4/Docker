# Base Image
FROM node:lts-alpine3.11

# Install git
USER root
RUN apk add --no-cache git openssh-client

# Create user
# USER node

# Create new directory for the app
RUN mkdir -p /home/node/app && chown -R root:root /home/node/app
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
WORKDIR /home/node/app

# Copy the project in the current dir
COPY --chown=root:root . .

# Install dependencies
RUN --mount=type=ssh ssh-add -l && yarn

# build the app
RUN ["yarn", "build"]

# Expose the port
EXPOSE 3000

# Launch the fixture task
CMD ["yarn", "start"]
