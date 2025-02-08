# Используем официальный образ NGINX в качестве базового
FROM nginx:alpine

# Удаляем дефолтный файл конфигурации NGINX
RUN rm /usr/share/nginx/html/index.html

# Копируем все файлы из папки dist в папку с HTML файлами NGINX
COPY dist/ /usr/share/nginx/html/

# Экспонируем порт 80
EXPOSE 80

# Запускаем NGINX
CMD ["nginx", "-g", "daemon off;"]