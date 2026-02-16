FROM nginx:alpine

# Instalamos git para poder bajar el código
RUN apk add --no-cache git

# Borramos la web por defecto de nginx
RUN rm -rf /usr/share/nginx/html/*

# Clonamos el juego 2048 directamente en la carpeta pública
RUN git clone https://github.com/gabrielecirulli/2048.git /usr/share/nginx/html