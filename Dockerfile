FROM node:alpine AS builder
WORKDIR '/app'
# RUN npm config set proxy http://proxy-web.micron.com:80
# RUN npm config set https-proxy http://proxy-web.micron.com:80
# RUN npm set strict-ssl false
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html