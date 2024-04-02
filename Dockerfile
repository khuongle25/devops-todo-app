FROM node:14 
WORKDIR /user/src/app
COPY package*.json app.js ./
COPY views ./views
RUN npm install
EXPOSE 8000
CMD ["node", "app.js"]
