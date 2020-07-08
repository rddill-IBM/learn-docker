# download image
FROM node:10

# set up image
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install
COPY . .
# identify port
# EXPOSE [port in container]/[protocol]
# this is documentation only and identifies what ports the 
# container is expected to present
# ports are actually made available through the -p option on 
# docker run command
EXPOSE 6001/tcp

# set start command
CMD ["npm", "start"]