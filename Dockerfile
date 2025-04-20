FROM instrumentisto/flutter:3.29.2 AS builder
WORKDIR /app

COPY . .

RUN flutter pub get

ARG API_URL
RUN flutter build web --dart-define=API_URL=${API_URL}

RUN flutter build web --release --dart-define=FLUTTER_WEB_USE_SKIA=true  

FROM nginx:latest

RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080
 
CMD [ "nginx", "-g", "daemon off;" ]
